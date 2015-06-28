module Graphics.Rendering.Gl

%include C "GL/glew.h"
%include C "GLFW/glfw3.h"
%include C "gl_idris.h"
%link C "gl_idris.o"

%access private

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

free : Ptr -> IO ()
free ptr = foreign FFI_C "free" (Ptr -> IO ()) ptr
 
-- --------------------------------------------------------------

class GlConstant a b where
  toGlInt   : a -> b
  fromGlInt : b -> a

public 
data GlBool = GL_TRUE | GL_FALSE

instance GlConstant GlBool Int where
  toGlInt GL_TRUE  = 0
  toGlInt GL_FALSE = 1
  fromGlInt 1 = GL_FALSE
  fromGlInt _ = GL_TRUE

public
data GLbitfields
  = GL_DEPTH_BUFFER_BIT
  | GL_ACCUM_BUFFER_BIT
  | GL_STENCIL_BUFFER_BIT
  | GL_COLOR_BUFFER_BIT

instance GlConstant GLbitfields Int where
  toGlInt  GL_DEPTH_BUFFER_BIT     = 0x00000100
  toGlInt  GL_ACCUM_BUFFER_BIT     = 0x00000200
  toGlInt  GL_STENCIL_BUFFER_BIT   = 0x00000400
  toGlInt  GL_COLOR_BUFFER_BIT     = 0x00004000
  fromGlInt 0x00000100             = GL_DEPTH_BUFFER_BIT
  fromGlInt 0x00000200             = GL_ACCUM_BUFFER_BIT
  fromGlInt 0x00000400             = GL_STENCIL_BUFFER_BIT
  fromGlInt 0x00004000             = GL_COLOR_BUFFER_BIT
  
data GlInfo
  = GL_VENDOR
  | GL_RENDERER
  | GL_VERSION
  | GL_EXTENSIONS
  | GL_SHADING_LANGUAGE_VERSION

instance GlConstant GlInfo Int where
  toGlInt GL_VENDOR                    = 0x1F00
  toGlInt GL_RENDERER                  = 0x1F01
  toGlInt GL_VERSION                   = 0x1F02
  toGlInt GL_EXTENSIONS                = 0x1F03
  toGlInt GL_SHADING_LANGUAGE_VERSION  = 0x8B8C
  fromGlInt 0x1F00 =  GL_VENDOR
  fromGlInt 0x1F01 =  GL_RENDERER
  fromGlInt 0x1F02 =  GL_VERSION
  fromGlInt 0x1F03 =  GL_EXTENSIONS
  fromGlInt 0x8B8C =  GL_SHADING_LANGUAGE_VERSION

public
getString : GlInfo -> IO String
getString info = foreign FFI_C "idr_glGetString" (Int -> IO String) (toGlInt info)

public
getInfo : IO String
getInfo = do vendor   <- getString GL_VENDOR
             renderer <- getString GL_RENDERER
             version  <- getString GL_VERSION
             return $ foldl1 (++) ["Vendor = ", vendor, "\nRenderer = ", renderer, "\nVersion = ", version, "\n"]

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

instance GlConstant GlCapability Int where
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
  fromGlInt 0x0BE2 = GL_BLEND
  fromGlInt 0x3000 = GL_CLIP_DISTANCE_0 
  fromGlInt 0x3001 = GL_CLIP_DISTANCE_1
  fromGlInt 0x3002 = GL_CLIP_DISTANCE_2
  fromGlInt 0x3003 = GL_CLIP_DISTANCE_3
  fromGlInt 0x3004 = GL_CLIP_DISTANCE_4
  fromGlInt 0x3005 = GL_CLIP_DISTANCE_5
  fromGlInt 0x3006 = GL_CLIP_DISTANCE_6
  fromGlInt 0x3007 = GL_CLIP_DISTANCE_7
  fromGlInt 0x0BF2 = GL_COLOR_LOGIC_OP
  fromGlInt 0x0B44 = GL_CULL_FACE
  fromGlInt 0x864F = GL_DEPTH_CLAMP
  fromGlInt 0x0B71 = GL_DEPTH_TEST
  fromGlInt 0x0BD0 = GL_DITHER
  fromGlInt 0x8DB9 = GL_FRAMEBUFFER_SRGB
  fromGlInt 0x0B20 = GL_LINE_SMOOTH
  fromGlInt 0x809D = GL_MULTISAMPLE
  fromGlInt 0x8037 = GL_POLYGON_OFFSET_FILL
  fromGlInt 0x2A02 = GL_POLYGON_OFFSET_LINE
  fromGlInt 0x2A01 = GL_POLYGON_OFFSET_POINT
  fromGlInt 0x0B41 = GL_POLYGON_SMOOTH
  fromGlInt 0x8F9D = GL_PRIMITIVE_RESTART
  fromGlInt 0x8C89 = GL_RASTERIZER_DISCARD
  fromGlInt 0x809E = GL_SAMPLE_ALPHA_TO_COVERAGE
  fromGlInt 0x809F = GL_SAMPLE_ALPHA_TO_ONE
  fromGlInt 0x80A0 = GL_SAMPLE_COVERAGE
  fromGlInt 0x8C36 = GL_SAMPLE_SHADING
  fromGlInt 0x8E51 = GL_SAMPLE_MASK
  fromGlInt 0x0C11 = GL_SCISSOR_TEST
  fromGlInt 0x0B90 = GL_STENCIL_TEST
  fromGlInt 0x884F = GL_TEXTURE_CUBE_MAP_SEAMLESS
  fromGlInt 0x8642 = GL_PROGRAM_POINT_SIZE


