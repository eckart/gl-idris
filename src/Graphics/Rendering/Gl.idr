module Graphics.Rendering.Gl

%include C "gl_idris.h"
%include C "GLFW/glfw3.h"
%link C "gl_idris.o"

%access private

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
clearColor : (r: Double) -> (g: Double) -> (b: Double) -> (a: Double) -> IO ()
clearColor = foreign FFI_C "glClearColor" (Double -> Double -> Double -> Double -> IO ())


public 
clear : GLbitfields -> IO ()
clear mask = foreign FFI_C "glClear" (Int -> IO()) (toGlInt mask)
