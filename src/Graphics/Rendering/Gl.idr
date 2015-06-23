module Graphics.Rendering.Gl

%include C "GLFW/glfw3.h"
%include C "gl_idris.h"
%link C "gl_idris.o"

%access private

-- --------------------------------------------------------------

writeBuffer : List Double -> IO Ptr
writeBuffer ds = 
  do ptr <- foreign FFI_C "idr_allocate_doubles" (Int -> IO Ptr) (toIntNat (length ds))
     writeBuffer' ptr Z ds
     pure ptr
  where writeBuffer' : Ptr -> Nat -> List Double -> IO ()
        writeBuffer' ptr i []        = pure ()
        writeBuffer' ptr i (d :: ds) = do foreign FFI_C "idr_set_double" (Ptr -> Int -> Double -> IO()) ptr (toIntNat i) d
                                          writeBuffer' ptr (S i) ds

free : Ptr -> IO ()
free ptr = foreign FFI_C "free" (Ptr -> IO ()) ptr
 
-- --------------------------------------------------------------

class GlConstant a b where
  toGlInt   : a -> b
  fromGlInt : b -> a

public 
data GlBool = GL_TRUE | GL_FALSE

instance GlConstant GlBool Char where
  toGlInt GL_TRUE  = 't'
  toGlInt GL_FALSE = chr 0
  fromGlInt      '\NUL' = GL_FALSE
  fromGlInt      _  = GL_TRUE

public
data GLbitfields
  = GL_DEPTH_BUFFER_BIT
  | GL_ACCUM_BUFFER_BIT
  | GL_STENCIL_BUFFER_BIT
  | GL_COLOR_BUFFER_BIT

instance GlConstant GLbitfields Int where
  toGlInt  GL_DEPTH_BUFFER_BIT     = 0x00000100
  toGlInt  GL_ACCUM_BUFFER_BIT     = 0x00000200
  toGlInt  GL_STENCIL_BUFFER_BIT   = 0x00000400
  toGlInt  GL_COLOR_BUFFER_BIT     = 0x00004000
  fromGlInt 0x00000100             = GL_DEPTH_BUFFER_BIT
  fromGlInt 0x00000200             = GL_ACCUM_BUFFER_BIT
  fromGlInt 0x00000400             = GL_STENCIL_BUFFER_BIT
  fromGlInt 0x00004000             = GL_COLOR_BUFFER_BIT
  
public
Vertex3 : Type
Vertex3 = (Double, Double, Double)

public
Vertex4 : Type
Vertex4 = (Double, Double, Double, Double)

public 
clearColor : (r: Double) -> (g: Double) -> (b: Double) -> (a: Double) -> IO ()
clearColor = foreign FFI_C "glClearColor" (Double -> Double -> Double -> Double -> IO ())


public 
clear : GLbitfields -> IO ()
clear mask = foreign FFI_C "glClear" (Int -> IO()) (toGlInt mask)

public
data GlError
  = GL_NO_ERROR
  | GL_INVALID_ENUM
  | GL_INVALID_VALUE
  | GL_INVALID_OPERATION
  | GL_OUT_OF_MEMORY
  | GL_STACK_UNDERFLOW
  | GL_STACK_OVERFLOW
  | GL_INVALID_FRAMEBUFFER_OPERATION

instance GlConstant GlError Int where
  toGlInt GL_NO_ERROR                        = 0 
  toGlInt GL_INVALID_ENUM                    = 0x0500
  toGlInt GL_INVALID_VALUE                   = 0x0501
  toGlInt GL_INVALID_OPERATION               = 0x0502
  toGlInt GL_OUT_OF_MEMORY                   = 0x0503
  toGlInt GL_STACK_UNDERFLOW                 = 0x0504
  toGlInt GL_STACK_OVERFLOW                  = 0x0505
  toGlInt GL_INVALID_FRAMEBUFFER_OPERATION   = 0x0506
  fromGlInt 0      = GL_NO_ERROR
  fromGlInt 0x0500 = GL_INVALID_ENUM
  fromGlInt 0x0501 = GL_INVALID_VALUE
  fromGlInt 0x0502 = GL_INVALID_OPERATION
  fromGlInt 0x0503 = GL_OUT_OF_MEMORY
  fromGlInt 0x0504 = GL_STACK_UNDERFLOW
  fromGlInt 0x0505 = GL_STACK_OVERFLOW
  fromGlInt 0x0506 = GL_INVALID_FRAMEBUFFER_OPERATION

