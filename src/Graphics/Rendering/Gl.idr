module Graphics.Rendering.Gl

import Graphics.Util.Math3D as T

%include C "GL/glew.h"
%include C "GLFW/glfw3.h"
%include C "gl_idris.h"
%link C "gl_idris.o"

%access private

public
Vec3 : Type
Vec3 = Vect 3 Double

-- --------------------------------------------------------------

writeBuffer : List Double -> IO Ptr
writeBuffer ds = 
  do ptr <- foreign FFI_C "idr_allocate_doubles" (Int -> IO Ptr) (toIntNat (length ds))
     writeBuffer' ptr Z ds
     pure ptr
  where writeBuffer' : Ptr -> Nat -> List Double -> IO ()
        writeBuffer' ptr i []        = pure ()
        writeBuffer' ptr i (d :: ds) = do foreign FFI_C "idr_set_double" (Ptr -> Int -> Double -> IO()) ptr (toIntNat i) d
                                          writeBuffer' ptr (S i) ds

writeFloatBuffer : List Double -> IO Ptr
writeFloatBuffer ds = 
  do ptr <- foreign FFI_C "idr_allocate_floats" (Int -> IO Ptr) (toIntNat (length ds))
     writeBuffer' ptr Z ds
     pure ptr
  where writeBuffer' : Ptr -> Nat -> List Double -> IO ()
        writeBuffer' ptr i []        = pure ()
        writeBuffer' ptr i (d :: ds) = do foreign FFI_C "idr_set_float" (Ptr -> Int -> Double -> IO()) ptr (toIntNat i) d
                                          writeBuffer' ptr (S i) ds

writeIntBuffer : List Int -> IO Ptr
writeIntBuffer ds = 
  do ptr <- foreign FFI_C "idr_allocate_ints" (Int -> IO Ptr) (toIntNat (length ds))
     writeBuffer' ptr Z ds
     pure ptr
  where writeBuffer' : Ptr -> Nat -> List Int -> IO ()
        writeBuffer' ptr i []        = pure ()
        writeBuffer' ptr i (d :: ds) = do foreign FFI_C "idr_set_int" (Ptr -> Int -> Int -> IO()) ptr (toIntNat i) d
                                          writeBuffer' ptr (S i) ds

free : Ptr -> IO ()
free ptr = foreign FFI_C "free" (Ptr -> IO ()) ptr
 
-- --------------------------------------------------------------

class GlId a where
  getId: a -> Int

class GlEnum a b where
  toGlInt   : a -> b

class GlEnum a b => GlConstant a b where
  fromGlInt : b -> a

public 
data GlBool = GL_TRUE | GL_FALSE

instance GlEnum GlBool Int where
  toGlInt GL_TRUE  = 0
  toGlInt GL_FALSE = 1

public
data GLbitfields
  = GL_DEPTH_BUFFER_BIT
  | GL_ACCUM_BUFFER_BIT
  | GL_STENCIL_BUFFER_BIT
  | GL_COLOR_BUFFER_BIT

instance GlEnum GLbitfields Int where
  toGlInt  GL_DEPTH_BUFFER_BIT     = 0x00000100
  toGlInt  GL_ACCUM_BUFFER_BIT     = 0x00000200
  toGlInt  GL_STENCIL_BUFFER_BIT   = 0x00000400
  toGlInt  GL_COLOR_BUFFER_BIT     = 0x00004000
  
data GlInfo
  = GL_VENDOR
  | GL_RENDERER
  | GL_VERSION
  | GL_EXTENSIONS
  | GL_SHADING_LANGUAGE_VERSION

instance GlEnum GlInfo Int where
  toGlInt GL_VENDOR                    = 0x1F00
  toGlInt GL_RENDERER                  = 0x1F01
  toGlInt GL_VERSION                   = 0x1F02
  toGlInt GL_EXTENSIONS                = 0x1F03
  toGlInt GL_SHADING_LANGUAGE_VERSION  = 0x8B8C

public
glGetString : GlInfo -> IO String
glGetString info = foreign FFI_C "idr_glGetString" (Int -> IO String) (toGlInt info)