public
enable : GlCapability -> IO ()
enable capability = foreign FFI_C "glEnable" (Int -> IO ()) (toGlInt capability)

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
  
instance GlConstant GlDepthFunc Int where
  toGlInt GL_NEVER     = 0x0200
  toGlInt GL_LESS      = 0x0201
  toGlInt GL_EQUAL     = 0x0202
  toGlInt GL_LEQUAL    = 0x0203
  toGlInt GL_GREATER   = 0x0204
  toGlInt GL_NOTEQUAL  = 0x0205
  toGlInt GL_GEQUAL    = 0x0206
  toGlInt GL_ALWAYS    = 0x0207
  fromGlInt 0x0200 = GL_NEVER
  fromGlInt 0x0201 = GL_LESS
  fromGlInt 0x0202 = GL_EQUAL
  fromGlInt 0x0203 = GL_LEQUAL
  fromGlInt 0x0204 = GL_GREATER
  fromGlInt 0x0205 = GL_NOTEQUAL
  fromGlInt 0x0206 = GL_GEQUAL
  fromGlInt 0x0207 = GL_ALWAYS


public
depthFunc : GlDepthFunc -> IO ()
depthFunc func = foreign FFI_C "glDepthFunc" (Int -> IO ()) (toGlInt func)

public 
clearColor : (r: Double) -> (g: Double) -> (b: Double) -> (a: Double) -> IO ()
clearColor = foreign FFI_C "glClearColor" (Double -> Double -> Double -> Double -> IO ())


public 
clear : GLbitfields -> IO ()
clear mask = foreign FFI_C "glClear" (Int -> IO()) (toGlInt mask)

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

instance GlConstant GlError Int where
  toGlInt GL_NO_ERROR                        = 0 
  toGlInt GL_INVALID_ENUM                    = 0x0500
  toGlInt GL_INVALID_VALUE                   = 0x0501
  toGlInt GL_INVALID_OPERATION               = 0x0502
  toGlInt GL_OUT_OF_MEMORY                   = 0x0503
  toGlInt GL_STACK_UNDERFLOW                 = 0x0504
  toGlInt GL_STACK_OVERFLOW                  = 0x0505
  toGlInt GL_INVALID_FRAMEBUFFER_OPERATION   = 0x0506
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
getError : IO GlError
getError = do err <- foreign FFI_C "glGetError" (IO Int) 
              pure $ fromGlInt err

||| A Vertex Array Object id
abstract
data Vao = MkVao Int

||| generate a vertex array object name
public
genVertexArrays : IO Vao
genVertexArrays = do id <- foreign FFI_C "idr_glGenVertexArrays" (IO Int) 
                     pure $ MkVao id
                     
public 
deleteVertexArray : Vao -> IO ()
deleteVertexArray (MkVao id) = foreign FFI_C "idr_glDeleteVertexArrays" (Int -> IO()) id

||| activate the vertex array object
public
bindVertexArray : Vao -> IO ()
bindVertexArray (MkVao id) = foreign FFI_C "glBindVertexArray" (Int -> IO ()) id

public
unbindVertexArray : IO ()
unbindVertexArray = foreign FFI_C "glBindVertexArray" (Int -> IO ()) 0

||| A Vertex Buffer
abstract
data Buffer = MkBuffer Int

||| generate a vertex array object name
public
genBuffers : IO Buffer
genBuffers = do id <- foreign FFI_C "idr_glGenBuffers" (IO Int) 
                pure $ MkBuffer id

public
data BufferBindingTarget 
  = GL_ARRAY_BUFFER