instance Show GlError where
  show GL_NO_ERROR                      = "GL_NO_ERROR "
  show GL_INVALID_ENUM                  = "GL_INVALID_ENUM"
  show GL_INVALID_VALUE                 = "GL_INVALID_VALUE"
  show GL_INVALID_OPERATION             = "GL_INVALID_OPERATION"
  show GL_OUT_OF_MEMORY                 = "GL_OUT_OF_MEMORY"
  show GL_STACK_UNDERFLOW               = "GL_STACK_UNDERFLOW"
  show GL_STACK_OVERFLOW                = "GL_STACK_OVERFLOW"
  show GL_INVALID_FRAMEBUFFER_OPERATION = "GL_INVALID_FRAMEBUFFER_OPERATION"

public
getError : IO GlError
getError = do err <- foreign FFI_C "glGetError" (IO Int) 
              pure $ fromGlInt err

||| A Vertex Array Object id
abstract
data Vao = MkVao Int

||| generate a vertex array object name
public
genVertexArrays : IO Vao
genVertexArrays = do id <- foreign FFI_C "idr_glGenVertexArrays" (IO Int) 
                     pure $ MkVao id

||| activate the vertex array object
public
bindVertexArray : Vao -> IO ()
bindVertexArray (MkVao id) = foreign FFI_C "glBindVertexArray" (Int -> IO ()) id

||| A Vertex Buffer
abstract
data Buffer = MkBuffer Int

||| generate a vertex array object name
public
genBuffers : IO Buffer
genBuffers = do id <- foreign FFI_C "idr_glGenBuffers" (IO Int) 
                pure $ MkBuffer id

public
data BufferBindingTarget 
  = GL_ARRAY_BUFFER

instance GlConstant BufferBindingTarget Int where
  toGlInt   GL_ARRAY_BUFFER  = 0x8892
  fromGlInt          0x8892  = GL_ARRAY_BUFFER

||| activate the vertex buffer
public
bindBuffer : BufferBindingTarget -> Buffer -> IO ()
bindBuffer target (MkBuffer id) = foreign FFI_C "glBindBuffer" (Int -> Int -> IO ()) (toGlInt target) id

public
data GlUsage
  = GL_STREAM_DRAW
  | GL_STREAM_READ
  | GL_STREAM_COPY
  | GL_STATIC_DRAW
  | GL_STATIC_READ 
  | GL_STATIC_COPY 
  | GL_DYNAMIC_DRAW 
  | GL_DYNAMIC_READ 
  | GL_DYNAMIC_COPY

instance GlConstant GlUsage Int where
  toGlInt GL_STREAM_DRAW       = 0x88E0
  toGlInt GL_STREAM_READ       = 0x88E1
  toGlInt GL_STREAM_COPY       = 0x88E2
  toGlInt GL_STATIC_DRAW       = 0x88E4
  toGlInt GL_STATIC_READ       = 0x88E5
  toGlInt GL_STATIC_COPY       = 0x88E6
  toGlInt GL_DYNAMIC_DRAW      = 0x88E8
  toGlInt GL_DYNAMIC_READ      = 0x88E9
  fromGlInt 0x88E0             = GL_STREAM_DRAW                                 
  fromGlInt 0x88E1             = GL_STREAM_READ                                 
  fromGlInt 0x88E2             = GL_STREAM_COPY                                 
  fromGlInt 0x88E4             = GL_STATIC_DRAW                                 
  fromGlInt 0x88E5             = GL_STATIC_READ                                 
  fromGlInt 0x88E6             = GL_STATIC_COPY                                 
  fromGlInt 0x88E8             = GL_DYNAMIC_DRAW                                
  fromGlInt 0x88E9             = GL_DYNAMIC_READ                                

public
data Vectors = Vector3 | Vector4

public
bufferData : BufferBindingTarget -> List Double -> GlUsage -> IO ()
bufferData target [] usage = pure $ ()
bufferData target xs usage = 
  do ptr <- writeBuffer xs
     size <- foreign FFI_C "idr_sizeof_doubles" (Int -> IO Int) (toIntNat (length xs))
     foreign FFI_C "glBufferData" (Int -> Int -> Ptr -> Int -> IO ()) (toGlInt target) size ptr (toGlInt usage)
     free ptr 