public
glGetInfo : IO String
glGetInfo = do vendor   <- glGetString GL_VENDOR
               renderer <- glGetString GL_RENDERER
               version  <- glGetString GL_VERSION
               return $ foldl1 (++) (the (List String) ["Vendor = ", vendor, "\nRenderer = ", renderer, "\nVersion = ", version, "\n"])

public             
data GlCapability
  = GL_BLEND
  | GL_CLIP_DISTANCE_0
  | GL_CLIP_DISTANCE_1
  | GL_CLIP_DISTANCE_2
  | GL_CLIP_DISTANCE_3
  | GL_CLIP_DISTANCE_4
  | GL_CLIP_DISTANCE_5
  | GL_CLIP_DISTANCE_6
  | GL_CLIP_DISTANCE_7
  | GL_COLOR_LOGIC_OP
  | GL_CULL_FACE
  | GL_DEPTH_CLAMP
  | GL_DEPTH_TEST
  | GL_DITHER
  | GL_FRAMEBUFFER_SRGB
  | GL_LINE_SMOOTH
  | GL_MULTISAMPLE
  | GL_POLYGON_OFFSET_FILL
  | GL_POLYGON_OFFSET_LINE
  | GL_POLYGON_OFFSET_POINT
  | GL_POLYGON_SMOOTH
  | GL_PRIMITIVE_RESTART
  | GL_RASTERIZER_DISCARD
  | GL_SAMPLE_ALPHA_TO_COVERAGE
  | GL_SAMPLE_ALPHA_TO_ONE
  | GL_SAMPLE_COVERAGE
  | GL_SAMPLE_SHADING
  | GL_SAMPLE_MASK
  | GL_SCISSOR_TEST
  | GL_STENCIL_TEST
  | GL_TEXTURE_CUBE_MAP_SEAMLESS
  | GL_PROGRAM_POINT_SIZE

instance GlEnum GlCapability Int where
  toGlInt GL_BLEND           = 0x0BE2
  toGlInt GL_CLIP_DISTANCE_0 = 0x3000
  toGlInt GL_CLIP_DISTANCE_1 = 0x3001
  toGlInt GL_CLIP_DISTANCE_2 = 0x3002
  toGlInt GL_CLIP_DISTANCE_3 = 0x3003
  toGlInt GL_CLIP_DISTANCE_4 = 0x3004
  toGlInt GL_CLIP_DISTANCE_5 = 0x3005
  toGlInt GL_CLIP_DISTANCE_6 = 0x3006
  toGlInt GL_CLIP_DISTANCE_7 = 0x3007
  toGlInt GL_COLOR_LOGIC_OP  = 0x0BF2
  toGlInt GL_CULL_FACE       = 0x0B44
  toGlInt GL_DEPTH_CLAMP     = 0x864F
  toGlInt GL_DEPTH_TEST      = 0x0B71
  toGlInt GL_DITHER          = 0x0BD0
  toGlInt GL_FRAMEBUFFER_SRGB = 0x8DB9
  toGlInt GL_LINE_SMOOTH      = 0x0B20
  toGlInt GL_MULTISAMPLE      = 0x809D
  toGlInt GL_POLYGON_OFFSET_FILL  = 0x8037
  toGlInt GL_POLYGON_OFFSET_LINE  = 0x2A02
  toGlInt GL_POLYGON_OFFSET_POINT = 0x2A01
  toGlInt GL_POLYGON_SMOOTH       = 0x0B41
  toGlInt GL_PRIMITIVE_RESTART    = 0x8F9D
  toGlInt GL_RASTERIZER_DISCARD       = 0x8C89
  toGlInt GL_SAMPLE_ALPHA_TO_COVERAGE = 0x809E
  toGlInt GL_SAMPLE_ALPHA_TO_ONE      = 0x809F
  toGlInt GL_SAMPLE_COVERAGE          = 0x80A0
  toGlInt GL_SAMPLE_SHADING           = 0x8C36
  toGlInt GL_SAMPLE_MASK               = 0x8E51
  toGlInt GL_SCISSOR_TEST              = 0x0C11
  toGlInt GL_STENCIL_TEST              = 0x0B90
  toGlInt GL_TEXTURE_CUBE_MAP_SEAMLESS = 0x884F
  toGlInt GL_PROGRAM_POINT_SIZE        = 0x8642

