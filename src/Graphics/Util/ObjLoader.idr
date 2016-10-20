module Graphics.Util.ObjLoader

import Control.Monad.Identity

import Data.SortedMap as M

import Lightyear
import Lightyear.Combinators
import Lightyear.Strings
import Lightyear.Char

import Graphics.Util.Mesh

%access private

vtx : Double -> Double -> Double -> Vec3
vtx x y z = [x, y, z]

uv : Double -> Double -> Vec2
uv u v = [u, v] 

Index : Type
Index = (Int, Int, Int)                  

export
data ObjLine
  = Position Vec3
  | TextureCoord Vec2
  | Normal Vec3
  | Face Index Index Index
  | Comment String
  | Ignored String
  
  
implementation Show ObjLine where
  show (Position v)       = "Position " ++ (show v)
  show (TextureCoord uv)  = "TextureCoord " ++ (show uv)
  show (Normal v)         = "Normal " ++ (show v)
  show (Face v1 v2 v3)    = "Face " ++ (show v1) ++ " " ++ (show v2) ++ " " ++ (show v3)
  show (Comment s)        = "Comment " ++ s
  show (Ignored s)        = "Ignored " ++ s
  
-- ------------------------------------------------------------------ [ Tokens ]

notEol : Monad m => ParserT String m Char
notEol = satisfy (\s => not (isNL s))

eol : Monad m => ParserT String m Char
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
  
processLines : List ObjLine -> (List Vec3, List Vec3, List Vec2, List Index)
processLines lines = processLines' lines [] [] [] []
                   where processLines' : List ObjLine
                                       -> List Vec3 -- positions
                                       -> List Vec3 -- normals
                                       -> List Vec2     -- UVs / TextureCoordinates
                                       -> List Index -- indices
                                       -> (List Vec3, List Vec3, List Vec2, List Index)
                         processLines' []         pos norm uvs ind = (reverse pos, reverse norm, reverse uvs, reverse ind)
                         processLines' (l :: ls)  pos norm uvs ind = case l of
                           Position v      => processLines' ls (v :: pos)       norm        uvs                     ind 
                           Normal v        => processLines' ls       pos  (v :: norm)       uvs                     ind 
                           TextureCoord uv => processLines' ls       pos        norm (uv :: uvs)                    ind 
                           Face i1 i2 i3   => processLines' ls       pos        norm        uvs  (i1 :: i2 :: i3 :: ind)
                           _               => processLines' ls       pos        norm        uvs                     ind
      
                                                                  
                                                                                                                              
mapByIndex : List a -> M.SortedMap Int a
mapByIndex [] = M.empty
mapByIndex (x :: xs) = mapByIndex' (cast $ (length xs)) empty (reverse (x :: xs))
                where mapByIndex' : Int -> SortedMap Int a -> List a -> SortedMap Int a
                      mapByIndex' _ s        [] = s
                      mapByIndex' i s (x :: xs) = mapByIndex' (i-1) (insert i x s) xs

record VertexData where
  constructor MkData
  position : Vec3
  uv       : Vec2
  normal   : Vec3


getData : Index 
          -> M.SortedMap Int Vec3
          -> M.SortedMap Int Vec3
          -> M.SortedMap Int Vec2
          -> Maybe VertexData
getData (p,t,n) positions normals uvs = do
  position <- lookup (p-1) positions
  normal   <- lookup (n-1) normals
  uv       <- lookup (t-1) uvs
  pure $ MkData position uv normal

toVects : List VertexData -> (Vect n Vec3, Vect n Vec2, Vect n Vec3)
toVects {n = Z}   []        = ([], [], [])
toVects {n = S m} (x :: xs) with (toVects {n=m} xs )
  | (ps, uvs, norms) = ((position x) :: ps, (uv x) :: uvs, (normal x) :: norms )



-- input is: a list of indices (triples of indices) and the Map with the vertexData for the indices
-- output will be: a list of Results for the vertex data and a list of indices for the vertex data
processFace : List Index
              -> M.SortedMap Int Vec3
              -> M.SortedMap Int Vec3
              -> M.SortedMap Int Vec2
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


computeModel : List ObjLine -> Mesh
computeModel objLines = 
  let 
    (positions, normals, uvs, indices) = processLines objLines
    mappedPositions  = mapByIndex positions  -- Map Int Vertex
    mappedNormals    = mapByIndex normals    -- Map Int Vertex
    mappedUvs        = mapByIndex uvs        -- Map Int UV
    positionIndices = reverse $ map fst indices
    (posn, vData) = processFace indices mappedPositions mappedNormals mappedUvs 0 M.empty M.empty []
    
    (positions, uvs, norms) = toVects {n=length vData} vData
    
  in UvMesh positions norms uvs posn

export
loadObj : (filename: String) -> IO (Either FileError Mesh)
loadObj fname = do Right handle <- openFile fname Read | Left err => pure (Left err)
                   objLines <- parseFile' handle [] 
                   closeFile handle
                   pure $ Right (computeModel objLines)
                where
                   partial
                   parseFile' : File -> List ObjLine -> IO (List ObjLine)
                   parseFile' h acc =
                     do x <- fEOF h
                        if not x then do Right l <- fGetLine h | Left err => pure acc
                                         parseFile' h ((parseLine l) ++ acc)
                        else pure $ reverse acc
                    