||| enables the attribute on for the given VAO
public 
enableVertexArrayAttrib : Vao -> Int -> IO ()
enableVertexArrayAttrib (MkVao id) index = foreign FFI_C "glEnableVertexArrayAttrib" (Int -> Int -> IO ()) id index

public 
disableVertexArrayAttrib : Vao -> Int -> IO ()
disableVertexArrayAttrib (MkVao id) index = foreign FFI_C "glDisableVertexArrayAttrib" (Int -> Int -> IO ()) id index

||| enables the attribute on for the currently active VAO
public 
enableVertexAttribArray : Int -> IO ()
enableVertexAttribArray index = foreign FFI_C "glEnableVertexAttribArray" (Int -> IO ()) index

public 
disableVertexAttribArray : Int -> IO ()
disableVertexAttribArray index = foreign FFI_C "glDisableVertexAttribArray" (Int -> IO ()) index

 
data GlType 
  = GL_BYTE
  | GL_UNSIGNED_BYTE
  | GL_SHORT
  | GL_UNSIGNED_SHORT
  | GL_INT
  | GL_UNSIGNED_INT
  | GL_FLOAT
  | GL_DOUBLE

instance GlConstant GlType Int where
  toGlInt GL_BYTE            = 0x1400
  toGlInt GL_UNSIGNED_BYTE   = 0x1401
  toGlInt GL_SHORT           = 0x1402
  toGlInt GL_UNSIGNED_SHORT  = 0x1403
  toGlInt GL_INT             = 0x1404
  toGlInt GL_UNSIGNED_INT    = 0x1405
  toGlInt GL_FLOAT           = 0x1406
  toGlInt GL_DOUBLE          = 0x140A
  fromGlInt 0x1400           = GL_BYTE
  fromGlInt 0x1401           = GL_UNSIGNED_BYTE
  fromGlInt 0x1402           = GL_SHORT
  fromGlInt 0x1403           = GL_UNSIGNED_SHORT
  fromGlInt 0x1404           = GL_INT
  fromGlInt 0x1405           = GL_UNSIGNED_INT
  fromGlInt 0x1406           = GL_FLOAT
  fromGlInt 0x140A           = GL_DOUBLE
  
public
vertexAttribPointer : (index: Int) -> (size: Int) -> (ty: GlType) -> (normalized: GlBool) -> (stride: Int)  -> IO () -- no offset for now
vertexAttribPointer idx size ty normalized stride = 
  foreign FFI_C "glVertexAttribPointer" (Int -> Int -> Int -> Char -> Int -> Ptr -> IO ()) idx size (toGlInt ty) (toGlInt normalized) stride prim__null

-- -------------------------------------------------------------
-- Shaders
-- -------------------------------------------------------------

public
data ShaderType 
  --= GL_COMPUTE_SHADER
  = GL_VERTEX_SHADER        
  | GL_TESS_CONTROL_SHADER    
  | GL_TESS_EVALUATION_SHADER 
  | GL_GEOMETRY_SHADER        
  | GL_FRAGMENT_SHADER      
    
    
instance GlConstant ShaderType Int where 
  --toGlInt GL_COMPUTE_SHADER           = 
  toGlInt GL_VERTEX_SHADER          = 0x8B31
  toGlInt GL_TESS_CONTROL_SHADER    = 0x8E88
  toGlInt GL_TESS_EVALUATION_SHADER = 0x8E87
  toGlInt GL_GEOMETRY_SHADER        = 0x8DD9
  toGlInt GL_FRAGMENT_SHADER        = 0x8B30
  --fromGlInt GL_COMPUTE_SHADER           = 
  fromGlInt 0x8B31 = GL_VERTEX_SHADER          
  fromGlInt 0x8E88 = GL_TESS_CONTROL_SHADER    
  fromGlInt 0x8E87 = GL_TESS_EVALUATION_SHADER 
  fromGlInt 0x8DD9 = GL_GEOMETRY_SHADER        
  fromGlInt 0x8B30  = GL_FRAGMENT_SHADER        

abstract
data Shader = MkShader Int
    