public
glEnable : GlCapability -> IO ()
glEnable capability = foreign FFI_C "glEnable" (Int -> IO ()) (toGlInt capability)

public
data GlDepthFunc 
  = GL_NEVER
  | GL_LESS
  | GL_EQUAL
  | GL_LEQUAL
  | GL_GREATER
  | GL_NOTEQUAL
  | GL_GEQUAL
  | GL_ALWAYS
  
instance GlEnum GlDepthFunc Int where
  toGlInt GL_NEVER     = 0x0200
  toGlInt GL_LESS      = 0x0201
  toGlInt GL_EQUAL     = 0x0202
  toGlInt GL_LEQUAL    = 0x0203
  toGlInt GL_GREATER   = 0x0204
  toGlInt GL_NOTEQUAL  = 0x0205
  toGlInt GL_GEQUAL    = 0x0206
  toGlInt GL_ALWAYS    = 0x0207

public
glDepthFunc : GlDepthFunc -> IO ()
glDepthFunc func = foreign FFI_C "glDepthFunc" (Int -> IO ()) (toGlInt func)

public 
glClearColor : (r: Double) -> (g: Double) -> (b: Double) -> (a: Double) -> IO ()
glClearColor = foreign FFI_C "glClearColor" (Double -> Double -> Double -> Double -> IO ())


public 
glClear : GLbitfields -> IO ()
glClear mask = foreign FFI_C "glClear" (Int -> IO()) (toGlInt mask)

public 
glClearAll : List GLbitfields -> IO ()
glClearAll []        = pure ()
glClearAll (m :: ms) = do glClear m
                          glClearAll ms

public
data GlError
  = GL_NO_ERROR
  | GL_INVALID_ENUM
  | GL_INVALID_VALUE
  | GL_INVALID_OPERATION
  | GL_OUT_OF_MEMORY
  | GL_STACK_UNDERFLOW
  | GL_STACK_OVERFLOW
  | GL_INVALID_FRAMEBUFFER_OPERATION

instance GlEnum GlError Int where
  toGlInt GL_NO_ERROR                        = 0 
  toGlInt GL_INVALID_ENUM                    = 0x0500
  toGlInt GL_INVALID_VALUE                   = 0x0501
  toGlInt GL_INVALID_OPERATION               = 0x0502
  toGlInt GL_OUT_OF_MEMORY                   = 0x0503
  toGlInt GL_STACK_UNDERFLOW                 = 0x0504
  toGlInt GL_STACK_OVERFLOW                  = 0x0505
  toGlInt GL_INVALID_FRAMEBUFFER_OPERATION   = 0x0506

instance GlConstant GlError Int where
  fromGlInt 0      = GL_NO_ERROR
  fromGlInt 0x0500 = GL_INVALID_ENUM
  fromGlInt 0x0501 = GL_INVALID_VALUE
  fromGlInt 0x0502 = GL_INVALID_OPERATION
  fromGlInt 0x0503 = GL_OUT_OF_MEMORY
  fromGlInt 0x0504 = GL_STACK_UNDERFLOW
  fromGlInt 0x0505 = GL_STACK_OVERFLOW
  fromGlInt 0x0506 = GL_INVALID_FRAMEBUFFER_OPERATION

instance Show GlError where
  show GL_NO_ERROR                      = "GL_NO_ERROR "
  show GL_INVALID_ENUM                  = "GL_INVALID_ENUM"
  show GL_INVALID_VALUE                 = "GL_INVALID_VALUE"
  show GL_INVALID_OPERATION             = "GL_INVALID_OPERATION"
  show GL_OUT_OF_MEMORY                 = "GL_OUT_OF_MEMORY"
  show GL_STACK_UNDERFLOW               = "GL_STACK_UNDERFLOW"
  show GL_STACK_OVERFLOW                = "GL_STACK_OVERFLOW"
  show GL_INVALID_FRAMEBUFFER_OPERATION = "GL_INVALID_FRAMEBUFFER_OPERATION"

