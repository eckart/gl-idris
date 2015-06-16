module Graphics.Rendering.Gl

%include C "gl_idris.h"
%include C "GLFW/glfw3.h"
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

public
getError : IO GlError
getError = do err <- foreign FFI_C "glGetError" (IO Int) 
              pure $ fromGlInt err

||| A Vertex Array Object id
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
data Buffer = MkBuffer Int

||| generate a vertex array object name
public
genBuffers : IO Buffer
genBuffers = do id <- foreign FFI_C "idr_glGenBuffers" (IO Int) 
                pure $ MkBuffer id

data BufferBindingTarget 
  = GL_ARRAY_BUFFER

instance GlConstant BufferBindingTarget Int where
  toGlInt   GL_ARRAY_BUFFER  = 0x8892
  fromGlInt          0x8892  = GL_ARRAY_BUFFER

||| activate the vertex buffer
public
bindBuffer : BufferBindingTarget -> Buffer -> IO ()
bindBuffer target (MkBuffer id) = foreign FFI_C "glBindBuffer" (Int -> Int -> IO ()) (toGlInt target) id

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

data Vectors = Vector3 | Vector4

public
bufferData : BufferBindingTarget -> List Double -> GlUsage -> IO ()
bufferData target [] usage = pure $ ()
bufferData target xs usage = 
  do ptr <- writeBuffer xs
     size <- foreign FFI_C "idr_sizeof_doubles" (Int -> IO Int) (toIntNat (length xs))
     foreign FFI_C "glBufferData" (Int -> Int -> Ptr -> Int -> IO ()) (toGlInt target) size ptr (toGlInt usage)
     free ptr 
