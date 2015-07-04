module Main


import Graphics.Rendering.Gl
import Graphics.Util.Glfw
import Graphics.Rendering.Config

%include C "GL/glew.h"

showError : String -> IO ()
showError msg = do err <- glGetError
                   putStrLn $ msg ++ (show err)

createShaders : IO (Shader, Shader, Program)
createShaders = do
  glGetError
  vertexShader <- glCreateShader GL_VERTEX_SHADER
  
  vtx <- readFile "shader.vtx"
  glShaderSource vertexShader vtx
  glCompileShader vertexShader
  printShaderLog vertexShader

  fragmentShader <- glCreateShader GL_FRAGMENT_SHADER

  frg <- readFile "shader.frg"
  glShaderSource fragmentShader frg 
  glCompileShader fragmentShader  
  printShaderLog fragmentShader

  program <- glCreateProgram
  glAttachShader program vertexShader
  glAttachShader program fragmentShader
  
  glLinkProgram program
  glUseProgram program
  showError "link and use "
  printShaderLog vertexShader
  printShaderLog fragmentShader

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

createBuffers : IO (Vao, Buffer, Buffer, Buffer)
createBuffers = do
  {--
    v2 ---  v1
    |    /  |
    |   /   |
    v3 --   v4
  --}
  let vertices = [
    [   0.8,  0.8, 0.0, 1.0],
    [  -0.8,  0.8, 0.0, 1.0],
    [  -0.8, -0.8, 0.0, 1.0],
    [   0.8, -0.8, 0.0, 1.0]
  ]

  let indices = the (List Int) [
    0, 1, 2, 
    2, 3, 0]
  
  let textureCoords = [
    [1.0, 0.0],
    [0.0, 0.0],
    [0.0, 1.0],
    [1.0, 1.0]
  ]
  glGetError

  vao <- glGenVertexArrays
  glBindVertexArray vao
  buffer <- glGenBuffers
  glBindBuffer GL_ARRAY_BUFFER buffer
  glBufferData GL_ARRAY_BUFFER (flatten vertices) GL_STATIC_DRAW
  showError "vertex buffer data "
  glEnableVertexAttribArray 0
  glVertexAttribPointer 0 4 GL_DOUBLE GL_FALSE 0 0

  texBuffer <- glGenBuffers
  glBindBuffer GL_ARRAY_BUFFER texBuffer
  glBufferData GL_ARRAY_BUFFER (flatten textureCoords) GL_STATIC_DRAW
  glEnableVertexAttribArray 1
  glVertexAttribPointer 1 2 GL_DOUBLE GL_FALSE 0 0
  showError "texture coords buffer "

  indexBuffer <- glGenBuffers
  glBindBuffer GL_ELEMENT_ARRAY_BUFFER indexBuffer
  glBufferDatai GL_ELEMENT_ARRAY_BUFFER indices GL_STATIC_DRAW

  showError "index buffer "
  pure $ (vao, buffer, texBuffer, indexBuffer)


destroyBuffers : Vao -> Buffer -> Buffer -> Buffer -> IO ()
destroyBuffers vao buffer texBuffer indexBuffer = do
  glDisableVertexAttribArray 1
  glDisableVertexAttribArray 0
  
  glUnbindBuffer GL_ARRAY_BUFFER
  glUnbindBuffer GL_ELEMENT_ARRAY_BUFFER

  showError "destroy buffers "
  glDeleteBuffer buffer
  glDeleteBuffer texBuffer
  glDeleteBuffer indexBuffer

  glUnbindVertexArray
  
  glDeleteVertexArray vao

  showError "destroy buffers "

draw : GlfwWindow -> Vao -> IO ()
draw win vao = do 
                   glClearColor 1 1 1 1
                   glClear GL_COLOR_BUFFER_BIT
                   glClear GL_DEPTH_BUFFER_BIT
                   glBindVertexArray vao
                   glDrawElements GL_TRIANGLES 6
                   --glDrawArrays GL_TRIANGLES 0 3
                   glfwSwapBuffers win
                   
                   
initDisplay : String -> Int -> Int -> IO GlfwWindow
initDisplay title width height = do
  glfw <- glfwInit
  glfwWindowHint GLFW_CONTEXT_VERSION_MAJOR  4
  glfwWindowHint GLFW_CONTEXT_VERSION_MINOR  1
  glfwWindowHint GLFW_OPENGL_FORWARD_COMPAT  1
  glfwWindowHint GLFW_OPENGL_PROFILE         (toInt GLFW_OPENGL_CORE_PROFILE)
  win <- glfwCreateWindow title width height defaultMonitor
  -- TODO: test for failure - for now we pretend every thing is going to be ok
  -- terminate 
  glfwMakeContextCurrent win
  glewInit
  info <- glGetInfo
  putStrLn info
  glEnable GL_DEPTH_TEST
  glDepthFunc GL_LESS
  return win

main : IO ()
main = do win <- initDisplay "Hello Idris" 800 600
          --win <- createWindow "Hello World" 640 480 
          glfwSetInputMode win GLFW_STICKY_KEYS 1
          glfwSwapInterval 0
          shaders <- createShaders
          (vao, buffer, texBuffer, indexBuffer) <- createBuffers
          
          glActiveTexture GL_TEXTURE0 -- load the texture into unit 0
          texture <- glLoadPNGTexture "bricks_low.png"
          -- the texture is bound ... so we can set some params
          glTexParameteri GL_TEXTURE_2D GL_TEXTURE_WRAP_S GL_REPEAT
          glTexParameteri GL_TEXTURE_2D GL_TEXTURE_WRAP_T GL_REPEAT
          glTexParameteri GL_TEXTURE_2D GL_TEXTURE_MIN_FILTER GL_NEAREST
          glTexParameteri GL_TEXTURE_2D GL_TEXTURE_MAG_FILTER GL_NEAREST
          
          eventLoop win vao
          glDeleteTextures [texture]
          destroyBuffers vao buffer texBuffer indexBuffer
          destroyShaders shaders
          glfwDestroyWindow win
          glfwTerminate
          pure ()
       where 
         eventLoop : GlfwWindow -> Vao -> IO ()
         eventLoop win vao = do
                      draw win vao
                      glfwPollEvents
                      key <- glfwGetKey win GLFW_KEY_ESCAPE
                      shouldClose <- glfwWindowShouldClose win
                      if shouldClose || key == GLFW_PRESS
                      then pure ()
                      else eventLoop win vao
                              
