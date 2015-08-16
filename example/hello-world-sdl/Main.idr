module Main

import Graphics.SDL2.SDL

import Control.Algebra
import Data.Matrix

import Graphics.Util.Transforms
import Graphics.Util.ObjLoader
import Graphics.Util.Mesh
import Graphics.Rendering.Gl
import Graphics.Rendering.Config

%include C "GL/glew.h"
%flag C "-Wno-pointer-sign"

record Time where
  constructor MkTime
  ticks : Integer
  lastFrame: Integer
  
record ShaderLocations where
  constructor Locs
  viewMatrixLocation : Int
  
record State where
  constructor MkState
  renderer: SDLRenderer
  window: SDLWindow
  display : Display
  camera  : Camera
  locations: ShaderLocations
  entities : List (Entity String)

updateCameraPosition : State -> (Vec3 -> Vec3) -> State
updateCameraPosition state f = record { camera->position = f (record {camera->position} state) } state

||| TODO: update direction based on mouse movement
updateCameraDirection : State -> Int -> Int -> State
updateCameraDirection state dx dy = state


update: Event -> State -> State
update (KeyDown (KeyAny 'w'))  state = updateCameraPosition state (\p => p <-> [0,    0,    0.05])
update (KeyDown (KeyAny 's'))  state = updateCameraPosition state (\p => p <+> [0,    0,    0.05])
update (KeyDown (KeyAny 'a'))  state = updateCameraPosition state (\p => p <-> [0.05, 0,    0])
update (KeyDown (KeyAny 'd'))  state = updateCameraPosition state (\p => p <+> [0.05, 0,    0])
update (KeyDown KeyUpArrow)    state = updateCameraPosition state (\p => p <+> [0,    0.05, 0])
update (KeyDown KeyDownArrow)  state = updateCameraPosition state (\p => p <-> [0,    0.05, 0])
update (KeyDown _)             state = state
update (KeyUp x)               state = state
update (MouseMotion x y dx dy) state = updateCameraDirection state dx dy
update (MouseButtonDown x y z) state = state
update (MouseButtonUp x y z)   state = state
update (MouseWheel x)          state = state
update (Resize x y)            state = state
update AppQuit                 state = state
update WindowEvent             state = state


draw : State -> IO ()
draw state = do 
                glClearColor 0.2 0.2 0.2 1
                glClear GL_COLOR_BUFFER_BIT
                glClear GL_DEPTH_BUFFER_BIT
                
                let locView = record {locations->viewMatrixLocation} state
                let cameraDirection = record {camera->direction} state
                glUniformMatrix4fv locView 1 0 (toList $ toGl $ standardViewMatrix cameraDirection)
                   
                traverse (\entity => render entity (camera state) (\_ => pure ())) (entities state)
                   
                glSwapWindow $ window state

                   
camera : Camera
camera = MkCamera [0.0, 0.0, 0.0] (Degree 45) 0.1 100.0 [0.0, 0.0, -1.0]

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
          
          texture <- loadTexture "stone.png" 0          
          plane <- loadObj "stone.obj"
          planeModel <- createModel plane [texture]
          
          shader <- createShaders [(GL_VERTEX_SHADER, "shader.vert"), (GL_FRAGMENT_SHADER, "shader.frag")]
          traverse printShaderLog  (shaders shader)
          glUseProgram $ program shader
          
          locView <- glGetUniformLocation (program shader) "viewMatrix"
          glUniformMatrix4fv locView 1 0 (toList $ toGl $ viewMatrix [0,0,-1] [0,0,0] [0,1,0])

          locProj <- glGetUniformLocation (program shader) "projectionMatrix"
          let projM = perspectiveProjection (fov camera) (aspectRatio display) ((nearPlane camera), (farPlane camera))
          glUniformMatrix4fv locProj 1 0 (toList $ toGl projM)

          loc <- glGetUniformLocation (program shader) "transformMatrix"          

          let entity = SimpleEntity planeModel shader [0,-0.5,-3] [(Degree 0),(Degree 0),(Degree 0)] loc "Test"
          
          let initialState = MkState renderer win display camera (Locs locView) [entity]
          eventLoop initialState
          deleteModel planeModel
          deleteShaders shader
          deleteTextures [texture]
          --deleteGLContext ctx
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
                                              eventLoop $ update event state
                           _            => eventLoop state


