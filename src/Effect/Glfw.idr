module Effect.Glfw

import Effects
import public Graphics.Util.Glfw

data GlfwMode : Type where
  On : GlfwMode

data Glfw : Effect where
  ||| initialises Glfw 
  Initialise : sig Glfw Int () (\res => case res of 
                                       1 => GlfwMode
                                       _ => ())
  Terminate : sig Glfw () GlfwMode ()

instance Handler Glfw IO where
  handle () Initialise k = do ret <- glfwInit
                              if (ret == 1) then k 1 On
                                            else k 0 ()
  handle On Terminate k = do glfwTerminate; k () ()


GLFW : Type -> EFFECT
GLFW res = MkEff res Glfw

GLFW_ON : EFFECT
GLFW_ON = GLFW GlfwMode

initialise : { [GLFW ()] ==> {res} [GLFW (case res of
                                         1 => GlfwMode
                                         _ => ())] } Eff Int
initialise = call Initialise

terminate : { [GLFW_ON] ==> [GLFW ()] } Eff ()
terminate = call Terminate


data GlfwWindowEff : Effect where
  ||| creates a Glfw window
  CreateWindow : (title: String)
                 -> (width: Int) 
                 -> (height: Int) 
                 -> sig GlfwWindowEff Bool () (\res => case res of
                                                  True  => GlfwWindow
                                                  False => ())
  DestroyWindow : sig GlfwWindowEff () GlfwWindow ()

instance Handler GlfwWindowEff IO where
  handle () (CreateWindow title width height) k = 
    do win <- glfwCreateWindow title width height defaultMonitor 
       isNull <- isWindow win
       if isNull then k True win
                 else k False ()
  handle win DestroyWindow k = do glfwDestroyWindow win; k () ()




-- init --> createwindow 
{--
  glfw <- init
  windowHint GLFW_CONTEXT_VERSION_MAJOR  4
  windowHint GLFW_CONTEXT_VERSION_MINOR  1
  windowHint GLFW_OPENGL_FORWARD_COMPAT  1
  windowHint GLFW_OPENGL_PROFILE         (toInt GLFW_OPENGL_CORE_PROFILE)
  win <- createWindow title width height defaultMonitor
  -- TODO: test for failure - for now we pretend every thing is going to be ok
  -- terminate 
  makeContextCurrent win
--}
