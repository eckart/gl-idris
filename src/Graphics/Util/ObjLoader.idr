module Graphics.Util.ObjLoader

import Control.Monad.Identity

import Data.SortedMap as M

import Lightyear.Core
import Lightyear.Combinators
import Lightyear.Strings


%access private

Vertex : Type
Vertex = Vect 3 Double

vtx : Double -> Double -> Double -> Vertex
vtx x y z = x :: y :: z :: [] 

UV : Type
UV = Vect 2 Double

uv : Double -> Double -> UV
uv u v = u :: v :: [] 

Index : Type
Index = (Int, Int, Int)                  

public
data ObjModel : Type where
  MkObjModel :  List (Vect 3 Double) -- positions
          -> List (Vect 2 Double) -- texture coordinates / UVs
          -> List (Vect 3 Double) -- normals
          -> List Int             -- indices
          -> ObjModel

abstract
data ObjLine
  = Position Vertex
  | TextureCoord UV
  | Normal Vertex
  | Face Index Index Index
  | Comment String
  | Ignored String
  
  
instance Show ObjLine where
  show (Position v)       = "Position " ++ (show v)
  show (TextureCoord uv)  = "TextureCoord " ++ (show uv)
  show (Normal v)         = "Normal " ++ (show v)
  show (Face v1 v2 v3)    = "Face " ++ (show v1) ++ " " ++ (show v2) ++ " " ++ (show v3)
  show (Comment s)        = "Comment " ++ s
  show (Ignored s)        = "Ignored " ++ s
  
-- ------------------------------------------------------------------ [ Tokens ]

notEol : Monad m => ParserT m String Char
notEol = satisfy (\s => not (isNL s))

eol : Monad m => ParserT m String Char
eol = satisfy (\s => not (isNL s))

-- ---------------------------------------------------------- [ Double Parser ]
-- borrowed wholesale from https://github.com/ziman/lightyear/blob/master/examples/Json.idr
--
record Scientific where
  constructor MkScientific
  coefficient : Integer
  exponent : Integer

scientificToFloat : Scientific -> Double
scientificToFloat (MkScientific c e) = fromInteger c * exp
  where exp = if e < 0 then 1 / pow 10 (fromIntegerNat (- e))
                       else pow 10 (fromIntegerNat e)

parseScientific : Parser Scientific
parseScientific = do sign <- maybe 1 (const (-1)) `map` opt (char '-')
                     digits <- some digit
                     hasComma <- isJust `map` opt (char '.')
                     decimals <- if hasComma then some digit else pure Prelude.List.Nil
                     hasExponent <- isJust `map` opt (char 'e')
                     exponent <- if hasExponent then integer else pure 0
                     pure $ MkScientific (sign * fromDigits (digits ++ decimals))
                                         (exponent - cast (length decimals))
  where fromDigits : List (Fin 10) -> Integer
        fromDigits = foldl (\a, b => 10 * a + cast b) 0

double : Parser Double
double = map scientificToFloat parseScientific

-- ---------------------------------------------------------- [ OBJ Format ]

position : Parser ObjLine 
position = do token "v"
              x <- lexeme double
              y <- lexeme double
              z <- lexeme double
              pure $ Position $ vtx x y z

normal : Parser ObjLine 
normal = do token "vn"
            x <- lexeme double
            y <- lexeme double
            z <- lexeme double
            pure $ Normal $ vtx x y z

textureCoord : Parser ObjLine 
textureCoord= do token "vt"
                 u <- lexeme double
                 v <- lexeme double
                 pure $ TextureCoord $ uv u v

faceVertex : Parser (Int, Int, Int)
faceVertex = do vertexIdx <- integer
                char '/'
                textureIdx <- integer
                char '/'
                normalIdx <- integer
                pure $ (vertexIdx, textureIdx, normalIdx)

face : Parser ObjLine
face = do token "f"
          (v3 :: v2 :: v1 :: []) <- ntimes 3 (lexeme faceVertex)
          pure $ Face v1 v2 v3

ignored : Parser ObjLine
ignored = do cont <- (many notEol) <?> "ignored"
             pure $ Ignored (cast cont)
                
comment : Parser ObjLine
comment = do string "#"
             cont <- many notEol
             pure $ Comment $ cast cont
             
line : Parser ObjLine
line = position <|> normal <|> textureCoord <|> face <|> comment <|> ignored