public
glGetError : IO GlError
glGetError = do err <- foreign FFI_C "glGetError" (IO Int) 
                pure $ fromGlInt err

||| A Vertex Array Object id
abstract
data Vao = MkVao Int

||| generate a vertex array object name
public
glGenVertexArrays : IO Vao
glGenVertexArrays = do id <- foreign FFI_C "idr_glGenVertexArrays" (IO Int) 
                       pure $ MkVao id
                     
public 
glDeleteVertexArray : Vao -> IO ()
glDeleteVertexArray (MkVao id) = foreign FFI_C "idr_glDeleteVertexArrays" (Int -> IO()) id

||| activate the vertex array object
public
glBindVertexArray : Vao -> IO ()
glBindVertexArray (MkVao id) = foreign FFI_C "glBindVertexArray" (Int -> IO ()) id

public
glUnbindVertexArray : IO ()
glUnbindVertexArray = foreign FFI_C "glBindVertexArray" (Int -> IO ()) 0

||| A Vertex Buffer
abstract
data Buffer = MkBuffer Int

||| generate a vertex array object name
public
glGenBuffers : IO Buffer
glGenBuffers = do id <- foreign FFI_C "idr_glGenBuffers" (IO Int) 
                  pure $ MkBuffer id

public
data BufferBindingTarget 
  = GL_ARRAY_BUFFER
  | GL_ELEMENT_ARRAY_BUFFER

instance GlEnum BufferBindingTarget Int where
  toGlInt GL_ARRAY_BUFFER         = 0x8892
  toGlInt GL_ELEMENT_ARRAY_BUFFER = 0x8893

||| activate the vertex buffer
public
glBindBuffer : BufferBindingTarget -> Buffer -> IO ()
glBindBuffer target (MkBuffer id) = foreign FFI_C "glBindBuffer" (Int -> Int -> IO ()) (toGlInt target) id

||| activate the vertex buffer
public
glUnbindBuffer : BufferBindingTarget -> IO ()
glUnbindBuffer target = foreign FFI_C "glBindBuffer" (Int -> Int -> IO ()) (toGlInt target) 0

public
data GlUsage
  = GL_STREAM_DRAW
  | GL_STREAM_READ
  | GL_STREAM_COPY
  | GL_STATIC_DRAW
  | GL_STATIC_READ 
  | GL_STATIC_COPY 
  | GL_DYNAMIC_DRAW 
  | GL_DYNAMIC_READ 
  | GL_DYNAMIC_COPY

instance GlEnum GlUsage Int where
  toGlInt GL_STREAM_DRAW       = 0x88E0
  toGlInt GL_STREAM_READ       = 0x88E1
  toGlInt GL_STREAM_COPY       = 0x88E2
  toGlInt GL_STATIC_DRAW       = 0x88E4
  toGlInt GL_STATIC_READ       = 0x88E5
  toGlInt GL_STATIC_COPY       = 0x88E6
  toGlInt GL_DYNAMIC_DRAW      = 0x88E8
  toGlInt GL_DYNAMIC_READ      = 0x88E9

public 
toSize : Int -> IO Int
toSize i = foreign FFI_C "idr_sizeof_doubles" (Int -> IO Int) i

public
glBufferData : BufferBindingTarget -> List Double -> GlUsage -> IO ()
glBufferData target [] usage = pure $ ()
glBufferData target xs usage = 
  do ptr <- writeBuffer xs
     size <- foreign FFI_C "idr_sizeof_doubles" (Int -> IO Int) (toIntNat (length xs))
     foreign FFI_C "glBufferData" (Int -> Int -> Ptr -> Int -> IO ()) (toGlInt target) size ptr (toGlInt usage)
     free ptr 

     
public
glBufferDatai : BufferBindingTarget -> List Int -> GlUsage -> IO ()
glBufferDatai target [] usage = pure $ ()
glBufferDatai target xs usage = 
  do ptr <- writeIntBuffer xs
     size <- foreign FFI_C "idr_sizeof_ints" (Int -> IO Int) (toIntNat (length xs))
     foreign FFI_C "glBufferData" (Int -> Int -> Ptr -> Int -> IO ()) (toGlInt target) size ptr (toGlInt usage)
     free ptr 
               
