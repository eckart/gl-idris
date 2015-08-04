module Graphics.Rendering.Gl

import Graphics.Util.Mesh
import Graphics.Rendering.Gl.Types
import Graphics.Rendering.Gl.Buffers
import Graphics.Rendering.Gl.Gl41

%include C "GL/glew.h"
%include C "gl_idris.h"
%link C "gl_idris.o"

%access private

-- GLEW 
public
glewInit : IO Int
glewInit = foreign FFI_C "idr_init_glew" (IO Int) 

-- ----------------------------------------------------------------- [ Helpers ]

loadDoubleData : List Double -> IO ()
loadDoubleData data' = do
  ds <- sizeofDouble
  ptr <- doublesToBuffer data'
  glBufferData GL_ARRAY_BUFFER (ds * (cast $ length data')) ptr GL_STATIC_DRAW
  free ptr
  pure ()

toList' : Vect n (Vect m a) -> List a
toList' [] = []
toList' (x :: xs) = (toList x) ++ toList' xs

-- ----------------------------------------------------------------- [ Simple API ]

public
record Shader where
  constructor MkShader
  ||| location of the shader program
  program: Int
  ||| locations of all shaders for this program. minimum of two shaders is required (vertex and fragment shader)
  shaders: Vect (S (S n)) Int

createShader : (GLenum, String) -> IO Int
createShader (shaderType, source) = do
  shaderLoc <- glCreateShader shaderType
  glShaderSource shaderLoc 1 [source] [(cast $ length source)]
  glCompileShader shaderLoc
  pure shaderLoc

||| creates the shader program
public
createShaders : Vect (S (S n)) (GLenum, String) -> IO Shader
createShaders filenames = do
  locs <- traverse createShader filenames
  programLoc <- glCreateProgram
  traverse (glAttachShader programLoc) locs
  glLinkProgram programLoc
  glUseProgram 0
  
  pure $ MkShader programLoc locs

||| deletes the shader program
public    
deleteShaders : Shader -> IO ()
deleteShaders (MkShader programLoc shaderLocs) = do
  glUseProgram 0
  traverse (glDetachShader programLoc) shaderLocs
  traverse glDeleteShader shaderLocs
  glDeleteProgram programLoc
  pure ()
  
  
||| the model on the GPU
|||
||| the minumum information needed is the location of the vertex array object (VAO)
||| and the locations of the vertex buffer objects (VBO)
||| textures are optional
data Model : Type where
  ||| creates a textured model 
  ||| @ vao the location of the vertex array object
  ||| @ vbos the locations of the vertex buffer objects
  ||| @ textures locations of the textures for the model
  TexturedModel : (vao: Int) -> (vbos: Vect (S n) Int) -> (textures: Vect m Int) -> Model

||| creates a model from a mesh and some texture locations
||| @ m the mesh. should be uv unwrapped
||| @ textures texture locations we need to bind when using the model
public
createModel : (m: Mesh) -> (textures: (Vect n Int)) -> IO Model
createModel (UvMesh positions normals uvs indices) textures = do
  (vaoLoc :: _) <- glGenVertexArrays 1

  glBindVertexArray vaoLoc
  (positionBuffer :: normalBuffer :: uvBuffer :: indexBuffer :: _) <- glGenBuffers 4

  glBindBuffer GL_ARRAY_BUFFER positionBuffer
  loadDoubleData (toList' positions)
  glEnableVertexAttribArray 0
  glVertexAttribPointer 0 3 GL_DOUBLE GL_FALSE 0 prim__null

  glBindBuffer GL_ARRAY_BUFFER normalBuffer
  loadDoubleData (toList' normals)
  glEnableVertexAttribArray 1
  glVertexAttribPointer 0 3 GL_DOUBLE GL_FALSE 0 prim__null

  glBindBuffer GL_ARRAY_BUFFER uvBuffer
  loadDoubleData (toList' uvs)
  glEnableVertexAttribArray 2
  glVertexAttribPointer 0 2 GL_DOUBLE GL_FALSE 0 prim__null
        
  is <- sizeofInt
  glBindBuffer GL_ELEMENT_ARRAY_BUFFER indexBuffer
  ptr <- intsToBuffer indices
  glBufferData GL_ELEMENT_ARRAY_BUFFER (is * (cast $ length indices)) ptr GL_STATIC_DRAW
  free ptr

  pure $ TexturedModel vaoLoc [positionBuffer, normalBuffer, uvBuffer, indexBuffer] textures


public
deleteModel : Model -> IO ()
deleteModel (TexturedModel vao vbos _) = do
  glDisableVertexAttribArray 2 -- uvs
  glDisableVertexAttribArray 1 -- normals
  glDisableVertexAttribArray 0 -- positions

  glBindBuffer GL_ARRAY_BUFFER 0
  glBindBuffer GL_ELEMENT_ARRAY_BUFFER 0

  glDeleteBuffers (cast $ length vbos) $ toList vbos

  glBindVertexArray 0
  
  glDeleteVertexArrays 1 [vao]
  pure ()

data Entity a = 
  SimpleEntity Model Shader Vec3 Vec3 a
  
      
public 
render : Entity a -> (prepare: a -> IO ()) -> IO ()
render (SimpleEntity (TexturedModel vao _ textures) (MkShader prog _) position rotation val) prepare = do
  glBindVertexArray vao
  glUseProgram prog
  prepare val
  traverse (glBindTexture GL_TEXTURE_2D) textures
  
  glDrawArrays GL_TRIANGLES 0 3
  pure ()


public 
glLoadPNGTexture : String -> IO Int
glLoadPNGTexture filename = foreign FFI_C "png_texture_load" (String -> IO Int) filename

-- ----------------------------------------------------------------- [ Helper ]

public 
printShaderLog : Int -> IO ()
printShaderLog id = foreign FFI_C "printShaderLog" (Int -> IO()) id

public
glGetInfo : IO String
glGetInfo = do vendor   <- glGetString GL_VENDOR
               renderer <- glGetString GL_RENDERER
               version  <- glGetString GL_VERSION
               return $ foldl1 (++) (the (List String) ["Vendor = ", vendor, "\nRenderer = ", renderer, "\nVersion = ", version, "\n"])

