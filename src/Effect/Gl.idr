module Effect.Gl

import Data.Vect
import Data.List as L
import Effects
import public Graphics.Rendering.Gl

%access public 

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

data Color = RGBA Double Double Double Double

data Vertex = Vertex4 Double Double Double Double

flatten : Vect n Vertex -> List Double
flatten []                        = []
flatten ((Vertex4 x y z w) :: vs) = [x, y, z, w] ++ (flatten vs)

data Shaders = MkShaders Shader Shader Program

data Model = 
  ||| a model consisting of a vertex buffer and a color buffer
  ColoredModel Vao Nat Buffer Buffer Shaders DrawingMode

|||
||| TODO add error handling
createShaders : (vertexShaderName: String) -> (fragmentShaderName: String) ->  IO Shaders
createShaders vertexShaderName fragmentShaderName = do
  vertexShader <- glCreateShader GL_VERTEX_SHADER
  vtx <- readFile vertexShaderName
  glShaderSource vertexShader vtx
  glCompileShader vertexShader
  
  fragmentShader <- glCreateShader GL_FRAGMENT_SHADER
  frg <- readFile fragmentShaderName
  glShaderSource fragmentShader frg 
  glCompileShader fragmentShader  
  
  program <- glCreateProgram
  glAttachShader program vertexShader
  glAttachShader program fragmentShader
  
  glLinkProgram program
  glUseProgram noProgram
  pure $ MkShaders vertexShader fragmentShader program


createColoredModel' : (vertices: (Vect n Vertex)) 
           -> (colors: (Vect n Vertex)) 
           -> (vertextShader: String)
           -> (fragmentShader: String)
           -> GlUsage
           -> DrawingMode
           -> IO Model
createColoredModel' {n} vertices colors vsh frsh usage mode = 
  do vao <- glGenVertexArrays
     glBindVertexArray vao
     buffer <- glGenBuffers
     glBindBuffer GL_ARRAY_BUFFER buffer
     glBufferData GL_ARRAY_BUFFER (flatten vertices) usage
     glEnableVertexAttribArray 0
     glVertexAttribPointer 0 4 GL_DOUBLE GL_FALSE 0 0

     colorBuffer <- glGenBuffers
     glBindBuffer GL_ARRAY_BUFFER colorBuffer
     glBufferData GL_ARRAY_BUFFER (flatten colors) usage
     glEnableVertexAttribArray 1
     glVertexAttribPointer 1 4 GL_DOUBLE GL_FALSE 0 0
     glUnbindVertexArray
     
     shaders <- createShaders vsh frsh
     pure $ ColoredModel vao n buffer colorBuffer shaders mode


createColoredModel : (vertices: (Vect n Vertex)) 
           -> (colors: (Vect n Vertex)) 
           -> (vertextShader: String)
           -> (fragmentShader: String)
           -> GlUsage
           -> DrawingMode
           -> { [GL_ON] } Eff Model
createColoredModel vs cs vsh frsh u mode = call $ WithGl (\_ => createColoredModel' vs cs vsh frsh u mode)

getProgram : Model -> Program
getProgram (ColoredModel _ _ _ _ (MkShaders _ _ program) _) = program

renderModel' : Model -> IO ()
renderModel' (ColoredModel vao n _ _ (MkShaders _ _ program) mode) =
  do glUseProgram program
     glBindVertexArray vao

     glDrawArrays mode 0 (toIntNat n)

     glUnbindVertexArray
     glUseProgram noProgram

renderModel : Model -> { [GL_ON] } Eff ()
renderModel m = call $ WithGl (\_ => renderModel' m)

clear' : Color -> List GLbitfields -> IO ()
clear' (RGBA r g b a) bits = do glClearColor r g b a
                                glClearAll bits
                                pure ()


clear : Color -> List GLbitfields -> { [GL_ON] } Eff ()
clear color bits = call $ WithGl (\_ => clear' color bits)

destroyShaders : Shaders -> IO ()
destroyShaders (MkShaders shader1 shader2 program) = do
  glUseProgram noProgram
  glDetachShader program shader1
  glDetachShader program shader2
  glDeleteShader shader1
  glDeleteShader shader2
  glDeleteProgram program
  pure ()


destroyModel' : Model -> IO ()
destroyModel' (ColoredModel vao _ vertexBuffer colorBuffer shaders _) =
  do glDisableVertexAttribArray 1
     glDisableVertexAttribArray 0
     glUnbindBuffer GL_ARRAY_BUFFER
     glDeleteBuffer vertexBuffer
     glDeleteBuffer colorBuffer
     glUnbindVertexArray
     glDeleteVertexArray vao
     destroyShaders shaders
     pure ()

destroyModel : Model -> { [GL_ON] } Eff ()
destroyModel m = call $ WithGl (\_ => destroyModel' m)


