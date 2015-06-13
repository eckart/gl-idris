module Main

import Graphics.Util.Glfw
import Graphics.Rendering.Gl

main : IO ()
main = do win <- createWindow "Hello World" 640 480 
          setInputMode win GLFW_STICKY_KEYS 1
          swapInterval 0
          clearColor 0 0 0 1
          clear GL_COLOR_BUFFER_BIT
          swapBuffers win
          eventLoop win
          terminate win
          pure ()
       where 
          eventLoop : GlfwWindow -> IO ()
          eventLoop win = do
                      pollEvents
                      key <- getKey win GLFW_KEY_ESCAPE
                      shouldClose <- windowShouldClose win
                      if shouldClose || key == GLFW_PRESS
                      then pure ()
                      else eventLoop win

