module Main

import Effects
import Effect.StdIO
import Graphics.Rendering.Gl
import Effect.Glfw
import Effect.Gl
import Graphics.Rendering.Config

-- this line is important! Without this line glew won't be included at the first position
-- causing GL be included incorrectly 
%include C "GL/glew.h"

Prog : Type -> Type -> Type -> Type -> Type
Prog i j k t = { [GLFW i,        -- GLFW effect
                GLFW_WINDOW j,   -- a Glfw Window effect
                GL k,            -- Gl Effect 
                STDIO]           -- a std io effect
             } Eff t
    
Running : Type -> Type
Running t = Prog GlfwMode GlfwWindow GlState t


vertices : Vect 3 Vertex
vertices = [
    (Vertex4 (-0.8) (-0.8) 0.0 1.0),
    (Vertex4  0.0     0.8  0.0 1.0),
    (Vertex4  0.8   (-0.8) 0.0 1.0)
  ]
 
colors : Vect 3 Vertex
colors = [
    (Vertex4 1.0 0.0 0.0 1.0),
    (Vertex4 0.0 1.0 0.0 1.0),
    (Vertex4 0.0 0.0 1.0 1.0)
  ]


-- the effectful main method
emain : Prog () () () ()
emain = do putStrLn "Initialising"
           putStrLn "..."
           True <-  initialise  | False => putStrLn "Error!"
           windowHint GLFW_CONTEXT_VERSION_MAJOR  4
           windowHint GLFW_CONTEXT_VERSION_MINOR  1
           windowHint GLFW_OPENGL_FORWARD_COMPAT  1
           windowHint GLFW_OPENGL_PROFILE         (toInt GLFW_OPENGL_CORE_PROFILE)
           True <- (createWindow "Hello Effectful Idris" 640 480) | False => do putStrLn "More Error"; terminate; pure ()
           initGlew
           setInputMode GLFW_STICKY_KEYS 1
           makeContextCurrent
           startGl
           model <- createColoredModel vertices colors "shader.vtx" "shader.frg" GL_STATIC_DRAW GL_TRIANGLES 
           eventLoop [model]
           stopGl
           destroyWindow
           terminate
           pure ()
        where
          render : List Model -> Running ()
          render []        = pure ()
          render (m :: ms) = do renderModel m
                                render ms
                                
          draw : List Model -> Running ()
          draw models = with Effects do
                             putStrLn "drawing"
                             clear (RGBA 0 0 0 1) [GL_COLOR_BUFFER_BIT]
                             render models
                             pure ()


          eventLoop : List Model -> Running ()
          eventLoop models = do draw models
                                pollEvents
                                swapBuffers
                                ev <- getKey GLFW_KEY_ESCAPE
                                closeClicked <- shouldClose
                                if closeClicked || ev == GLFW_PRESS
                                then pure ()
                                else eventLoop models
main : IO ()
main = runInit [(), -- initial state for the Glfw effect
                (), -- initial state for the Window effect
                (), -- initial state for GL effect
                ()  -- initial state for the StdIO effect
                ]
       emain
       