public    
createShader : ShaderType -> IO Shader
createShader t = do ptr <- foreign FFI_C "glCreateShader" (Int -> IO Int) (toGlInt t)
                    pure $ MkShader ptr
public    
deleteShader : Shader -> IO ()
deleteShader (MkShader id) = foreign FFI_C "glDeleteShader" (Int -> IO ()) id
                      
public    
shaderSource : Shader -> String -> IO ()
shaderSource (MkShader id) source = foreign FFI_C "idr_glShaderSource" (Int -> String -> IO ()) id source

public    
compileShader : Shader -> IO ()
compileShader (MkShader id) = foreign FFI_C "glCompileShader" (Int -> IO ()) id

--abstract
public
data Program = MkProgram Int | NoProgram
  
public    
createProgram : IO Program
createProgram = do id <- foreign FFI_C "glCreateProgram" (IO Int)
                   pure $ MkProgram id

public    
deleteProgram : Program -> IO ()
deleteProgram (MkProgram id ) = foreign FFI_C "glDeleteProgram" (Int -> IO()) id

public    
linkProgram : Program -> IO ()
linkProgram (MkProgram id ) = foreign FFI_C "glLinkProgram" (Int -> IO()) id
                     
public    
attachShader : Program -> Shader -> IO ()
attachShader (MkProgram programId) (MkShader shaderId) = 
  foreign FFI_C "glAttachShader" (Int -> Int -> IO()) programId shaderId                   

public    
detachShader : Program -> Shader -> IO ()
detachShader (MkProgram programId) (MkShader shaderId) = 
  foreign FFI_C "glDetachShader" (Int -> Int -> IO()) programId shaderId                   

public    
useProgram : Program -> IO ()
useProgram (MkProgram id ) = foreign FFI_C "glUseProgram" (Int -> IO()) id
useProgram NoProgram = foreign FFI_C "glUseProgram" (Int -> IO()) 0
    
namespace Draw

  data DrawingMode
    = GL_POINTS
    | GL_LINE_STRIP
    | GL_LINE_LOOP
    | GL_LINES
    | GL_LINE_STRIP_ADJACENCY
    | GL_LINES_ADJACENCY
    | GL_TRIANGLE_STRIP
    | GL_TRIANGLE_FAN
    | GL_TRIANGLES
    | GL_TRIANGLE_STRIP_ADJACENCY
    | GL_TRIANGLES_ADJACENCY
    | GL_PATCHES
    
  instance GlConstant DrawingMode Int where
    toGlInt GL_POINTS                   = 0x0000
    toGlInt GL_LINE_STRIP               = 0x0003
    toGlInt GL_LINE_LOOP                = 0x0002
    toGlInt GL_LINES                    = 0x0001
    toGlInt GL_LINE_STRIP_ADJACENCY     = 0x000B
    toGlInt GL_LINES_ADJACENCY          = 0x000A
    toGlInt GL_TRIANGLE_STRIP           = 0x0005
    toGlInt GL_TRIANGLE_FAN             = 0x0006
    toGlInt GL_TRIANGLES                = 0x0004
    toGlInt GL_TRIANGLE_STRIP_ADJACENCY = 0x000D
    toGlInt GL_TRIANGLES_ADJACENCY      = 0x000C
    toGlInt GL_PATCHES                  = 0x000E
    fromGlInt 0x0000 = GL_POINTS
    fromGlInt 0x0003 = GL_LINE_STRIP
    fromGlInt 0x0002 = GL_LINE_LOOP
    fromGlInt 0x0001 = GL_LINES
    fromGlInt 0x000B = GL_LINE_STRIP_ADJACENCY
    fromGlInt 0x000A = GL_LINES_ADJACENCY
    fromGlInt 0x0005 = GL_TRIANGLE_STRIP
    fromGlInt 0x0006 = GL_TRIANGLE_FAN
    fromGlInt 0x0004 = GL_TRIANGLES
    fromGlInt 0x000D = GL_TRIANGLE_STRIP_ADJACENCY
    fromGlInt 0x000C = GL_TRIANGLES_ADJACENCY
    fromGlInt 0x000E = GL_PATCHES
  

  drawArrays : DrawingMode -> (first: Int) -> (count: Int) -> IO ()
  drawArrays mode first count = foreign FFI_C "glDrawArrays" (Int -> Int -> Int -> IO ()) (toGlInt mode) first count