public
glDeleteBuffer : Buffer -> IO ()
glDeleteBuffer (MkBuffer id) = foreign FFI_C "idr_glDeleteBuffers" (Int -> IO()) id


||| enables the attribute on for the given VAO
public 
glEnableVertexArrayAttrib : Vao -> Int -> IO ()
glEnableVertexArrayAttrib (MkVao id) index = foreign FFI_C "glEnableVertexArrayAttrib" (Int -> Int -> IO ()) id index

public 
glDisableVertexArrayAttrib : Vao -> Int -> IO ()
glDisableVertexArrayAttrib (MkVao id) index = foreign FFI_C "glDisableVertexArrayAttrib" (Int -> Int -> IO ()) id index

||| enables the attribute on for the currently active VAO
public 
glEnableVertexAttribArray : Int -> IO ()
glEnableVertexAttribArray index = foreign FFI_C "glEnableVertexAttribArray" (Int -> IO ()) index

public 
glDisableVertexAttribArray : Int -> IO ()
glDisableVertexAttribArray index = foreign FFI_C "glDisableVertexAttribArray" (Int -> IO ()) index

public
data GlType 
  = GL_BYTE
  | GL_UNSIGNED_BYTE
  | GL_SHORT
  | GL_UNSIGNED_SHORT
  | GL_INT
  | GL_UNSIGNED_INT
  | GL_FLOAT
  | GL_DOUBLE

instance GlEnum GlType Int where
  toGlInt GL_BYTE            = 0x1400
  toGlInt GL_UNSIGNED_BYTE   = 0x1401
  toGlInt GL_SHORT           = 0x1402
  toGlInt GL_UNSIGNED_SHORT  = 0x1403
  toGlInt GL_INT             = 0x1404
  toGlInt GL_UNSIGNED_INT    = 0x1405
  toGlInt GL_FLOAT           = 0x1406
  toGlInt GL_DOUBLE          = 0x140A
  
public
glVertexAttribPointer : (index: Int) -> (size: Int) -> (ty: GlType) -> (normalized: GlBool) -> (stride: Int) -> (offset: Int) -> IO () -- no offset for now
glVertexAttribPointer idx size ty normalized stride offset = 
  foreign FFI_C "idr_glVertexAttribPointer" (Int -> Int -> Int -> Int -> Int -> Int -> IO ()) idx size (toGlInt ty) (toGlInt normalized) stride offset

-- -------------------------------------------------------------
-- Shaders
-- -------------------------------------------------------------

public
data ShaderType 
  --= GL_COMPUTE_SHADER
  = GL_VERTEX_SHADER        
  | GL_TESS_CONTROL_SHADER    
  | GL_TESS_EVALUATION_SHADER 
  | GL_GEOMETRY_SHADER        
  | GL_FRAGMENT_SHADER      
    
    
instance GlEnum ShaderType Int where 
  --toGlInt GL_COMPUTE_SHADER           = 
  toGlInt GL_VERTEX_SHADER          = 0x8B31
  toGlInt GL_TESS_CONTROL_SHADER    = 0x8E88
  toGlInt GL_TESS_EVALUATION_SHADER = 0x8E87
  toGlInt GL_GEOMETRY_SHADER        = 0x8DD9
  toGlInt GL_FRAGMENT_SHADER        = 0x8B30

abstract
data Shader = MkShader Int
    
public    
glCreateShader : ShaderType -> IO Shader
glCreateShader t = do ptr <- foreign FFI_C "glCreateShader" (Int -> IO Int) (toGlInt t)
                      pure $ MkShader ptr
public    
glDeleteShader : Shader -> IO ()
glDeleteShader (MkShader id) = foreign FFI_C "glDeleteShader" (Int -> IO ()) id
                      
public    
glDeleteShaders : List Shader -> IO ()
glDeleteShaders []        = pure ()
glDeleteShaders (s :: ss) = glDeleteShader s

                      
public    
glShaderSource : Shader -> String -> IO ()
glShaderSource (MkShader id) source = foreign FFI_C "idr_glShaderSource" (Int -> String -> IO ()) id source

