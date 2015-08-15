module Main

import Graphics.SDL2.SDL
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
  renderer: SDLRenderer
  window: SDLWindow
  display : Display
  camera  : Camera
  entity : Entity String

draw : State -> IO ()
draw (MkState renderer win display camera entity) = do 
                   glClearColor 0.2 0.2 0.2 1
                   glClear GL_COLOR_BUFFER_BIT
                   glClear GL_DEPTH_BUFFER_BIT
                   
                   render entity (\_ => pure ())
                   
                   glSwapWindow win

                   
camera : Camera
camera = MkCamera [0.0, 0.0, 0.0] (Degree 45) 0.1 100.0

display : Display
display = MkDisplay 640 480

main : IO ()
main = do 
          initSDL
          glSetAttribute SDL_GL_CONTEXT_PROFILE_MASK (toSDLInt SDL_GL_CONTEXT_PROFILE_CORE)
          glSetAttribute SDL_GL_CONTEXT_MAJOR_VERSION 4
          glSetAttribute SDL_GL_CONTEXT_MINOR_VERSION 1
          glSetAttribute SDL_GL_ACCELERATED_VISUAL 1
          glSetAttribute SDL_GL_DOUBLEBUFFER  1
          glSetAttribute SDL_GL_DEPTH_SIZE 16

          (win,renderer) <- startSDL "Hello Idris" 800 600
          ctx <- createGLContext win
          glMakeCurrent win ctx
          
          glSetSwapInterval 1
          
          glewInit
          info <- glGetInfo
          putStrLn info
          glEnable GL_DEPTH_TEST
          glDepthFunc GL_LESS
          
          texture <- loadTexture "tiles.png" 0          
          plane <- loadObj "plane.obj"
          planeModel <- createModel plane [texture]
          
          shader <- createShaders [(GL_VERTEX_SHADER, "shader.vert"), (GL_FRAGMENT_SHADER, "shader.frag")]
          traverse printShaderLog  (shaders shader)
          glUseProgram $ program shader
          
          locView <- glGetUniformLocation (program shader) "viewMatrix"
          glUniformMatrix4fv locView 1 0 (toList $ toGl identity)

          locProj <- glGetUniformLocation (program shader) "projectionMatrix"
          let projM = perspectiveProjection (fov camera) (aspectRatio display) ((nearPlane camera), (farPlane camera))
          glUniformMatrix4fv locProj 1 0 (toList $ toGl projM)

          loc <- glGetUniformLocation (program shader) "transformMatrix"          

          let entity = SimpleEntity planeModel shader [0,0,-3] [(Degree 0),(Degree 0),(Degree 0)] loc "Test"
          
          let initialState = MkState renderer win display camera entity
          eventLoop initialState
          deleteModel planeModel
          deleteShaders shader
          deleteTextures [texture]
          deleteGLContext ctx
          endSDL win renderer
          pure ()
       where 
         eventLoop : State -> IO ()
         eventLoop state = do
                         e <- pollEvent
                         case e of
                           Just AppQuit => return ()
                           Just event   => do draw state
                                              --handle r event
                                              putStrLn $ "event" ++ (show event)
                                              eventLoop state
                           _            => eventLoop state


