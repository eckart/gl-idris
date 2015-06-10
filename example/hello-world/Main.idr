module Main

import Graphics.Util.Glfw
import Graphics.Rendering.Gl

main : IO ()
main = do win <- createWindow "Hello World" 640 480 
          clearColor 0 0 0 1
          clear GL_COLOR_BUFFER_BIT
          swapBuffers win
          eventLoop win
          terminate win
          pure ()
       where 
          eventLoop : Window -> IO ()
          eventLoop win = do
                      waitEvents
                      shouldClose <- windowShouldClose win
                      if shouldClose 
                      then pure ()
                      else eventLoop win