public    
glCompileShader : Shader -> IO ()
glCompileShader (MkShader id) = foreign FFI_C "glCompileShader" (Int -> IO ()) id

abstract
data Program = MkProgram Int | NoProgram
  
public
noProgram : Program
noProgram = NoProgram

public    
glCreateProgram : IO Program
glCreateProgram = do id <- foreign FFI_C "glCreateProgram" (IO Int)
                     pure $ MkProgram id

public    
glDeleteProgram : Program -> IO ()
glDeleteProgram (MkProgram id ) = foreign FFI_C "glDeleteProgram" (Int -> IO()) id

public    
glLinkProgram : Program -> IO ()
glLinkProgram (MkProgram id ) = foreign FFI_C "glLinkProgram" (Int -> IO()) id
                     
public    
glAttachShader : Program -> Shader -> IO ()
glAttachShader (MkProgram programId) (MkShader shaderId) = 
  foreign FFI_C "glAttachShader" (Int -> Int -> IO()) programId shaderId                   

public    
glDetachShader : Program -> Shader -> IO ()
glDetachShader (MkProgram programId) (MkShader shaderId) = 
  foreign FFI_C "glDetachShader" (Int -> Int -> IO()) programId shaderId                   

public    
glDetachShaders : Program -> List Shader -> IO ()
glDetachShaders program []      = pure ()
glDetachShaders program (s::ss) = glDetachShader program s


public    
glUseProgram : Program -> IO ()
glUseProgram (MkProgram id ) = foreign FFI_C "glUseProgram" (Int -> IO()) id
glUseProgram NoProgram = foreign FFI_C "glUseProgram" (Int -> IO()) 0

-- ----------------------------------------------------------------- [ Uniforms ]


public 
glGetUniformLocation : Program -> String -> IO Int
glGetUniformLocation (MkProgram id) attr = foreign FFI_C "glGetUniformLocation" (Int -> String -> IO Int) id attr

public
glUniformMatrix4fv : (location: Int) -> TransformationMatrix -> IO ()
glUniformMatrix4fv location mat = 
  do ptr <- writeBuffer $ toList $ T.toGl mat
     foreign FFI_C "idr_glUniformMatrix4fv" (Int -> Ptr -> IO ()) location ptr
     free ptr 

public 
glUniform3fv : (location: Int) -> Vec3 -> IO ()
glUniform3fv location vec = 
  do ptr <- writeFloatBuffer $ toList vec
     foreign FFI_C "idr_glUniform3fv" (Int -> Ptr -> IO ()) location ptr
     free ptr 

public
glUniform1f : (location: Int) -> Double -> IO ()
glUniform1f location value = do foreign FFI_C "idr_glUniform1f" (Int -> Double -> IO ()) location value


{--
public 
getShaderiv : 
GLint status;
glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &status);

Retrieving the compile log

char buffer[512];
glGetShaderInfoLog(vertexShader, 512, NULL, buffer);

--}
-- ----------------------------------------------------------------- [ Drawing ]
    
public
data DrawingMode
  = GL_POINTS
  | GL_LINE_STRIP
  | GL_LINE_LOOP
  | GL_LINES
  | GL_LINE_STRIP_ADJACENCY
  | GL_LINES_ADJACENCY
  | GL_TRIANGLE_STRIP
  | GL_TRIANGLE_FAN
  | GL_TRIANGLES
  | GL_TRIANGLE_STRIP_ADJACENCY
  | GL_TRIANGLES_ADJACENCY
  | GL_PATCHES
    
instance GlEnum DrawingMode Int where
  toGlInt GL_POINTS                   = 0x0000
  toGlInt GL_LINE_STRIP               = 0x0003
  toGlInt GL_LINE_LOOP                = 0x0002
  toGlInt GL_LINES                    = 0x0001
  toGlInt GL_LINE_STRIP_ADJACENCY     = 0x000B
  toGlInt GL_LINES_ADJACENCY          = 0x000A
  toGlInt GL_TRIANGLE_STRIP           = 0x0005
  toGlInt GL_TRIANGLE_FAN             = 0x0006
  toGlInt GL_TRIANGLES                = 0x0004
  toGlInt GL_TRIANGLE_STRIP_ADJACENCY = 0x000D
  toGlInt GL_TRIANGLES_ADJACENCY      = 0x000C
  toGlInt GL_PATCHES                  = 0x000E
  
