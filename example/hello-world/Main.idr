module Main

import Graphics.Rendering.Gl.Types
import Graphics.Rendering.Gl.Buffers
import Graphics.Rendering.Gl.Gl41
import Graphics.Rendering.Gl
import Graphics.Util.Glfw
import Graphics.Rendering.Config

%include C "GL/glew.h"
%flag C "-Wno-pointer-sign"

flatten : List (Double, Double, Double, Double) -> List Double
flatten [] = []
flatten ((a,b,c,d) :: xs) = [a,b,c,d] ++ (flatten xs)

showError : String -> IO ()
showError msg = do err <- glGetError
                   if err == 0
                   then putStrLn $ msg ++ " -  OK "
                   else putStrLn $ msg ++ (show err)

record Shaders where
  constructor MkShaders
  vertexShader : Int
  fragmentShader : Int
  program : Int


createShaders : IO (Either FileError Shaders)
createShaders = do
  glGetError
  vertexShader <- glCreateShader GL_VERTEX_SHADER

  showError "create vertex shader "
  Right vtx <- readFile "shader.vtx" | Left err => pure (Left err)
  glShaderSource vertexShader 1 [vtx] [(cast $ length vtx)]
  glCompileShader vertexShader

  fragmentShader <- glCreateShader GL_FRAGMENT_SHADER
  showError "create fragment shader "

  Right frg <- readFile "shader.frg" | Left err => pure (Left err)
  glShaderSource fragmentShader 1 [frg] [(cast $ length frg)]
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

  pure $ Right (MkShaders vertexShader fragmentShader program)


destroyShaders : Shaders -> IO ()
destroyShaders (MkShaders shader1 shader2 program) = do
  glGetError
  glUseProgram 0
  glDetachShader program shader1
  glDetachShader program shader2
  glDeleteShader shader1
  glDeleteShader shader2
  glDeleteProgram program
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

record Vao where
  constructor MkVao
  id : Int
  buffer1 : Int
  buffer2 : Int

createBuffers : IO Vao
createBuffers = do
  ds <- sizeofDouble
  glGetError

  (vao :: _) <- glGenVertexArrays 1

  glBindVertexArray vao
  (buffer :: colorBuffer :: _) <- glGenBuffers 2
  glBindBuffer GL_ARRAY_BUFFER buffer

  let data1 = (flatten vertices)
  ptr <- doublesToBuffer data1
  glBufferData GL_ARRAY_BUFFER (ds * (cast $ length data1)) ptr GL_STATIC_DRAW
  free ptr

  showError "vertex buffer data "
  glEnableVertexAttribArray 0
  glVertexAttribPointer 0 4 GL_DOUBLE GL_FALSE 0 prim__null


  glBindBuffer GL_ARRAY_BUFFER colorBuffer

  let data2 = (flatten colors)
  ptr2 <- doublesToBuffer data2
  glBufferData GL_ARRAY_BUFFER (ds * (cast $ length data2)) ptr2 GL_STATIC_DRAW
  free ptr2

  glEnableVertexAttribArray 1
  glVertexAttribPointer 1 4 GL_DOUBLE GL_FALSE 0 prim__null
  showError "color buffer "

  pure $ MkVao vao buffer colorBuffer


destroyBuffers : Vao -> IO ()
destroyBuffers (MkVao vao buffer colorBuffer) = do
  glDisableVertexAttribArray 1
  glDisableVertexAttribArray 0

  glBindBuffer GL_ARRAY_BUFFER 0

  glDeleteBuffers 2 [buffer, colorBuffer]

  glBindVertexArray 0

  glDeleteVertexArrays 1 [vao]

  showError "destroy buffers "

data State = MkState GlfwWindow Vao Shaders

draw : State -> IO ()
draw (MkState win vao (MkShaders _ _ prog)) = do
                   glClearColor 0 0 0 1
                   glClear GL_COLOR_BUFFER_BIT
                   glClear GL_DEPTH_BUFFER_BIT
                   glBindVertexArray (id vao)
                   glUseProgram prog

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
  pure win

main : IO ()
main = do win <- initDisplay "Hello Idris" 640 480
          glfwSetInputMode win GLFW_STICKY_KEYS 1
          glfwSwapInterval 0
          Right shaders <- createShaders | Left err => do
            putStrLn $ show err
            pure()
          vao <- createBuffers
          eventLoop $ MkState win vao shaders
          destroyBuffers vao
          destroyShaders shaders
          glfwDestroyWindow win
          glfwTerminate
          pure ()
       where
         eventLoop : State -> IO ()
         eventLoop state@(MkState win vao prog) = do
                      draw state
                      glfwPollEvents
                      key <- glfwGetFunctionKey win GLFW_KEY_ESCAPE
                      shouldClose <- glfwWindowShouldClose win
                      if shouldClose || key == GLFW_PRESS
                      then pure ()
                      else do
                        eventLoop state
