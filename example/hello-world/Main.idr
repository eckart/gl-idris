module Main

import Control.Algebra
import Data.Matrix
import Graphics.Rendering.Gl
import Graphics.Util.Glfw
import Graphics.Rendering.Config
import Graphics.Util.Math3D
import Data.Floats

%include C "GL/glew.h"

flatten : List (Double, Double, Double, Double) -> List Double
flatten [] = []
flatten ((a,b,c,d) :: xs) = [a,b,c,d] ++ (flatten xs)

showError : String -> IO ()
showError msg = do err <- glGetError
                   putStrLn $ msg ++ (show err)

createShaders : IO (Shader, Shader, Program)
createShaders = do
  glGetError
  vertexShader <- glCreateShader GL_VERTEX_SHADER
  
  showError "create vertex shader "
  vtx <- readFile "shader.vtx"
  glShaderSource vertexShader vtx
  glCompileShader vertexShader
  
  fragmentShader <- glCreateShader GL_FRAGMENT_SHADER
  showError "create fragment shader "

  frg <- readFile "shader.frg"
  glShaderSource fragmentShader frg 
  glCompileShader fragmentShader  
  
  program <- glCreateProgram
  glAttachShader program vertexShader
  glAttachShader program fragmentShader
  showError "attach shaders "
  
  glLinkProgram program
  showError "link "
  glUseProgram program
  showError "use "

  printShaderLog vertexShader
  printShaderLog fragmentShader

  locView <- glGetUniformLocation program "viewMatrix"
  glUniformMatrix4fv locView defaultViewMatrix

  locProj <- glGetUniformLocation program "projectionMatrix"
  let projM = perspectiveProjection (Degree 45) (640 / 480) (1.0, 100.0)
  glUniformMatrix4fv locProj $ projM
  
  pure (vertexShader, fragmentShader, program)
  

destroyShaders : (Shader, Shader, Program) -> IO ()
destroyShaders (shader1, shader2, program) = do
  glGetError
  glUseProgram noProgram
  glDetachShader program shader1
  glDetachShader program shader2
  glDeleteShader shader1
  glDeleteShader shader2
  glDeleteProgram program
  showError "delete shaders "
  pure ()

vertices : List (Double, Double, Double, Double)
vertices = [
    ( -0.8, -0.8, 0.0, 1.0),
    (  0.0,  0.8, 0.0, 1.0),
    (  0.8, -0.8, 0.0, 1.0)
  ]
  
colors : List (Double, Double, Double, Double)
colors = [
    (1.0, 0.0, 0.0, 1.0),
    (0.0, 1.0, 0.0, 1.0),
    (0.0, 0.0, 1.0, 1.0)
  ]

createBuffers : IO (Vao, Buffer, Buffer)
createBuffers = do
  glGetError

  vao <- glGenVertexArrays
  glBindVertexArray vao
  buffer <- glGenBuffers
  glBindBuffer GL_ARRAY_BUFFER buffer
  glBufferData GL_ARRAY_BUFFER (flatten vertices) GL_STATIC_DRAW
  showError "vertex buffer data "
  glEnableVertexAttribArray 0
  glVertexAttribPointer 0 4 GL_DOUBLE GL_FALSE 0 0

  colorBuffer <- glGenBuffers
  glBindBuffer GL_ARRAY_BUFFER colorBuffer
  glBufferData GL_ARRAY_BUFFER (flatten colors) GL_STATIC_DRAW
  glEnableVertexAttribArray 1
  glVertexAttribPointer 1 4 GL_DOUBLE GL_FALSE 0 0

  showError "color buffer "
  pure $ (vao, buffer, colorBuffer)


destroyBuffers : Vao -> Buffer -> Buffer -> IO ()
destroyBuffers vao buffer colorBuffer = do
  glDisableVertexAttribArray 1
  glDisableVertexAttribArray 0
  
  glUnbindBuffer GL_ARRAY_BUFFER

  glDeleteBuffer buffer
  glDeleteBuffer colorBuffer

  glUnbindVertexArray
  
  glDeleteVertexArray vao

  showError "destroy buffers "

data State = MkState GlfwWindow Vao Program (Double, Double) Double

draw : State -> IO ()
draw (MkState win vao prog (z, x) rotation) = do 
                   glClearColor 0 0 0 1
                   glClear GL_COLOR_BUFFER_BIT
                   glClear GL_DEPTH_BUFFER_BIT
                   glBindVertexArray vao
                   glUseProgram prog

                   --putStrLn $ "Drawing at " ++ (show distance) ++ " / " ++ (show rotation)
                   loc <- glGetUniformLocation prog "transformMatrix"
                   glUniformMatrix4fv loc $ (translate [x, 0, z]) <> (rotateZ (Degree rotation))

                   glDrawArrays GL_TRIANGLES 0 3
                   glfwSwapBuffers win
                   
                   
initDisplay : String -> Int -> Int -> IO GlfwWindow
initDisplay title width height = do
  glfw <- glfwInit
  glfwWindowHint GLFW_CONTEXT_VERSION_MAJOR  4
  glfwWindowHint GLFW_CONTEXT_VERSION_MINOR  1
  glfwWindowHint GLFW_OPENGL_FORWARD_COMPAT  1
  glfwWindowHint GLFW_OPENGL_PROFILE         (toInt GLFW_OPENGL_CORE_PROFILE)
  win <- glfwCreateWindow title width height defaultMonitor
  -- now we pretend every thing is going to be ok
  glfwMakeContextCurrent win
  glewInit
  info <- glGetInfo
  putStrLn info
  glEnable GL_DEPTH_TEST
  glDepthFunc GL_LESS
  return win

isKeyPressed : GlfwWindow -> Char -> IO Bool
isKeyPressed win key = do 
  ev <- glfwGetKey win key 
  if ev == GLFW_PRESS
  then return True
  else return False

updateState :State -> IO State
updateState (MkState win vao prog (z, x) rotation) = do
  w <- isKeyPressed win 'W'
  s <- isKeyPressed win 'S'
  let z' = if w then z - 0.002 else z
  let z'' = if s then z' + 0.002 else z'
  left  <- isKeyPressed win 'A'
  right <- isKeyPressed win 'D'
  let x' = if left then x - 0.002 else x
  let x'' = if right then x' + 0.002 else x'
  return $ MkState win vao prog (z'', x'') (rotation + 0.2)

main : IO ()
main = do win <- initDisplay "Hello Idris" 640 480
          glfwSetInputMode win GLFW_STICKY_KEYS 1
          glfwSwapInterval 0
          (vertexShader, fragmentShader, prog) <- createShaders
          (vao, buffer, colorBuffer) <- createBuffers
          eventLoop $ MkState win vao prog (-1.0, 0.0) 0.0
          printShaderLog vertexShader
          destroyBuffers vao buffer colorBuffer
          destroyShaders (vertexShader, fragmentShader, prog)
          glfwDestroyWindow win
          glfwTerminate
          pure ()
       where 
         eventLoop : State -> IO ()
         eventLoop state@(MkState win vao prog distance rotation) = do
                      draw state 
                      glfwPollEvents
                      key <- glfwGetFunctionKey win GLFW_KEY_ESCAPE
                      shouldClose <- glfwWindowShouldClose win
                      if shouldClose || key == GLFW_PRESS
                      then pure ()
                      else do 
                        state' <- updateState state
                        eventLoop state'