public
glDrawArrays : DrawingMode -> (first: Int) -> (count: Int) -> IO ()
glDrawArrays mode first count = foreign FFI_C "glDrawArrays" (Int -> Int -> Int -> IO ()) (toGlInt mode) first count

public
glDrawElements : DrawingMode -> (count: Int) -> IO ()
glDrawElements mode count = 
  foreign FFI_C "idr_glDrawElements" (Int -> Int -> IO ()) (toGlInt mode) count

-- ----------------------------------------------------------------- [ Textures ]

abstract
data Texture = MkTexture Int

instance GlId Texture where
  getId (MkTexture id) = id
  
public 
glLoadPNGTexture : String -> IO Texture
glLoadPNGTexture filename = do id <- foreign FFI_C "png_texture_load" (String -> IO Int) filename
                               pure $ MkTexture id

public 
glDeleteTextures : List Texture -> IO ()
glDeleteTextures textures =   
  do ptr <- writeIntBuffer (map getId textures)
     foreign FFI_C "glDeleteTextures" (Int -> Ptr -> IO ()) (toIntNat (length textures)) ptr
     free ptr 


public
data TextureTarget
     = GL_TEXTURE_1D
     | GL_TEXTURE_1D_ARRAY
     | GL_TEXTURE_2D
     | GL_TEXTURE_2D_ARRAY
     | GL_TEXTURE_2D_MULTISAMPLE
     | GL_TEXTURE_2D_MULTISAMPLE_ARRAY
     | GL_TEXTURE_3D
     | GL_TEXTURE_CUBE_MAP
     | GL_TEXTURE_CUBE_MAP_ARRAY
     | GL_TEXTURE_RECTANGLE

instance GlEnum TextureTarget Int where
  toGlInt GL_TEXTURE_1D                    = 0x0DE0
  toGlInt GL_TEXTURE_1D_ARRAY              = 0x8C18
  toGlInt GL_TEXTURE_2D                    = 0x0DE1
  toGlInt GL_TEXTURE_2D_ARRAY              = 0x8C1A
  toGlInt GL_TEXTURE_2D_MULTISAMPLE        = 0x9100
  toGlInt GL_TEXTURE_2D_MULTISAMPLE_ARRAY  = 0x9102
  toGlInt GL_TEXTURE_3D                    = 0x806F
  toGlInt GL_TEXTURE_CUBE_MAP              = 0x8513
  toGlInt GL_TEXTURE_CUBE_MAP_ARRAY        = 0x9009
  toGlInt GL_TEXTURE_RECTANGLE             = 0x84F5
  
  
public 
glBindTexture : TextureTarget -> Texture -> IO ()
glBindTexture target (MkTexture id) = foreign FFI_C "glBindTexture" (Int -> Int -> IO ()) (toGlInt target) id
  	
public 
glUnbindTexture : TextureTarget -> IO ()
glUnbindTexture target = foreign FFI_C "glBindTexture" (Int -> Int -> IO ()) (toGlInt target) 0

public
data TextureParamName
  = GL_TEXTURE_BASE_LEVEL
  | GL_TEXTURE_COMPARE_FUNC
  | GL_TEXTURE_COMPARE_MODE
  | GL_TEXTURE_LOD_BIAS
  | GL_TEXTURE_MIN_FILTER
  | GL_TEXTURE_MAG_FILTER
  | GL_TEXTURE_MIN_LOD
  | GL_TEXTURE_MAX_LOD
  | GL_TEXTURE_MAX_LEVEL
  | GL_TEXTURE_SWIZZLE_R
  | GL_TEXTURE_SWIZZLE_G
  | GL_TEXTURE_SWIZZLE_B
  | GL_TEXTURE_SWIZZLE_A
  | GL_TEXTURE_WRAP_S
  | GL_TEXTURE_WRAP_T
  | GL_TEXTURE_WRAP_R
  
