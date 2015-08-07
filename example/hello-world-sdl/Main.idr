module Main

import Control.Algebra
import Graphics.Util.Math3D as T
import Data.Matrix

import Graphics.Rendering.Gl
import Graphics.Rendering.Gl.Types
import Graphics.Rendering.Gl.Gl41
import Graphics.Util.Glfw
import Graphics.Util.Mesh
import Graphics.Rendering.Config
import Graphics.Util.ObjLoader

%include C "GL/glew.h"
%flag C "-Wno-pointer-sign"

record State where
  constructor MkState
  win: GlfwWindow
  entity : Entity String

draw : State -> IO ()
draw (MkState win entity) = do 
                   glClearColor 0.2 0.2 0.2 1
                   glClear GL_COLOR_BUFFER_BIT
                   glClear GL_DEPTH_BUFFER_BIT
                   
                   render entity (\_ => pure ())
                   
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

main : IO ()
main = do win <- initDisplay "Hello Idris" 640 480
          glfwSetInputMode win GLFW_STICKY_KEYS 1
          glfwSwapInterval 0

          texture <- loadTexture "tiles.png" 0          
          plane <- loadObj "plane.obj"
          planeModel <- createModel plane [texture]
          
          shader <- createShaders [(GL_VERTEX_SHADER, "shader.vert"), (GL_FRAGMENT_SHADER, "shader.frag")]
          traverse printShaderLog  (shaders shader)
          
          let entity = SimpleEntity planeModel shader [0,0,0] [0,0,0] "Test"

          eventLoop $ MkState win entity
          
          deleteModel planeModel
          deleteShaders shader
          deleteTextures [texture]

          glfwDestroyWindow win
          glfwTerminate
          pure ()
       where 
         eventLoop : State -> IO ()
         eventLoop state = do
                      draw state 
                      glfwPollEvents
                      key <- glfwGetFunctionKey (win state) GLFW_KEY_ESCAPE
                      shouldClose <- glfwWindowShouldClose (win state)
                      if shouldClose || key == GLFW_PRESS
                      then pure ()
                      else do 
                        eventLoop state

