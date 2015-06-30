module Main

import Effects
import Effect.StdIO
import Graphics.Rendering.Gl
import Effect.Glfw
import Graphics.Rendering.Config

%include C "GL/glew.h"
{--
flatten : List (Double, Double, Double, Double) -> List Double
flatten [] = []
flatten ((a,b,c,d) :: xs) = [a,b,c,d] ++ (flatten xs)

showError : String -> IO ()
showError msg = do err <- getError
                   putStrLn $ msg ++ (show err)

createShaders : IO (Shader, Shader, Program)
createShaders = do
  getError
  vertexShader <- createShader GL_VERTEX_SHADER
  
  showError "create vertex shader "
  vtx <- readFile "shader.vtx"
  shaderSource vertexShader vtx
  compileShader vertexShader
  
  fragmentShader <- createShader GL_FRAGMENT_SHADER
  showError "create fragment shader "

  frg <- readFile "shader.frg"
  shaderSource fragmentShader frg 
  compileShader fragmentShader  
  
  program <- createProgram
  attachShader program vertexShader
  attachShader program fragmentShader
  showError "attach shaders "
  
  linkProgram program
  useProgram program
  showError "link and use "

  pure (vertexShader, fragmentShader, program)
  

destroyShaders : (Shader, Shader, Program) -> IO ()
destroyShaders (shader1, shader2, program) = do
  getError
  useProgram NoProgram
  detachShader program shader1
  detachShader program shader2
  deleteShader shader1
  deleteShader shader2
  deleteProgram program
  showError "delete shaders "
  pure ()

createBuffers : IO (Vao, Buffer, Buffer)
createBuffers = do
  let vertices = [
    ( -0.8, -0.8, 0.0, 1.0),
    (  0.0,  0.8, 0.0, 1.0),
    (  0.8, -0.8, 0.0, 1.0)
  ]
  
  let colors = [
    (1.0, 0.0, 0.0, 1.0),
    (0.0, 1.0, 0.0, 1.0),
    (0.0, 0.0, 1.0, 1.0)
  ]
  getError

  vao <- genVertexArrays
  bindVertexArray vao
  buffer <- genBuffers
  bindBuffer GL_ARRAY_BUFFER buffer
  bufferData GL_ARRAY_BUFFER (flatten vertices) GL_STATIC_DRAW
  showError "vertex buffer data "
  enableVertexAttribArray 0
  vertexAttribPointer 0 4 GL_DOUBLE GL_FALSE 0 0

  colorBuffer <- genBuffers
  bindBuffer GL_ARRAY_BUFFER colorBuffer
  bufferData GL_ARRAY_BUFFER (flatten colors) GL_STATIC_DRAW
  enableVertexAttribArray 1
  vertexAttribPointer 1 4 GL_DOUBLE GL_FALSE 0 0

  showError "color buffer "
  pure $ (vao, buffer, colorBuffer)


destroyBuffers : Vao -> Buffer -> Buffer -> IO ()
destroyBuffers vao buffer colorBuffer = do
  disableVertexAttribArray 1
  disableVertexAttribArray 0
  
  unbindBuffer GL_ARRAY_BUFFER

  deleteBuffer buffer
  deleteBuffer colorBuffer

  unbindVertexArray
  
  deleteVertexArray vao

  showError "destroy buffers "

draw : GlfwWindow -> Vao -> IO ()
draw win vao = do 
                   clearColor 0 0 0 1
                   clear GL_COLOR_BUFFER_BIT
                   clear GL_DEPTH_BUFFER_BIT
                   bindVertexArray vao
                   drawArrays GL_TRIANGLES 0 3
                   glfwSwapBuffers win
                   
--}                   
Prog : Type -> Type -> Type -> Type
Prog i j t = { [GLFW i,          -- GLFW effect
                GLFW_WINDOW j,   -- a Glfw Window effect
                STDIO]           -- a std io effect
             } Eff t
    
Running : Type -> Type
Running t = Prog GlfwMode GlfwWindow t


-- the effectful main method
emain : Prog () () ()
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
           eventLoop
           destroyWindow
           terminate
           pure ()
        where
          draw : Running ()
          draw = with Effects do
                      putStrLn "drawing"
                      --clearColor 0 0 0 1
                      --clear GL_COLOR_BUFFER_BIT
                      --clear GL_DEPTH_BUFFER_BIT
                      --drawArrays GL_TRIANGLES 0 3

          eventLoop : Running ()
          eventLoop = do draw
                         pollEvents
                         swapBuffers
                         ev <- getKey GLFW_KEY_ESCAPE
                         closeClicked <- shouldClose
                         if closeClicked || ev == GLFW_PRESS
                           then pure ()
                           else eventLoop
main : IO ()
main = runInit [(), -- initial state for the Glfw effect
                (), -- initial state for the Window effect
                ()  -- initial state for the StdIO effect
                ]
       emain
       