instance GlEnum TextureParamName Int where
  toGlInt GL_TEXTURE_BASE_LEVEL         = 0x813C
  toGlInt GL_TEXTURE_COMPARE_FUNC       = 0x884D
  toGlInt GL_TEXTURE_COMPARE_MODE       = 0x884C
  toGlInt GL_TEXTURE_LOD_BIAS           = 0x8501
  toGlInt GL_TEXTURE_MIN_FILTER         = 0x2801
  toGlInt GL_TEXTURE_MAG_FILTER         = 0x2800
  toGlInt GL_TEXTURE_MIN_LOD            = 0x813A
  toGlInt GL_TEXTURE_MAX_LOD            = 0x813B
  toGlInt GL_TEXTURE_MAX_LEVEL          = 0x813D
  toGlInt GL_TEXTURE_WRAP_S             = 0x2802
  toGlInt GL_TEXTURE_WRAP_T             = 0x2803
  toGlInt GL_TEXTURE_WRAP_R             = 0x8072

public
data TextureParam 
  = GL_NEAREST                -- filter
  | GL_LINEAR
  | GL_CLAMP_TO_EDGE          -- texture clamping
  | GL_CLAMP_TO_BORDER
  | GL_MIRRORED_REPEAT
  | GL_CLAMP
  | GL_REPEAT

instance GlEnum TextureParam Int where
  -- filtering
  toGlInt GL_NEAREST = 0x2600
  toGlInt GL_LINEAR  = 0x2601
  -- clamping
  toGlInt GL_CLAMP_TO_EDGE         = 0x812F
  toGlInt GL_CLAMP_TO_BORDER       = 0x812D
  toGlInt GL_MIRRORED_REPEAT       = 0x8370
  toGlInt GL_CLAMP                 = 0x2900
  toGlInt GL_REPEAT                = 0x2901

public
glTexParameteri : TextureTarget -> TextureParamName -> TextureParam -> IO ()
glTexParameteri target pname param =
  foreign FFI_C "glTexParameteri" (Int -> Int -> Int -> IO ()) (toGlInt target) (toGlInt pname) (toGlInt param)

 
public 
data TextureUnit
  = GL_TEXTURE0
  | GL_TEXTURE1
  | GL_TEXTURE2
  | GL_TEXTURE3
  | GL_TEXTURE4
  | GL_TEXTURE5
  | GL_TEXTURE6
  | GL_TEXTURE7
  | GL_TEXTURE8
  | GL_TEXTURE9
  | GL_TEXTURE10
  | GL_TEXTURE11
  | GL_TEXTURE12
  -- actually this goes on some more (to 31 on my system), but ist enough for now

instance GlEnum TextureUnit Int where
  toGlInt GL_TEXTURE0  =                     0x84C0
  toGlInt GL_TEXTURE1  =                     0x84C1
  toGlInt GL_TEXTURE2  =                     0x84C2
  toGlInt GL_TEXTURE3  =                     0x84C3
  toGlInt GL_TEXTURE4  =                     0x84C4
  toGlInt GL_TEXTURE5  =                     0x84C5
  toGlInt GL_TEXTURE6  =                     0x84C6
  toGlInt GL_TEXTURE7  =                     0x84C7
  toGlInt GL_TEXTURE8  =                     0x84C8
  toGlInt GL_TEXTURE9  =                     0x84C9
  toGlInt GL_TEXTURE10 =                     0x84CA
  toGlInt GL_TEXTURE11 =                     0x84CB
  toGlInt GL_TEXTURE12 =                     0x84CC
 
   
public
glActiveTexture : TextureUnit -> IO ()
glActiveTexture unit = foreign FFI_C "glActiveTexture" (Int -> IO ()) (toGlInt unit)

-- ----------------------------------------------------------------- [ Helper ]

public 
printShaderLog : Shader -> IO ()
printShaderLog (MkShader id) = foreign FFI_C "printShaderLog" (Int -> IO()) id