instance GlConstant BufferBindingTarget Int where
  toGlInt   GL_ARRAY_BUFFER  = 0x8892
  fromGlInt          0x8892  = GL_ARRAY_BUFFER

||| activate the vertex buffer
public
bindBuffer : BufferBindingTarget -> Buffer -> IO ()
bindBuffer target (MkBuffer id) = foreign FFI_C "glBindBuffer" (Int -> Int -> IO ()) (toGlInt target) id

||| activate the vertex buffer
public
unbindBuffer : BufferBindingTarget -> IO ()
unbindBuffer target = foreign FFI_C "glBindBuffer" (Int -> Int -> IO ()) (toGlInt target) 0

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

instance GlConstant GlUsage Int where
  toGlInt GL_STREAM_DRAW       = 0x88E0
  toGlInt GL_STREAM_READ       = 0x88E1
  toGlInt GL_STREAM_COPY       = 0x88E2
  toGlInt GL_STATIC_DRAW       = 0x88E4
  toGlInt GL_STATIC_READ       = 0x88E5
  toGlInt GL_STATIC_COPY       = 0x88E6
  toGlInt GL_DYNAMIC_DRAW      = 0x88E8
  toGlInt GL_DYNAMIC_READ      = 0x88E9
  fromGlInt 0x88E0             = GL_STREAM_DRAW                                 
  fromGlInt 0x88E1             = GL_STREAM_READ                                 
  fromGlInt 0x88E2             = GL_STREAM_COPY                                 
  fromGlInt 0x88E4             = GL_STATIC_DRAW                                 
  fromGlInt 0x88E5             = GL_STATIC_READ                                 
  fromGlInt 0x88E6             = GL_STATIC_COPY                                 
  fromGlInt 0x88E8             = GL_DYNAMIC_DRAW                                
  fromGlInt 0x88E9             = GL_DYNAMIC_READ                                


public 
toSize : Int -> IO Int
toSize i = foreign FFI_C "idr_sizeof_doubles" (Int -> IO Int) i

public
bufferData : BufferBindingTarget -> List Double -> GlUsage -> IO ()
bufferData target [] usage = pure $ ()
bufferData target xs usage = 
  do ptr <- writeBuffer xs
     size <- foreign FFI_C "idr_sizeof_doubles" (Int -> IO Int) (toIntNat (length xs))
     foreign FFI_C "glBufferData" (Int -> Int -> Ptr -> Int -> IO ()) (toGlInt target) size ptr (toGlInt usage)
     free ptr 
     
public
deleteBuffer : Buffer -> IO ()
deleteBuffer (MkBuffer id) = foreign FFI_C "idr_glDeleteBuffers" (Int -> IO()) id


||| enables the attribute on for the given VAO
public 
enableVertexArrayAttrib : Vao -> Int -> IO ()
enableVertexArrayAttrib (MkVao id) index = foreign FFI_C "glEnableVertexArrayAttrib" (Int -> Int -> IO ()) id index

public 
disableVertexArrayAttrib : Vao -> Int -> IO ()
disableVertexArrayAttrib (MkVao id) index = foreign FFI_C "glDisableVertexArrayAttrib" (Int -> Int -> IO ()) id index

||| enables the attribute on for the currently active VAO
public 
enableVertexAttribArray : Int -> IO ()
enableVertexAttribArray index = foreign FFI_C "glEnableVertexAttribArray" (Int -> IO ()) index

public 
disableVertexAttribArray : Int -> IO ()
disableVertexAttribArray index = foreign FFI_C "glDisableVertexAttribArray" (Int -> IO ()) index

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

instance GlConstant GlType Int where
  toGlInt GL_BYTE            = 0x1400
  toGlInt GL_UNSIGNED_BYTE   = 0x1401
  toGlInt GL_SHORT           = 0x1402
  toGlInt GL_UNSIGNED_SHORT  = 0x1403
  toGlInt GL_INT             = 0x1404
  toGlInt GL_UNSIGNED_INT    = 0x1405
  toGlInt GL_FLOAT           = 0x1406
  toGlInt GL_DOUBLE          = 0x140A
  fromGlInt 0x1400           = GL_BYTE
  fromGlInt 0x1401           = GL_UNSIGNED_BYTE
  fromGlInt 0x1402           = GL_SHORT
  fromGlInt 0x1403           = GL_UNSIGNED_SHORT
  fromGlInt 0x1404           = GL_INT
  fromGlInt 0x1405           = GL_UNSIGNED_INT
  fromGlInt 0x1406           = GL_FLOAT
  fromGlInt 0x140A           = GL_DOUBLE
  
