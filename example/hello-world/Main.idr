module Main


import Graphics.Rendering.Gl
import Graphics.Util.Glfw
import Graphics.Rendering.Config

%include C "GL/glew.h"

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
                   swapBuffers win
                   
                   
initDisplay : String -> Int -> Int -> IO GlfwWindow
initDisplay title width height = do
  glfw <- init
  windowHint GLFW_CONTEXT_VERSION_MAJOR  4
  windowHint GLFW_CONTEXT_VERSION_MINOR  1
  windowHint GLFW_OPENGL_FORWARD_COMPAT  1
  windowHint GLFW_OPENGL_PROFILE         (toInt GLFW_OPENGL_CORE_PROFILE)
  win <- createWindow title width height defaultMonitor
  -- TODO: test for failure - for now we pretend every thing is going to be ok
  -- terminate 
  makeContextCurrent win
  initGlew
  info <- getInfo
  putStrLn info
  enable GL_DEPTH_TEST
  depthFunc GL_LESS
  return win

main : IO ()
main = do win <- initDisplay "Hello World" 640 480
          --win <- createWindow "Hello World" 640 480 
          setInputMode win GLFW_STICKY_KEYS 1
          swapInterval 0
          shaders <- createShaders
          (vao, buffer, colorBuffer) <- createBuffers
          eventLoop win vao
          destroyBuffers vao buffer colorBuffer
          destroyShaders shaders
          terminate win
          pure ()
       where 
         eventLoop : GlfwWindow -> Vao -> IO ()
         eventLoop win vao = do
                      draw win vao
                      pollEvents
                      key <- getKey win GLFW_KEY_ESCAPE
                      shouldClose <- windowShouldClose win
                      if shouldClose || key == GLFW_PRESS
                      then pure ()
                      else eventLoop win vao
                              