parseLine : String -> List ObjLine
parseLine input = case parse line input of
  Left  e => [] -- ignore Errors for now
  Right x => [x]
  
processLines : List ObjLine -> (List Vertex, List Vertex, List UV, List Index)
processLines lines = processLines' lines [] [] [] []
                   where processLines' : List ObjLine
                                       -> List Vertex -- positions
                                       -> List Vertex -- normals
                                       -> List UV     -- UVs / TextureCoordinates
                                       -> List Index -- indices
                                       -> (List Vertex, List Vertex, List UV, List Index)
                         processLines' []         pos norm uvs ind = (reverse pos, reverse norm, reverse uvs, reverse ind)
                         processLines' (l :: ls)  pos norm uvs ind = case l of
                           Position v      => processLines' ls (v :: pos)       norm        uvs                     ind 
                           Normal v        => processLines' ls       pos  (v :: norm)       uvs                     ind 
                           TextureCoord uv => processLines' ls       pos        norm (uv :: uvs)                    ind 
                           Face i1 i2 i3   => processLines' ls       pos        norm        uvs  (i1 :: i2 :: i3 :: ind)
                           _               => processLines' ls       pos        norm        uvs                     ind
      
                                                                  
                                                                                                                              
mapByIndex : List a -> M.SortedMap Int a
mapByIndex xs = mapByIndex' (cast $ (length xs) - 1) empty (reverse xs)
                where mapByIndex' : Int -> SortedMap Int a -> List a -> SortedMap Int a
                      mapByIndex' _ s        [] = s
                      mapByIndex' i s (x :: xs) = mapByIndex' (i-1) (insert i x s) xs

record VertexData where
  constructor MkData
  position : Vertex
  uv       : UV
  normal   : Vertex


getData : Index 
          -> M.SortedMap Int Vertex
          -> M.SortedMap Int Vertex
          -> M.SortedMap Int UV
          -> Maybe VertexData
getData (p,t,n) positions normals uvs = do
  position <- lookup (p-1) positions
  normal   <- lookup (n-1) normals
  uv       <- lookup (t-1) uvs
  pure $ MkData position uv normal

-- input is: a list of indices (triples of indices) and the Map with the vertexData for the indices
-- output will be: a list of Results for the vertex data and a list of indices for the vertex data
processFace : List Index
              -> M.SortedMap Int Vertex
              -> M.SortedMap Int Vertex
              -> M.SortedMap Int UV
              -> Int
              -> M.SortedMap Index Int        -- maps the given index v/t/n to the actual result index
              -> M.SortedMap Int VertexData   -- maps the given result index to the actual vertex data
              -> List Int                     -- the index buffer
              -> (List Int, List VertexData)
processFace []         _ _ _  _   indices vData buffer = (reverse buffer, (map snd $ toList vData))
processFace (f::faces)  p n t cnt indices vData buffer = case (lookup f indices) of
  Just i  => processFace faces p n t cnt indices vData (i :: buffer)
  Nothing => case (getData f p n t ) of
    Just vd => processFace faces p n t (cnt+1) (insert f cnt indices) (insert cnt vd vData) (cnt :: buffer)
    Nothing => processFace faces p n t cnt indices vData buffer -- ignore face: should not be possible


computeModel : List ObjLine -> ObjModel
computeModel objLines = 
  let 
    (positions, normals, uvs, indices) = processLines objLines
    mappedPositions  = mapByIndex positions  -- Map Int Vertex
    mappedNormals    = mapByIndex normals    -- Map Int Vertex
    mappedUvs        = mapByIndex uvs        -- Map Int UV
    positionIndices = reverse $ map fst indices
    (posn, vData) = processFace indices mappedPositions mappedNormals mappedUvs 0 M.empty M.empty []
  in MkObjModel (map position vData) (map uv vData) (map normal vData) posn

public 
loadObj : (filename: String) -> IO ObjModel
loadObj fname = do handle <- openFile fname Read
                   objLines <- parseFile' handle [] 
                   closeFile handle
                   pure $ computeModel objLines
                where
                   partial
                   parseFile' : File -> List ObjLine -> IO (List ObjLine)
                   parseFile' h acc =
                     do x <- feof h
                        if not x then do l <- fread h
                                         parseFile' h ((parseLine l) ++ acc)
                        else return $ reverse acc
                    