public
vertexAttribPointer : (index: Int) -> (size: Int) -> (ty: GlType) -> (normalized: GlBool) -> (stride: Int) -> (offset: Int) -> IO () -- no offset for now
vertexAttribPointer idx size ty normalized stride offset = 
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
    
    
instance GlConstant ShaderType Int where 
  --toGlInt GL_COMPUTE_SHADER           = 
  toGlInt GL_VERTEX_SHADER          = 0x8B31
  toGlInt GL_TESS_CONTROL_SHADER    = 0x8E88
  toGlInt GL_TESS_EVALUATION_SHADER = 0x8E87
  toGlInt GL_GEOMETRY_SHADER        = 0x8DD9
  toGlInt GL_FRAGMENT_SHADER        = 0x8B30
  --fromGlInt GL_COMPUTE_SHADER           = 
  fromGlInt 0x8B31 = GL_VERTEX_SHADER          
  fromGlInt 0x8E88 = GL_TESS_CONTROL_SHADER    
  fromGlInt 0x8E87 = GL_TESS_EVALUATION_SHADER 
  fromGlInt 0x8DD9 = GL_GEOMETRY_SHADER        
  fromGlInt 0x8B30  = GL_FRAGMENT_SHADER        

abstract
data Shader = MkShader Int
    
public    
createShader : ShaderType -> IO Shader
createShader t = do ptr <- foreign FFI_C "glCreateShader" (Int -> IO Int) (toGlInt t)
                    pure $ MkShader ptr
public    
deleteShader : Shader -> IO ()
deleteShader (MkShader id) = foreign FFI_C "glDeleteShader" (Int -> IO ()) id
                      
public    
shaderSource : Shader -> String -> IO ()
shaderSource (MkShader id) source = foreign FFI_C "idr_glShaderSource" (Int -> String -> IO ()) id source

public    
compileShader : Shader -> IO ()
compileShader (MkShader id) = foreign FFI_C "glCompileShader" (Int -> IO ()) id

--abstract
public
data Program = MkProgram Int | NoProgram
  
public    
createProgram : IO Program
createProgram = do id <- foreign FFI_C "glCreateProgram" (IO Int)
                   pure $ MkProgram id

public    
deleteProgram : Program -> IO ()
deleteProgram (MkProgram id ) = foreign FFI_C "glDeleteProgram" (Int -> IO()) id

public    
linkProgram : Program -> IO ()
linkProgram (MkProgram id ) = foreign FFI_C "glLinkProgram" (Int -> IO()) id
                     
public    
attachShader : Program -> Shader -> IO ()
attachShader (MkProgram programId) (MkShader shaderId) = 
  foreign FFI_C "glAttachShader" (Int -> Int -> IO()) programId shaderId                   

public    
detachShader : Program -> Shader -> IO ()
detachShader (MkProgram programId) (MkShader shaderId) = 
  foreign FFI_C "glDetachShader" (Int -> Int -> IO()) programId shaderId                   

public    
useProgram : Program -> IO ()
useProgram (MkProgram id ) = foreign FFI_C "glUseProgram" (Int -> IO()) id
useProgram NoProgram = foreign FFI_C "glUseProgram" (Int -> IO()) 0

{--
public 
getShaderiv : 
GLint status;
glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &status);

Retrieving the compile log

char buffer[512];
glGetShaderInfoLog(vertexShader, 512, NULL, buffer);

--}
-- ------------------------------------------------------------------------
-- drawing
    
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
    
instance GlConstant DrawingMode Int where
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
  fromGlInt 0x0000 = GL_POINTS
  fromGlInt 0x0003 = GL_LINE_STRIP
  fromGlInt 0x0002 = GL_LINE_LOOP
  fromGlInt 0x0001 = GL_LINES
  fromGlInt 0x000B = GL_LINE_STRIP_ADJACENCY
  fromGlInt 0x000A = GL_LINES_ADJACENCY
  fromGlInt 0x0005 = GL_TRIANGLE_STRIP
  fromGlInt 0x0006 = GL_TRIANGLE_FAN
  fromGlInt 0x0004 = GL_TRIANGLES
  fromGlInt 0x000D = GL_TRIANGLE_STRIP_ADJACENCY
  fromGlInt 0x000C = GL_TRIANGLES_ADJACENCY
  fromGlInt 0x000E = GL_PATCHES
  
public
drawArrays : DrawingMode -> (first: Int) -> (count: Int) -> IO ()
drawArrays mode first count = foreign FFI_C "glDrawArrays" (Int -> Int -> Int -> IO ()) (toGlInt mode) first count
