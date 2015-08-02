module Graphics.Rendering.Gl

import Graphics.Util.Math3D as T
import Graphics.Rendering.Gl.Gl41

%include C "GL/glew.h"
%include C "gl_idris.h"
%link C "gl_idris.o"

%access private

-- GLEW 
public
glewInit : IO Int
glewInit = foreign FFI_C "idr_init_glew" (IO Int) 

-- ----------------------------------------------------------------- [ Textures ]

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

