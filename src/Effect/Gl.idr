module Effect.Gl

import Effects
import public Graphics.Util.Color
import public Graphics.Rendering.Gl.Types
import public Graphics.Rendering.Gl.Gl41
import public Graphics.Rendering.Gl

%access public export

data GlState : Type where
  GlOn : GlState

data Gl : Effect where
  Initialise : sig Gl () () (\v => GlState)
  WithGl : (GlState -> IO a) -> sig Gl a GlState (\w => GlState)
  Terminate : sig Gl () GlState (\_ => ())

instance Handler Gl IO where
  handle () Initialise  k = k () GlOn
  handle GlOn (WithGl f)  k = do r <- f GlOn; k r GlOn
  handle GlOn Terminate   k = k () ()


GL : Type -> EFFECT
GL res = MkEff res Gl

GL_ON : EFFECT
GL_ON = GL GlState

GL_OFF : EFFECT
GL_OFF = GL ()

startGl : { [GL_OFF] ==> [GL_ON] } Eff ()
startGl = call Initialise

stopGl : { [GL_ON] ==> [GL_OFF] } Eff ()
stopGl = call Terminate


clear' : Color -> List ClearBufferMask -> IO ()
clear' (RGBA r g b a) masks = do glClearColor r g b a
                                 traverse glClear masks
                                 pure ()


clear : Color -> List ClearBufferMask -> { [GL_ON] } Eff ()
clear color masks = call $ WithGl (\_ => clear' color masks)
