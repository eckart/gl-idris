module Effect.Glfw

import Effects
import public Graphics.Util.Glfw

%access public 

data GlfwMode : Type where
  On : GlfwMode

data Glfw : Effect where
  ||| initialises Glfw 
  Initialise : sig Glfw Bool () (\res => if res then GlfwMode else ())
  WithGlfw : (GlfwMode -> IO a) 
               -> sig Glfw a GlfwMode (\w => GlfwMode)
  Terminate : sig Glfw () GlfwMode ()

instance Handler Glfw IO where
  handle () Initialise    k = do ret <- glfwInit
                                 if ret then k True On
                                        else k False ()
  handle On (WithGlfw f)  k = do r <- f On; k r On
  handle On Terminate     k = do glfwTerminate; k () ()


GLFW : Type -> EFFECT
GLFW res = MkEff res Glfw

GLFW_ON : EFFECT
GLFW_ON = GLFW GlfwMode

initialise : { [GLFW ()] ==> {res} [GLFW (if res then GlfwMode else ())] } Eff Bool
initialise = call Initialise

terminate : { [GLFW_ON] ==> [GLFW ()] } Eff ()
terminate = call Terminate

swapInterval : Nat -> { [GLFW_ON] } Eff ()
swapInterval n = call $ WithGlfw (\_ => glfwSwapInterval (toIntNat n))

windowHint : GlfwFlags -> Int -> { [GLFW_ON] } Eff ()
windowHint flag i = call $ WithGlfw (\_ => glfwWindowHint flag i)


data GlfwWindowEff : Effect where
  ||| creates a Glfw window
  CreateWindow : (title: String)
                 -> (width: Int) 
                 -> (height: Int) 
                 -> sig GlfwWindowEff Bool () (\res => if res then GlfwWindow else ())
  Poll : sig GlfwWindowEff () GlfwWindow GlfwWindow
  WithWindow : (GlfwWindow -> IO a) 
               -> sig GlfwWindowEff a GlfwWindow (\w => GlfwWindow)
  DestroyWindow : sig GlfwWindowEff () GlfwWindow ()

GLFW_WINDOW : Type -> EFFECT
GLFW_WINDOW res = MkEff res GlfwWindowEff

GLFW_WINDOW_ON : EFFECT
GLFW_WINDOW_ON = GLFW_WINDOW GlfwWindow

instance Handler GlfwWindowEff IO where
  handle () (CreateWindow title width height) k = 
    do win <- glfwCreateWindow title width height defaultMonitor 
       isNull <- isWindow win
       if isNull then k False ()
                 else k True win
  handle win Poll            k = do glfwPollEvents; k () win
  handle win (WithWindow f)  k = do r <- f win; k r win
  handle win DestroyWindow   k = do glfwDestroyWindow win; k () ()

createWindow : String -> Int -> Int -> { [GLFW_WINDOW ()] ==> {res} [GLFW_WINDOW (if res then GlfwWindow else ())]} Eff Bool
createWindow title width height = call $ CreateWindow title width height

pollEvents :  { [GLFW_WINDOW_ON] } Eff ()
pollEvents = call Poll

makeContextCurrent : { [GLFW_WINDOW_ON] } Eff ()
makeContextCurrent = call $ WithWindow (\win => glfwMakeContextCurrent win)

swapBuffers : { [GLFW_WINDOW_ON] } Eff ()
swapBuffers = call $ WithWindow (\win => glfwSwapBuffers win)

getKey : FunctionKey -> { [GLFW_WINDOW_ON] } Eff KeyEventTy
getKey key = call $ WithWindow (\win => glfwGetKey win key)

initGlew : { [GLFW_WINDOW_ON] } Eff ()
initGlew = call $ WithWindow (\_ => do glewInit; pure () )

setInputMode : GlfwFlags -> Int -> { [GLFW_WINDOW_ON] } Eff ()
setInputMode flag val = call $ WithWindow (\win => glfwSetInputMode win flag val)

shouldClose : { [GLFW_WINDOW_ON] } Eff Bool
shouldClose = call $ WithWindow (\win => glfwWindowShouldClose win)

destroyWindow : { [GLFW_WINDOW_ON] ==> [GLFW_WINDOW ()] } Eff ()
destroyWindow = call DestroyWindow

