{-- 
     opengl-bindings
     # [NOTICE] This is an automatically generated file.
--}
module Graphics.Rendering.Gl.GL41

import Graphics.Rendering.Gl.Types
import Graphics.Rendering.Gl.Buffers

%include C "gl_idris.h"
%link C "gl_idris.o"


namespace VertexAttribPointerType 
  data VertexAttribPointerType = 
    GL_BYTE                   | 
    GL_DOUBLE                 | 
    GL_FLOAT                  | 
    GL_INT                    | 
    GL_SHORT                  | 
    GL_UNSIGNED_BYTE          | 
    GL_UNSIGNED_INT           | 
    GL_UNSIGNED_SHORT        

  instance GlEnum VertexAttribPointerType where
    toGlInt GL_BYTE                   = 0x1400
    toGlInt GL_DOUBLE                 = 0x140A
    toGlInt GL_FLOAT                  = 0x1406
    toGlInt GL_INT                    = 0x1404
    toGlInt GL_SHORT                  = 0x1402
    toGlInt GL_UNSIGNED_BYTE          = 0x1401
    toGlInt GL_UNSIGNED_INT           = 0x1405
    toGlInt GL_UNSIGNED_SHORT         = 0x1403

namespace AttribMask 
  data AttribMask = 
    GL_COLOR_BUFFER_BIT       | 
    GL_DEPTH_BUFFER_BIT       | 
    GL_STENCIL_BUFFER_BIT    

  instance GlEnum AttribMask where
    toGlInt GL_COLOR_BUFFER_BIT       = 0x00004000
    toGlInt GL_DEPTH_BUFFER_BIT       = 0x00000100
    toGlInt GL_STENCIL_BUFFER_BIT     = 0x00000400

namespace AlphaFunction 
  data AlphaFunction = 
    GL_ALWAYS                 | 
    GL_EQUAL                  | 
    GL_GEQUAL                 | 
    GL_GREATER                | 
    GL_LEQUAL                 | 
    GL_LESS                   | 
    GL_NEVER                  | 
    GL_NOTEQUAL              

  instance GlEnum AlphaFunction where
    toGlInt GL_ALWAYS                 = 0x0207
    toGlInt GL_EQUAL                  = 0x0202
    toGlInt GL_GEQUAL                 = 0x0206
    toGlInt GL_GREATER                = 0x0204
    toGlInt GL_LEQUAL                 = 0x0203
    toGlInt GL_LESS                   = 0x0201
    toGlInt GL_NEVER                  = 0x0200
    toGlInt GL_NOTEQUAL               = 0x0205

namespace BlendingFactorDest 
  data BlendingFactorDest = 
    GL_DST_ALPHA              | 
    GL_ONE                    | 
    GL_ONE_MINUS_DST_ALPHA    | 
    GL_ONE_MINUS_SRC_ALPHA    | 
    GL_ONE_MINUS_SRC_COLOR    | 
    GL_SRC_ALPHA              | 
    GL_SRC_COLOR              | 
    GL_ZERO                  

  instance GlEnum BlendingFactorDest where
    toGlInt GL_DST_ALPHA              = 0x0304
    toGlInt GL_ONE                    = 1
    toGlInt GL_ONE_MINUS_DST_ALPHA    = 0x0305
    toGlInt GL_ONE_MINUS_SRC_ALPHA    = 0x0303
    toGlInt GL_ONE_MINUS_SRC_COLOR    = 0x0301
    toGlInt GL_SRC_ALPHA              = 0x0302
    toGlInt GL_SRC_COLOR              = 0x0300
    toGlInt GL_ZERO                   = 0

namespace BlendingFactorSrc 
  data BlendingFactorSrc = 
    GL_DST_ALPHA              | 
    GL_DST_COLOR              | 
    GL_ONE                    | 
    GL_ONE_MINUS_DST_ALPHA    | 
    GL_ONE_MINUS_DST_COLOR    | 
    GL_ONE_MINUS_SRC_ALPHA    | 
    GL_SRC_ALPHA              | 
    GL_SRC_ALPHA_SATURATE     | 
    GL_ZERO                  

  instance GlEnum BlendingFactorSrc where
    toGlInt GL_DST_ALPHA              = 0x0304
    toGlInt GL_DST_COLOR              = 0x0306
    toGlInt GL_ONE                    = 1
    toGlInt GL_ONE_MINUS_DST_ALPHA    = 0x0305
    toGlInt GL_ONE_MINUS_DST_COLOR    = 0x0307
    toGlInt GL_ONE_MINUS_SRC_ALPHA    = 0x0303
    toGlInt GL_SRC_ALPHA              = 0x0302
    toGlInt GL_SRC_ALPHA_SATURATE     = 0x0308
    toGlInt GL_ZERO                   = 0

namespace Boolean 
  data Boolean = 
    GL_FALSE                  | 
    GL_TRUE                  

  instance GlEnum Boolean where
    toGlInt GL_FALSE                  = 0
    toGlInt GL_TRUE                   = 1

namespace ClearBufferMask 
  data ClearBufferMask = 
    GL_COLOR_BUFFER_BIT       | 
    GL_DEPTH_BUFFER_BIT       | 
    GL_STENCIL_BUFFER_BIT    

  instance GlEnum ClearBufferMask where
    toGlInt GL_COLOR_BUFFER_BIT       = 0x00004000
    toGlInt GL_DEPTH_BUFFER_BIT       = 0x00000100
    toGlInt GL_STENCIL_BUFFER_BIT     = 0x00000400

namespace ClipPlaneName 
  data ClipPlaneName = 
    GL_CLIP_DISTANCE0         | 
    GL_CLIP_DISTANCE1         | 
    GL_CLIP_DISTANCE2         | 
    GL_CLIP_DISTANCE3         | 
    GL_CLIP_DISTANCE4         | 
    GL_CLIP_DISTANCE5         | 
    GL_CLIP_DISTANCE6         | 
    GL_CLIP_DISTANCE7        

  instance GlEnum ClipPlaneName where
    toGlInt GL_CLIP_DISTANCE0         = 0x3000
    toGlInt GL_CLIP_DISTANCE1         = 0x3001
    toGlInt GL_CLIP_DISTANCE2         = 0x3002
    toGlInt GL_CLIP_DISTANCE3         = 0x3003
    toGlInt GL_CLIP_DISTANCE4         = 0x3004
    toGlInt GL_CLIP_DISTANCE5         = 0x3005
    toGlInt GL_CLIP_DISTANCE6         = 0x3006
    toGlInt GL_CLIP_DISTANCE7         = 0x3007

namespace ColorMaterialFace 
  data ColorMaterialFace = 
    GL_BACK                   | 
    GL_FRONT                  | 
    GL_FRONT_AND_BACK        

  instance GlEnum ColorMaterialFace where
    toGlInt GL_BACK                   = 0x0405
    toGlInt GL_FRONT                  = 0x0404
    toGlInt GL_FRONT_AND_BACK         = 0x0408

namespace ColorPointerType 
  data ColorPointerType = 
    GL_BYTE                   | 
    GL_DOUBLE                 | 
    GL_FLOAT                  | 
    GL_INT                    | 
    GL_SHORT                  | 
    GL_UNSIGNED_BYTE          | 
    GL_UNSIGNED_INT           | 
    GL_UNSIGNED_SHORT        

  instance GlEnum ColorPointerType where
    toGlInt GL_BYTE                   = 0x1400
    toGlInt GL_DOUBLE                 = 0x140A
    toGlInt GL_FLOAT                  = 0x1406
    toGlInt GL_INT                    = 0x1404
    toGlInt GL_SHORT                  = 0x1402
    toGlInt GL_UNSIGNED_BYTE          = 0x1401
    toGlInt GL_UNSIGNED_INT           = 0x1405
    toGlInt GL_UNSIGNED_SHORT         = 0x1403

namespace ContextFlagMask 
  data ContextFlagMask = 
    GL_CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT

  instance GlEnum ContextFlagMask where
    toGlInt GL_CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT = 0x00000001

namespace ContextProfileMask 
  data ContextProfileMask = 
    GL_CONTEXT_COMPATIBILITY_PROFILE_BIT | 
    GL_CONTEXT_CORE_PROFILE_BIT

  instance GlEnum ContextProfileMask where
    toGlInt GL_CONTEXT_COMPATIBILITY_PROFILE_BIT = 0x00000002
    toGlInt GL_CONTEXT_CORE_PROFILE_BIT = 0x00000001

namespace CullFaceMode 
  data CullFaceMode = 
    GL_BACK                   | 
    GL_FRONT                  | 
    GL_FRONT_AND_BACK        

  instance GlEnum CullFaceMode where
    toGlInt GL_BACK                   = 0x0405
    toGlInt GL_FRONT                  = 0x0404
    toGlInt GL_FRONT_AND_BACK         = 0x0408

namespace DepthFunction 
  data DepthFunction = 
    GL_ALWAYS                 | 
    GL_EQUAL                  | 
    GL_GEQUAL                 | 
    GL_GREATER                | 
    GL_LEQUAL                 | 
    GL_LESS                   | 
    GL_NEVER                  | 
    GL_NOTEQUAL              

  instance GlEnum DepthFunction where
    toGlInt GL_ALWAYS                 = 0x0207
    toGlInt GL_EQUAL                  = 0x0202
    toGlInt GL_GEQUAL                 = 0x0206
    toGlInt GL_GREATER                = 0x0204
    toGlInt GL_LEQUAL                 = 0x0203
    toGlInt GL_LESS                   = 0x0201
    toGlInt GL_NEVER                  = 0x0200
    toGlInt GL_NOTEQUAL               = 0x0205

namespace DrawBufferMode 
  data DrawBufferMode = 
    GL_BACK                   | 
    GL_BACK_LEFT              | 
    GL_BACK_RIGHT             | 
    GL_FRONT                  | 
    GL_FRONT_AND_BACK         | 
    GL_FRONT_LEFT             | 
    GL_FRONT_RIGHT            | 
    GL_LEFT                   | 
    GL_NONE                   | 
    GL_RIGHT                 

  instance GlEnum DrawBufferMode where
    toGlInt GL_BACK                   = 0x0405
    toGlInt GL_BACK_LEFT              = 0x0402
    toGlInt GL_BACK_RIGHT             = 0x0403
    toGlInt GL_FRONT                  = 0x0404
    toGlInt GL_FRONT_AND_BACK         = 0x0408
    toGlInt GL_FRONT_LEFT             = 0x0400
    toGlInt GL_FRONT_RIGHT            = 0x0401
    toGlInt GL_LEFT                   = 0x0406
    toGlInt GL_NONE                   = 0
    toGlInt GL_RIGHT                  = 0x0407

namespace DrawElementsType 
  data DrawElementsType = 
    GL_UNSIGNED_BYTE          | 
    GL_UNSIGNED_SHORT         | 
    GL_UNSIGNED_INT          

  instance GlEnum DrawElementsType where
    toGlInt GL_UNSIGNED_BYTE          = 0x1401
    toGlInt GL_UNSIGNED_SHORT         = 0x1403
    toGlInt GL_UNSIGNED_INT           = 0x1405

namespace EnableCap 
  data EnableCap = 
    GL_BLEND                  | 
    GL_COLOR_LOGIC_OP         | 
    GL_CULL_FACE              | 
    GL_DEPTH_TEST             | 
    GL_DITHER                 | 
    GL_LINE_SMOOTH            | 
    GL_POLYGON_OFFSET_FILL    | 
    GL_POLYGON_OFFSET_LINE    | 
    GL_POLYGON_OFFSET_POINT   | 
    GL_POLYGON_SMOOTH         | 
    GL_SCISSOR_TEST           | 
    GL_STENCIL_TEST           | 
    GL_TEXTURE_1D             | 
    GL_TEXTURE_2D            

  instance GlEnum EnableCap where
    toGlInt GL_BLEND                  = 0x0BE2
    toGlInt GL_COLOR_LOGIC_OP         = 0x0BF2
    toGlInt GL_CULL_FACE              = 0x0B44
    toGlInt GL_DEPTH_TEST             = 0x0B71
    toGlInt GL_DITHER                 = 0x0BD0
    toGlInt GL_LINE_SMOOTH            = 0x0B20
    toGlInt GL_POLYGON_OFFSET_FILL    = 0x8037
    toGlInt GL_POLYGON_OFFSET_LINE    = 0x2A02
    toGlInt GL_POLYGON_OFFSET_POINT   = 0x2A01
    toGlInt GL_POLYGON_SMOOTH         = 0x0B41
    toGlInt GL_SCISSOR_TEST           = 0x0C11
    toGlInt GL_STENCIL_TEST           = 0x0B90
    toGlInt GL_TEXTURE_1D             = 0x0DE0
    toGlInt GL_TEXTURE_2D             = 0x0DE1

namespace ErrorCode 
  data ErrorCode = 
    GL_INVALID_ENUM           | 
    GL_INVALID_FRAMEBUFFER_OPERATION | 
    GL_INVALID_OPERATION      | 
    GL_INVALID_VALUE          | 
    GL_NO_ERROR               | 
    GL_OUT_OF_MEMORY         

  instance GlEnum ErrorCode where
    toGlInt GL_INVALID_ENUM           = 0x0500
    toGlInt GL_INVALID_FRAMEBUFFER_OPERATION = 0x0506
    toGlInt GL_INVALID_OPERATION      = 0x0502
    toGlInt GL_INVALID_VALUE          = 0x0501
    toGlInt GL_NO_ERROR               = 0
    toGlInt GL_OUT_OF_MEMORY          = 0x0505

namespace FogCoordinatePointerType 
  data FogCoordinatePointerType = 
    GL_FLOAT                  | 
    GL_DOUBLE                

  instance GlEnum FogCoordinatePointerType where
    toGlInt GL_FLOAT                  = 0x1406
    toGlInt GL_DOUBLE                 = 0x140A

namespace FogMode 
  data FogMode = 
    GL_LINEAR                

  instance GlEnum FogMode where
    toGlInt GL_LINEAR                 = 0x2601

namespace FogPointerTypeEXT 
  data FogPointerTypeEXT = 
    GL_FLOAT                  | 
    GL_DOUBLE                

  instance GlEnum FogPointerTypeEXT where
    toGlInt GL_FLOAT                  = 0x1406
    toGlInt GL_DOUBLE                 = 0x140A

namespace FogPointerTypeIBM 
  data FogPointerTypeIBM = 
    GL_FLOAT                  | 
    GL_DOUBLE                

  instance GlEnum FogPointerTypeIBM where
    toGlInt GL_FLOAT                  = 0x1406
    toGlInt GL_DOUBLE                 = 0x140A

namespace FrontFaceDirection 
  data FrontFaceDirection = 
    GL_CCW                    | 
    GL_CW                    

  instance GlEnum FrontFaceDirection where
    toGlInt GL_CCW                    = 0x0901
    toGlInt GL_CW                     = 0x0900

namespace GetPName 
  data GetPName = 
    GL_ALIASED_LINE_WIDTH_RANGE | 
    GL_BLEND                  | 
    GL_BLEND_DST              | 
    GL_BLEND_SRC              | 
    GL_COLOR_CLEAR_VALUE      | 
    GL_COLOR_LOGIC_OP         | 
    GL_COLOR_WRITEMASK        | 
    GL_CULL_FACE              | 
    GL_CULL_FACE_MODE         | 
    GL_DEPTH_CLEAR_VALUE      | 
    GL_DEPTH_FUNC             | 
    GL_DEPTH_RANGE            | 
    GL_DEPTH_TEST             | 
    GL_DEPTH_WRITEMASK        | 
    GL_DITHER                 | 
    GL_DOUBLEBUFFER           | 
    GL_DRAW_BUFFER            | 
    GL_FRONT_FACE             | 
    GL_LINE_SMOOTH            | 
    GL_LINE_SMOOTH_HINT       | 
    GL_LINE_WIDTH             | 
    GL_LINE_WIDTH_GRANULARITY | 
    GL_LINE_WIDTH_RANGE       | 
    GL_LOGIC_OP_MODE          | 
    GL_MAX_CLIP_DISTANCES     | 
    GL_MAX_TEXTURE_SIZE       | 
    GL_MAX_VIEWPORT_DIMS      | 
    GL_PACK_ALIGNMENT         | 
    GL_PACK_LSB_FIRST         | 
    GL_PACK_ROW_LENGTH        | 
    GL_PACK_SKIP_PIXELS       | 
    GL_PACK_SKIP_ROWS         | 
    GL_PACK_SWAP_BYTES        | 
    GL_POINT_SIZE             | 
    GL_POINT_SIZE_GRANULARITY | 
    GL_POINT_SIZE_RANGE       | 
    GL_POLYGON_MODE           | 
    GL_POLYGON_OFFSET_FACTOR  | 
    GL_POLYGON_OFFSET_FILL    | 
    GL_POLYGON_OFFSET_LINE    | 
    GL_POLYGON_OFFSET_POINT   | 
    GL_POLYGON_OFFSET_UNITS   | 
    GL_POLYGON_SMOOTH         | 
    GL_POLYGON_SMOOTH_HINT    | 
    GL_READ_BUFFER            | 
    GL_SCISSOR_BOX            | 
    GL_SCISSOR_TEST           | 
    GL_SMOOTH_LINE_WIDTH_GRANULARITY | 
    GL_SMOOTH_LINE_WIDTH_RANGE | 
    GL_SMOOTH_POINT_SIZE_GRANULARITY | 
    GL_SMOOTH_POINT_SIZE_RANGE | 
    GL_STENCIL_CLEAR_VALUE    | 
    GL_STENCIL_FAIL           | 
    GL_STENCIL_FUNC           | 
    GL_STENCIL_PASS_DEPTH_FAIL | 
    GL_STENCIL_PASS_DEPTH_PASS | 
    GL_STENCIL_REF            | 
    GL_STENCIL_TEST           | 
    GL_STENCIL_VALUE_MASK     | 
    GL_STENCIL_WRITEMASK      | 
    GL_STEREO                 | 
    GL_SUBPIXEL_BITS          | 
    GL_TEXTURE_1D             | 
    GL_TEXTURE_2D             | 
    GL_TEXTURE_BINDING_1D     | 
    GL_TEXTURE_BINDING_2D     | 
    GL_TEXTURE_BINDING_3D     | 
    GL_UNPACK_ALIGNMENT       | 
    GL_UNPACK_LSB_FIRST       | 
    GL_UNPACK_ROW_LENGTH      | 
    GL_UNPACK_SKIP_PIXELS     | 
    GL_UNPACK_SKIP_ROWS       | 
    GL_UNPACK_SWAP_BYTES      | 
    GL_VIEWPORT              

  instance GlEnum GetPName where
    toGlInt GL_ALIASED_LINE_WIDTH_RANGE = 0x846E
    toGlInt GL_BLEND                  = 0x0BE2
    toGlInt GL_BLEND_DST              = 0x0BE0
    toGlInt GL_BLEND_SRC              = 0x0BE1
    toGlInt GL_COLOR_CLEAR_VALUE      = 0x0C22
    toGlInt GL_COLOR_LOGIC_OP         = 0x0BF2
    toGlInt GL_COLOR_WRITEMASK        = 0x0C23
    toGlInt GL_CULL_FACE              = 0x0B44
    toGlInt GL_CULL_FACE_MODE         = 0x0B45
    toGlInt GL_DEPTH_CLEAR_VALUE      = 0x0B73
    toGlInt GL_DEPTH_FUNC             = 0x0B74
    toGlInt GL_DEPTH_RANGE            = 0x0B70
    toGlInt GL_DEPTH_TEST             = 0x0B71
    toGlInt GL_DEPTH_WRITEMASK        = 0x0B72
    toGlInt GL_DITHER                 = 0x0BD0
    toGlInt GL_DOUBLEBUFFER           = 0x0C32
    toGlInt GL_DRAW_BUFFER            = 0x0C01
    toGlInt GL_FRONT_FACE             = 0x0B46
    toGlInt GL_LINE_SMOOTH            = 0x0B20
    toGlInt GL_LINE_SMOOTH_HINT       = 0x0C52
    toGlInt GL_LINE_WIDTH             = 0x0B21
    toGlInt GL_LINE_WIDTH_GRANULARITY = 0x0B23
    toGlInt GL_LINE_WIDTH_RANGE       = 0x0B22
    toGlInt GL_LOGIC_OP_MODE          = 0x0BF0
    toGlInt GL_MAX_CLIP_DISTANCES     = 0x0D32
    toGlInt GL_MAX_TEXTURE_SIZE       = 0x0D33
    toGlInt GL_MAX_VIEWPORT_DIMS      = 0x0D3A
    toGlInt GL_PACK_ALIGNMENT         = 0x0D05
    toGlInt GL_PACK_LSB_FIRST         = 0x0D01
    toGlInt GL_PACK_ROW_LENGTH        = 0x0D02
    toGlInt GL_PACK_SKIP_PIXELS       = 0x0D04
    toGlInt GL_PACK_SKIP_ROWS         = 0x0D03
    toGlInt GL_PACK_SWAP_BYTES        = 0x0D00
    toGlInt GL_POINT_SIZE             = 0x0B11
    toGlInt GL_POINT_SIZE_GRANULARITY = 0x0B13
    toGlInt GL_POINT_SIZE_RANGE       = 0x0B12
    toGlInt GL_POLYGON_MODE           = 0x0B40
    toGlInt GL_POLYGON_OFFSET_FACTOR  = 0x8038
    toGlInt GL_POLYGON_OFFSET_FILL    = 0x8037
    toGlInt GL_POLYGON_OFFSET_LINE    = 0x2A02
    toGlInt GL_POLYGON_OFFSET_POINT   = 0x2A01
    toGlInt GL_POLYGON_OFFSET_UNITS   = 0x2A00
    toGlInt GL_POLYGON_SMOOTH         = 0x0B41
    toGlInt GL_POLYGON_SMOOTH_HINT    = 0x0C53
    toGlInt GL_READ_BUFFER            = 0x0C02
    toGlInt GL_SCISSOR_BOX            = 0x0C10
    toGlInt GL_SCISSOR_TEST           = 0x0C11
    toGlInt GL_SMOOTH_LINE_WIDTH_GRANULARITY = 0x0B23
    toGlInt GL_SMOOTH_LINE_WIDTH_RANGE = 0x0B22
    toGlInt GL_SMOOTH_POINT_SIZE_GRANULARITY = 0x0B13
    toGlInt GL_SMOOTH_POINT_SIZE_RANGE = 0x0B12
    toGlInt GL_STENCIL_CLEAR_VALUE    = 0x0B91
    toGlInt GL_STENCIL_FAIL           = 0x0B94
    toGlInt GL_STENCIL_FUNC           = 0x0B92
    toGlInt GL_STENCIL_PASS_DEPTH_FAIL = 0x0B95
    toGlInt GL_STENCIL_PASS_DEPTH_PASS = 0x0B96
    toGlInt GL_STENCIL_REF            = 0x0B97
    toGlInt GL_STENCIL_TEST           = 0x0B90
    toGlInt GL_STENCIL_VALUE_MASK     = 0x0B93
    toGlInt GL_STENCIL_WRITEMASK      = 0x0B98
    toGlInt GL_STEREO                 = 0x0C33
    toGlInt GL_SUBPIXEL_BITS          = 0x0D50
    toGlInt GL_TEXTURE_1D             = 0x0DE0
    toGlInt GL_TEXTURE_2D             = 0x0DE1
    toGlInt GL_TEXTURE_BINDING_1D     = 0x8068
    toGlInt GL_TEXTURE_BINDING_2D     = 0x8069
    toGlInt GL_TEXTURE_BINDING_3D     = 0x806A
    toGlInt GL_UNPACK_ALIGNMENT       = 0x0CF5
    toGlInt GL_UNPACK_LSB_FIRST       = 0x0CF1
    toGlInt GL_UNPACK_ROW_LENGTH      = 0x0CF2
    toGlInt GL_UNPACK_SKIP_PIXELS     = 0x0CF4
    toGlInt GL_UNPACK_SKIP_ROWS       = 0x0CF3
    toGlInt GL_UNPACK_SWAP_BYTES      = 0x0CF0
    toGlInt GL_VIEWPORT               = 0x0BA2

namespace GetTextureParameter 
  data GetTextureParameter = 
    GL_TEXTURE_ALPHA_SIZE     | 
    GL_TEXTURE_BLUE_SIZE      | 
    GL_TEXTURE_BORDER_COLOR   | 
    GL_TEXTURE_GREEN_SIZE     | 
    GL_TEXTURE_HEIGHT         | 
    GL_TEXTURE_INTERNAL_FORMAT | 
    GL_TEXTURE_MAG_FILTER     | 
    GL_TEXTURE_MIN_FILTER     | 
    GL_TEXTURE_RED_SIZE       | 
    GL_TEXTURE_WIDTH          | 
    GL_TEXTURE_WRAP_S         | 
    GL_TEXTURE_WRAP_T        

  instance GlEnum GetTextureParameter where
    toGlInt GL_TEXTURE_ALPHA_SIZE     = 0x805F
    toGlInt GL_TEXTURE_BLUE_SIZE      = 0x805E
    toGlInt GL_TEXTURE_BORDER_COLOR   = 0x1004
    toGlInt GL_TEXTURE_GREEN_SIZE     = 0x805D
    toGlInt GL_TEXTURE_HEIGHT         = 0x1001
    toGlInt GL_TEXTURE_INTERNAL_FORMAT = 0x1003
    toGlInt GL_TEXTURE_MAG_FILTER     = 0x2800
    toGlInt GL_TEXTURE_MIN_FILTER     = 0x2801
    toGlInt GL_TEXTURE_RED_SIZE       = 0x805C
    toGlInt GL_TEXTURE_WIDTH          = 0x1000
    toGlInt GL_TEXTURE_WRAP_S         = 0x2802
    toGlInt GL_TEXTURE_WRAP_T         = 0x2803

namespace HintMode 
  data HintMode = 
    GL_DONT_CARE              | 
    GL_FASTEST                | 
    GL_NICEST                

  instance GlEnum HintMode where
    toGlInt GL_DONT_CARE              = 0x1100
    toGlInt GL_FASTEST                = 0x1101
    toGlInt GL_NICEST                 = 0x1102

namespace HintTarget 
  data HintTarget = 
    GL_FRAGMENT_SHADER_DERIVATIVE_HINT | 
    GL_LINE_SMOOTH_HINT       | 
    GL_POLYGON_SMOOTH_HINT    | 
    GL_PROGRAM_BINARY_RETRIEVABLE_HINT | 
    GL_TEXTURE_COMPRESSION_HINT

  instance GlEnum HintTarget where
    toGlInt GL_FRAGMENT_SHADER_DERIVATIVE_HINT = 0x8B8B
    toGlInt GL_LINE_SMOOTH_HINT       = 0x0C52
    toGlInt GL_POLYGON_SMOOTH_HINT    = 0x0C53
    toGlInt GL_PROGRAM_BINARY_RETRIEVABLE_HINT = 0x8257
    toGlInt GL_TEXTURE_COMPRESSION_HINT = 0x84EF

namespace IndexPointerType 
  data IndexPointerType = 
    GL_DOUBLE                 | 
    GL_FLOAT                  | 
    GL_INT                    | 
    GL_SHORT                 

  instance GlEnum IndexPointerType where
    toGlInt GL_DOUBLE                 = 0x140A
    toGlInt GL_FLOAT                  = 0x1406
    toGlInt GL_INT                    = 0x1404
    toGlInt GL_SHORT                  = 0x1402

namespace LightEnvModeSGIX 
  data LightEnvModeSGIX = 
    GL_REPLACE               

  instance GlEnum LightEnvModeSGIX where
    toGlInt GL_REPLACE                = 0x1E01

namespace ListNameType 
  data ListNameType = 
    GL_BYTE                   | 
    GL_FLOAT                  | 
    GL_INT                    | 
    GL_SHORT                  | 
    GL_UNSIGNED_BYTE          | 
    GL_UNSIGNED_INT           | 
    GL_UNSIGNED_SHORT        

  instance GlEnum ListNameType where
    toGlInt GL_BYTE                   = 0x1400
    toGlInt GL_FLOAT                  = 0x1406
    toGlInt GL_INT                    = 0x1404
    toGlInt GL_SHORT                  = 0x1402
    toGlInt GL_UNSIGNED_BYTE          = 0x1401
    toGlInt GL_UNSIGNED_INT           = 0x1405
    toGlInt GL_UNSIGNED_SHORT         = 0x1403

namespace LogicOp 
  data LogicOp = 
    GL_AND                    | 
    GL_AND_INVERTED           | 
    GL_AND_REVERSE            | 
    GL_CLEAR                  | 
    GL_COPY                   | 
    GL_COPY_INVERTED          | 
    GL_EQUIV                  | 
    GL_INVERT                 | 
    GL_NAND                   | 
    GL_NOOP                   | 
    GL_NOR                    | 
    GL_OR                     | 
    GL_OR_INVERTED            | 
    GL_OR_REVERSE             | 
    GL_SET                    | 
    GL_XOR                   

  instance GlEnum LogicOp where
    toGlInt GL_AND                    = 0x1501
    toGlInt GL_AND_INVERTED           = 0x1504
    toGlInt GL_AND_REVERSE            = 0x1502
    toGlInt GL_CLEAR                  = 0x1500
    toGlInt GL_COPY                   = 0x1503
    toGlInt GL_COPY_INVERTED          = 0x150C
    toGlInt GL_EQUIV                  = 0x1509
    toGlInt GL_INVERT                 = 0x150A
    toGlInt GL_NAND                   = 0x150E
    toGlInt GL_NOOP                   = 0x1505
    toGlInt GL_NOR                    = 0x1508
    toGlInt GL_OR                     = 0x1507
    toGlInt GL_OR_INVERTED            = 0x150D
    toGlInt GL_OR_REVERSE             = 0x150B
    toGlInt GL_SET                    = 0x150F
    toGlInt GL_XOR                    = 0x1506

namespace MapBufferUsageMask 
  data MapBufferUsageMask = 
    GL_MAP_FLUSH_EXPLICIT_BIT | 
    GL_MAP_INVALIDATE_BUFFER_BIT | 
    GL_MAP_INVALIDATE_RANGE_BIT | 
    GL_MAP_READ_BIT           | 
    GL_MAP_UNSYNCHRONIZED_BIT | 
    GL_MAP_WRITE_BIT         

  instance GlEnum MapBufferUsageMask where
    toGlInt GL_MAP_FLUSH_EXPLICIT_BIT = 0x0010
    toGlInt GL_MAP_INVALIDATE_BUFFER_BIT = 0x0008
    toGlInt GL_MAP_INVALIDATE_RANGE_BIT = 0x0004
    toGlInt GL_MAP_READ_BIT           = 0x0001
    toGlInt GL_MAP_UNSYNCHRONIZED_BIT = 0x0020
    toGlInt GL_MAP_WRITE_BIT          = 0x0002

namespace MaterialFace 
  data MaterialFace = 
    GL_BACK                   | 
    GL_FRONT                  | 
    GL_FRONT_AND_BACK        

  instance GlEnum MaterialFace where
    toGlInt GL_BACK                   = 0x0405
    toGlInt GL_FRONT                  = 0x0404
    toGlInt GL_FRONT_AND_BACK         = 0x0408

namespace MatrixMode 
  data MatrixMode = 
    GL_TEXTURE               

  instance GlEnum MatrixMode where
    toGlInt GL_TEXTURE                = 0x1702

namespace MeshMode1 
  data MeshMode1 = 
    GL_LINE                   | 
    GL_POINT                 

  instance GlEnum MeshMode1 where
    toGlInt GL_LINE                   = 0x1B01
    toGlInt GL_POINT                  = 0x1B00

namespace MeshMode2 
  data MeshMode2 = 
    GL_FILL                   | 
    GL_LINE                   | 
    GL_POINT                 

  instance GlEnum MeshMode2 where
    toGlInt GL_FILL                   = 0x1B02
    toGlInt GL_LINE                   = 0x1B01
    toGlInt GL_POINT                  = 0x1B00

namespace NormalPointerType 
  data NormalPointerType = 
    GL_BYTE                   | 
    GL_DOUBLE                 | 
    GL_FLOAT                  | 
    GL_INT                    | 
    GL_SHORT                 

  instance GlEnum NormalPointerType where
    toGlInt GL_BYTE                   = 0x1400
    toGlInt GL_DOUBLE                 = 0x140A
    toGlInt GL_FLOAT                  = 0x1406
    toGlInt GL_INT                    = 0x1404
    toGlInt GL_SHORT                  = 0x1402

namespace PixelCopyType 
  data PixelCopyType = 
    GL_COLOR                  | 
    GL_DEPTH                  | 
    GL_STENCIL               

  instance GlEnum PixelCopyType where
    toGlInt GL_COLOR                  = 0x1800
    toGlInt GL_DEPTH                  = 0x1801
    toGlInt GL_STENCIL                = 0x1802

namespace PixelFormat 
  data PixelFormat = 
    GL_ALPHA                  | 
    GL_BLUE                   | 
    GL_DEPTH_COMPONENT        | 
    GL_GREEN                  | 
    GL_RED                    | 
    GL_RGB                    | 
    GL_RGBA                   | 
    GL_STENCIL_INDEX          | 
    GL_UNSIGNED_INT           | 
    GL_UNSIGNED_SHORT        

  instance GlEnum PixelFormat where
    toGlInt GL_ALPHA                  = 0x1906
    toGlInt GL_BLUE                   = 0x1905
    toGlInt GL_DEPTH_COMPONENT        = 0x1902
    toGlInt GL_GREEN                  = 0x1904
    toGlInt GL_RED                    = 0x1903
    toGlInt GL_RGB                    = 0x1907
    toGlInt GL_RGBA                   = 0x1908
    toGlInt GL_STENCIL_INDEX          = 0x1901
    toGlInt GL_UNSIGNED_INT           = 0x1405
    toGlInt GL_UNSIGNED_SHORT         = 0x1403

namespace InternalFormat 
  data InternalFormat = 
    GL_R3_G3_B2               | 
    GL_RGB10                  | 
    GL_RGB10_A2               | 
    GL_RGB12                  | 
    GL_RGB16                  | 
    GL_RGB4                   | 
    GL_RGB5                   | 
    GL_RGB5_A1                | 
    GL_RGB8                   | 
    GL_RGBA12                 | 
    GL_RGBA16                 | 
    GL_RGBA2                  | 
    GL_RGBA4                  | 
    GL_RGBA8                 

  instance GlEnum InternalFormat where
    toGlInt GL_R3_G3_B2               = 0x2A10
    toGlInt GL_RGB10                  = 0x8052
    toGlInt GL_RGB10_A2               = 0x8059
    toGlInt GL_RGB12                  = 0x8053
    toGlInt GL_RGB16                  = 0x8054
    toGlInt GL_RGB4                   = 0x804F
    toGlInt GL_RGB5                   = 0x8050
    toGlInt GL_RGB5_A1                = 0x8057
    toGlInt GL_RGB8                   = 0x8051
    toGlInt GL_RGBA12                 = 0x805A
    toGlInt GL_RGBA16                 = 0x805B
    toGlInt GL_RGBA2                  = 0x8055
    toGlInt GL_RGBA4                  = 0x8056
    toGlInt GL_RGBA8                  = 0x8058

namespace PixelStoreParameter 
  data PixelStoreParameter = 
    GL_PACK_ALIGNMENT         | 
    GL_PACK_IMAGE_HEIGHT      | 
    GL_PACK_LSB_FIRST         | 
    GL_PACK_ROW_LENGTH        | 
    GL_PACK_SKIP_IMAGES       | 
    GL_PACK_SKIP_PIXELS       | 
    GL_PACK_SKIP_ROWS         | 
    GL_PACK_SWAP_BYTES        | 
    GL_UNPACK_ALIGNMENT       | 
    GL_UNPACK_IMAGE_HEIGHT    | 
    GL_UNPACK_LSB_FIRST       | 
    GL_UNPACK_ROW_LENGTH      | 
    GL_UNPACK_SKIP_IMAGES     | 
    GL_UNPACK_SKIP_PIXELS     | 
    GL_UNPACK_SKIP_ROWS       | 
    GL_UNPACK_SWAP_BYTES     

  instance GlEnum PixelStoreParameter where
    toGlInt GL_PACK_ALIGNMENT         = 0x0D05
    toGlInt GL_PACK_IMAGE_HEIGHT      = 0x806C
    toGlInt GL_PACK_LSB_FIRST         = 0x0D01
    toGlInt GL_PACK_ROW_LENGTH        = 0x0D02
    toGlInt GL_PACK_SKIP_IMAGES       = 0x806B
    toGlInt GL_PACK_SKIP_PIXELS       = 0x0D04
    toGlInt GL_PACK_SKIP_ROWS         = 0x0D03
    toGlInt GL_PACK_SWAP_BYTES        = 0x0D00
    toGlInt GL_UNPACK_ALIGNMENT       = 0x0CF5
    toGlInt GL_UNPACK_IMAGE_HEIGHT    = 0x806E
    toGlInt GL_UNPACK_LSB_FIRST       = 0x0CF1
    toGlInt GL_UNPACK_ROW_LENGTH      = 0x0CF2
    toGlInt GL_UNPACK_SKIP_IMAGES     = 0x806D
    toGlInt GL_UNPACK_SKIP_PIXELS     = 0x0CF4
    toGlInt GL_UNPACK_SKIP_ROWS       = 0x0CF3
    toGlInt GL_UNPACK_SWAP_BYTES      = 0x0CF0

namespace PixelTexGenMode 
  data PixelTexGenMode = 
    GL_NONE                   | 
    GL_RGB                    | 
    GL_RGBA                  

  instance GlEnum PixelTexGenMode where
    toGlInt GL_NONE                   = 0
    toGlInt GL_RGB                    = 0x1907
    toGlInt GL_RGBA                   = 0x1908

namespace PixelType 
  data PixelType = 
    GL_BYTE                   | 
    GL_FLOAT                  | 
    GL_INT                    | 
    GL_SHORT                  | 
    GL_UNSIGNED_BYTE          | 
    GL_UNSIGNED_BYTE_3_3_2    | 
    GL_UNSIGNED_INT           | 
    GL_UNSIGNED_INT_10_10_10_2 | 
    GL_UNSIGNED_INT_8_8_8_8   | 
    GL_UNSIGNED_SHORT         | 
    GL_UNSIGNED_SHORT_4_4_4_4 | 
    GL_UNSIGNED_SHORT_5_5_5_1

  instance GlEnum PixelType where
    toGlInt GL_BYTE                   = 0x1400
    toGlInt GL_FLOAT                  = 0x1406
    toGlInt GL_INT                    = 0x1404
    toGlInt GL_SHORT                  = 0x1402
    toGlInt GL_UNSIGNED_BYTE          = 0x1401
    toGlInt GL_UNSIGNED_BYTE_3_3_2    = 0x8032
    toGlInt GL_UNSIGNED_INT           = 0x1405
    toGlInt GL_UNSIGNED_INT_10_10_10_2 = 0x8036
    toGlInt GL_UNSIGNED_INT_8_8_8_8   = 0x8035
    toGlInt GL_UNSIGNED_SHORT         = 0x1403
    toGlInt GL_UNSIGNED_SHORT_4_4_4_4 = 0x8033
    toGlInt GL_UNSIGNED_SHORT_5_5_5_1 = 0x8034

namespace PointParameterNameSGIS 
  data PointParameterNameSGIS = 
    GL_POINT_FADE_THRESHOLD_SIZE

  instance GlEnum PointParameterNameSGIS where
    toGlInt GL_POINT_FADE_THRESHOLD_SIZE = 0x8128

namespace PolygonMode 
  data PolygonMode = 
    GL_FILL                   | 
    GL_LINE                   | 
    GL_POINT                 

  instance GlEnum PolygonMode where
    toGlInt GL_FILL                   = 0x1B02
    toGlInt GL_LINE                   = 0x1B01
    toGlInt GL_POINT                  = 0x1B00

namespace PrimitiveType 
  data PrimitiveType = 
    GL_LINES                  | 
    GL_LINES_ADJACENCY        | 
    GL_LINE_LOOP              | 
    GL_LINE_STRIP             | 
    GL_LINE_STRIP_ADJACENCY   | 
    GL_PATCHES                | 
    GL_POINTS                 | 
    GL_QUADS                  | 
    GL_TRIANGLES              | 
    GL_TRIANGLES_ADJACENCY    | 
    GL_TRIANGLE_FAN           | 
    GL_TRIANGLE_STRIP         | 
    GL_TRIANGLE_STRIP_ADJACENCY

  instance GlEnum PrimitiveType where
    toGlInt GL_LINES                  = 0x0001
    toGlInt GL_LINES_ADJACENCY        = 0x000A
    toGlInt GL_LINE_LOOP              = 0x0002
    toGlInt GL_LINE_STRIP             = 0x0003
    toGlInt GL_LINE_STRIP_ADJACENCY   = 0x000B
    toGlInt GL_PATCHES                = 0x000E
    toGlInt GL_POINTS                 = 0x0000
    toGlInt GL_QUADS                  = 0x0007
    toGlInt GL_TRIANGLES              = 0x0004
    toGlInt GL_TRIANGLES_ADJACENCY    = 0x000C
    toGlInt GL_TRIANGLE_FAN           = 0x0006
    toGlInt GL_TRIANGLE_STRIP         = 0x0005
    toGlInt GL_TRIANGLE_STRIP_ADJACENCY = 0x000D

namespace ReadBufferMode 
  data ReadBufferMode = 
    GL_BACK                   | 
    GL_BACK_LEFT              | 
    GL_BACK_RIGHT             | 
    GL_FRONT                  | 
    GL_FRONT_LEFT             | 
    GL_FRONT_RIGHT            | 
    GL_LEFT                   | 
    GL_RIGHT                 

  instance GlEnum ReadBufferMode where
    toGlInt GL_BACK                   = 0x0405
    toGlInt GL_BACK_LEFT              = 0x0402
    toGlInt GL_BACK_RIGHT             = 0x0403
    toGlInt GL_FRONT                  = 0x0404
    toGlInt GL_FRONT_LEFT             = 0x0400
    toGlInt GL_FRONT_RIGHT            = 0x0401
    toGlInt GL_LEFT                   = 0x0406
    toGlInt GL_RIGHT                  = 0x0407

namespace StencilFaceDirection 
  data StencilFaceDirection = 
    GL_FRONT                  | 
    GL_BACK                   | 
    GL_FRONT_AND_BACK        

  instance GlEnum StencilFaceDirection where
    toGlInt GL_FRONT                  = 0x0404
    toGlInt GL_BACK                   = 0x0405
    toGlInt GL_FRONT_AND_BACK         = 0x0408

namespace StencilFunction 
  data StencilFunction = 
    GL_ALWAYS                 | 
    GL_EQUAL                  | 
    GL_GEQUAL                 | 
    GL_GREATER                | 
    GL_LEQUAL                 | 
    GL_LESS                   | 
    GL_NEVER                  | 
    GL_NOTEQUAL              

  instance GlEnum StencilFunction where
    toGlInt GL_ALWAYS                 = 0x0207
    toGlInt GL_EQUAL                  = 0x0202
    toGlInt GL_GEQUAL                 = 0x0206
    toGlInt GL_GREATER                = 0x0204
    toGlInt GL_LEQUAL                 = 0x0203
    toGlInt GL_LESS                   = 0x0201
    toGlInt GL_NEVER                  = 0x0200
    toGlInt GL_NOTEQUAL               = 0x0205

namespace StencilOp 
  data StencilOp = 
    GL_DECR                   | 
    GL_INCR                   | 
    GL_INVERT                 | 
    GL_KEEP                   | 
    GL_REPLACE                | 
    GL_ZERO                  

  instance GlEnum StencilOp where
    toGlInt GL_DECR                   = 0x1E03
    toGlInt GL_INCR                   = 0x1E02
    toGlInt GL_INVERT                 = 0x150A
    toGlInt GL_KEEP                   = 0x1E00
    toGlInt GL_REPLACE                = 0x1E01
    toGlInt GL_ZERO                   = 0

namespace StringName 
  data StringName = 
    GL_EXTENSIONS             | 
    GL_RENDERER               | 
    GL_VENDOR                 | 
    GL_VERSION                | 
    GL_SHADING_LANGUAGE_VERSION

  instance GlEnum StringName where
    toGlInt GL_EXTENSIONS             = 0x1F03
    toGlInt GL_RENDERER               = 0x1F01
    toGlInt GL_VENDOR                 = 0x1F00
    toGlInt GL_VERSION                = 0x1F02
    toGlInt GL_SHADING_LANGUAGE_VERSION = 0x8B8C

namespace TexCoordPointerType 
  data TexCoordPointerType = 
    GL_DOUBLE                 | 
    GL_FLOAT                  | 
    GL_INT                    | 
    GL_SHORT                 

  instance GlEnum TexCoordPointerType where
    toGlInt GL_DOUBLE                 = 0x140A
    toGlInt GL_FLOAT                  = 0x1406
    toGlInt GL_INT                    = 0x1404
    toGlInt GL_SHORT                  = 0x1402

namespace TextureEnvMode 
  data TextureEnvMode = 
    GL_BLEND                 

  instance GlEnum TextureEnvMode where
    toGlInt GL_BLEND                  = 0x0BE2

namespace TextureMagFilter 
  data TextureMagFilter = 
    GL_LINEAR                 | 
    GL_NEAREST               

  instance GlEnum TextureMagFilter where
    toGlInt GL_LINEAR                 = 0x2601
    toGlInt GL_NEAREST                = 0x2600

namespace TextureMinFilter 
  data TextureMinFilter = 
    GL_LINEAR                 | 
    GL_LINEAR_MIPMAP_LINEAR   | 
    GL_LINEAR_MIPMAP_NEAREST  | 
    GL_NEAREST                | 
    GL_NEAREST_MIPMAP_LINEAR  | 
    GL_NEAREST_MIPMAP_NEAREST

  instance GlEnum TextureMinFilter where
    toGlInt GL_LINEAR                 = 0x2601
    toGlInt GL_LINEAR_MIPMAP_LINEAR   = 0x2703
    toGlInt GL_LINEAR_MIPMAP_NEAREST  = 0x2701
    toGlInt GL_NEAREST                = 0x2600
    toGlInt GL_NEAREST_MIPMAP_LINEAR  = 0x2702
    toGlInt GL_NEAREST_MIPMAP_NEAREST = 0x2700

namespace TextureParameterName 
  data TextureParameterName = 
    GL_TEXTURE_BORDER_COLOR   | 
    GL_TEXTURE_MAG_FILTER     | 
    GL_TEXTURE_MIN_FILTER     | 
    GL_TEXTURE_WRAP_R         | 
    GL_TEXTURE_WRAP_S         | 
    GL_TEXTURE_WRAP_T        

  instance GlEnum TextureParameterName where
    toGlInt GL_TEXTURE_BORDER_COLOR   = 0x1004
    toGlInt GL_TEXTURE_MAG_FILTER     = 0x2800
    toGlInt GL_TEXTURE_MIN_FILTER     = 0x2801
    toGlInt GL_TEXTURE_WRAP_R         = 0x8072
    toGlInt GL_TEXTURE_WRAP_S         = 0x2802
    toGlInt GL_TEXTURE_WRAP_T         = 0x2803

namespace TextureTarget 
  data TextureTarget = 
    GL_PROXY_TEXTURE_1D       | 
    GL_PROXY_TEXTURE_2D       | 
    GL_PROXY_TEXTURE_3D       | 
    GL_TEXTURE_1D             | 
    GL_TEXTURE_2D             | 
    GL_TEXTURE_3D             | 
    GL_TEXTURE_BASE_LEVEL     | 
    GL_TEXTURE_MAX_LEVEL      | 
    GL_TEXTURE_MAX_LOD        | 
    GL_TEXTURE_MIN_LOD       

  instance GlEnum TextureTarget where
    toGlInt GL_PROXY_TEXTURE_1D       = 0x8063
    toGlInt GL_PROXY_TEXTURE_2D       = 0x8064
    toGlInt GL_PROXY_TEXTURE_3D       = 0x8070
    toGlInt GL_TEXTURE_1D             = 0x0DE0
    toGlInt GL_TEXTURE_2D             = 0x0DE1
    toGlInt GL_TEXTURE_3D             = 0x806F
    toGlInt GL_TEXTURE_BASE_LEVEL     = 0x813C
    toGlInt GL_TEXTURE_MAX_LEVEL      = 0x813D
    toGlInt GL_TEXTURE_MAX_LOD        = 0x813B
    toGlInt GL_TEXTURE_MIN_LOD        = 0x813A

namespace TextureWrapMode 
  data TextureWrapMode = 
    GL_CLAMP_TO_BORDER        | 
    GL_CLAMP_TO_EDGE          | 
    GL_REPEAT                

  instance GlEnum TextureWrapMode where
    toGlInt GL_CLAMP_TO_BORDER        = 0x812D
    toGlInt GL_CLAMP_TO_EDGE          = 0x812F
    toGlInt GL_REPEAT                 = 0x2901

namespace UseProgramStageMask 
  data UseProgramStageMask = 
    GL_VERTEX_SHADER_BIT      | 
    GL_FRAGMENT_SHADER_BIT    | 
    GL_GEOMETRY_SHADER_BIT    | 
    GL_TESS_CONTROL_SHADER_BIT | 
    GL_TESS_EVALUATION_SHADER_BIT | 
    GL_ALL_SHADER_BITS       

  instance GlEnum UseProgramStageMask where
    toGlInt GL_VERTEX_SHADER_BIT      = 0x00000001
    toGlInt GL_FRAGMENT_SHADER_BIT    = 0x00000002
    toGlInt GL_GEOMETRY_SHADER_BIT    = 0x00000004
    toGlInt GL_TESS_CONTROL_SHADER_BIT = 0x00000008
    toGlInt GL_TESS_EVALUATION_SHADER_BIT = 0x00000010
    toGlInt GL_ALL_SHADER_BITS        = 0xFFFFFFFF

namespace VertexPointerType 
  data VertexPointerType = 
    GL_DOUBLE                 | 
    GL_FLOAT                  | 
    GL_INT                    | 
    GL_SHORT                 

  instance GlEnum VertexPointerType where
    toGlInt GL_DOUBLE                 = 0x140A
    toGlInt GL_FLOAT                  = 0x1406
    toGlInt GL_INT                    = 0x1404
    toGlInt GL_SHORT                  = 0x1402

namespace BufferTargetARB 
  data BufferTargetARB = 
    GL_ARRAY_BUFFER           | 
    GL_COPY_READ_BUFFER       | 
    GL_COPY_WRITE_BUFFER      | 
    GL_DRAW_INDIRECT_BUFFER   | 
    GL_ELEMENT_ARRAY_BUFFER   | 
    GL_PIXEL_PACK_BUFFER      | 
    GL_PIXEL_UNPACK_BUFFER    | 
    GL_TEXTURE_BUFFER         | 
    GL_TRANSFORM_FEEDBACK_BUFFER | 
    GL_UNIFORM_BUFFER        

  instance GlEnum BufferTargetARB where
    toGlInt GL_ARRAY_BUFFER           = 0x8892
    toGlInt GL_COPY_READ_BUFFER       = 0x8F36
    toGlInt GL_COPY_WRITE_BUFFER      = 0x8F37
    toGlInt GL_DRAW_INDIRECT_BUFFER   = 0x8F3F
    toGlInt GL_ELEMENT_ARRAY_BUFFER   = 0x8893
    toGlInt GL_PIXEL_PACK_BUFFER      = 0x88EB
    toGlInt GL_PIXEL_UNPACK_BUFFER    = 0x88EC
    toGlInt GL_TEXTURE_BUFFER         = 0x8C2A
    toGlInt GL_TRANSFORM_FEEDBACK_BUFFER = 0x8C8E
    toGlInt GL_UNIFORM_BUFFER         = 0x8A11

namespace BufferUsageARB 
  data BufferUsageARB = 
    GL_STREAM_DRAW            | 
    GL_STREAM_READ            | 
    GL_STREAM_COPY            | 
    GL_STATIC_DRAW            | 
    GL_STATIC_READ            | 
    GL_STATIC_COPY            | 
    GL_DYNAMIC_DRAW           | 
    GL_DYNAMIC_READ           | 
    GL_DYNAMIC_COPY          

  instance GlEnum BufferUsageARB where
    toGlInt GL_STREAM_DRAW            = 0x88E0
    toGlInt GL_STREAM_READ            = 0x88E1
    toGlInt GL_STREAM_COPY            = 0x88E2
    toGlInt GL_STATIC_DRAW            = 0x88E4
    toGlInt GL_STATIC_READ            = 0x88E5
    toGlInt GL_STATIC_COPY            = 0x88E6
    toGlInt GL_DYNAMIC_DRAW           = 0x88E8
    toGlInt GL_DYNAMIC_READ           = 0x88E9
    toGlInt GL_DYNAMIC_COPY           = 0x88EA

namespace BufferAccessARB 
  data BufferAccessARB = 
    GL_READ_ONLY              | 
    GL_WRITE_ONLY             | 
    GL_READ_WRITE            

  instance GlEnum BufferAccessARB where
    toGlInt GL_READ_ONLY              = 0x88B8
    toGlInt GL_WRITE_ONLY             = 0x88B9
    toGlInt GL_READ_WRITE             = 0x88BA

glGenVertexArrays : GLsizei -> IO (List GLuint)
glGenVertexArrays n = 
  do ptr <- intBuffer n
     foreign FFI_C "glGenVertexArrays" ( GLsizei -> Ptr -> IO ()) n ptr 
     intBufferToList ptr n



glBindVertexArray : GLuint -> IO ()
glBindVertexArray array = 
  foreign FFI_C "glBindVertexArray" ( GLuint -> IO ()) array



glGenBuffers : GLsizei -> IO (List GLuint)
glGenBuffers n = 
  do ptr <- intBuffer n
     foreign FFI_C "glGenBuffers" ( GLsizei -> Ptr -> IO ()) n ptr 
     intBufferToList ptr n



glBindBuffer : BufferTargetARB -> GLuint -> IO ()
glBindBuffer target buffer = 
  foreign FFI_C "glBindBuffer" ( Int -> GLuint -> IO ()) (toGlInt target) buffer



glBufferData : BufferTargetARB -> GLsizeiptr -> Ptr -> BufferUsageARB -> IO ()
glBufferData target size data' usage = 
  foreign FFI_C "glBufferData" ( Int -> GLsizeiptr -> Ptr -> Int -> IO ()) (toGlInt target) size data' (toGlInt usage)



glEnableVertexAttribArray : GLuint -> IO ()
glEnableVertexAttribArray index = 
  foreign FFI_C "glEnableVertexAttribArray" ( GLuint -> IO ()) index



glVertexAttribPointer : GLuint -> GLint -> VertexAttribPointerType -> GLboolean -> GLsizei -> Ptr -> IO ()
glVertexAttribPointer index size type normalized stride pointer = 
  foreign FFI_C "glVertexAttribPointer" ( GLuint -> GLint -> Int -> GLboolean -> GLsizei -> Ptr -> IO ()) index size (toGlInt type) normalized stride pointer



glCreateShader : GLenum -> IO GLuint
glCreateShader shaderType = 
  foreign FFI_C "glCreateShader" ( GLenum -> IO GLuint) shaderType



glShaderSource : GLuint -> GLsizei -> (List String) -> (List GLint) -> IO ()
glShaderSource shader count string length' = 
   do string' <- stringsToBuffer string
      length'' <- intsToBuffer length'
      res <- foreign FFI_C "glShaderSource" ( GLuint -> GLsizei -> Ptr -> Ptr -> IO ()) shader count string' length'' 
      freeStringBuffer string' (cast (length string))
      free length''
      pure ()



glCompileShader : GLuint -> IO ()
glCompileShader shader = 
  foreign FFI_C "glCompileShader" ( GLuint -> IO ()) shader



glCreateProgram : IO GLuint
glCreateProgram = 
  foreign FFI_C "glCreateProgram" (IO GLuint)



glAttachShader : GLuint -> GLuint -> IO ()
glAttachShader program shader = 
  foreign FFI_C "glAttachShader" ( GLuint -> GLuint -> IO ()) program shader



glLinkProgram : GLuint -> IO ()
glLinkProgram program = 
  foreign FFI_C "glLinkProgram" ( GLuint -> IO ()) program



glGetError : IO GLenum
glGetError = 
  foreign FFI_C "glGetError" (IO GLenum)



glGetUniformLocation : GLuint -> String -> IO GLint
glGetUniformLocation program name = 
  foreign FFI_C "glGetUniformLocation" ( GLuint -> String -> IO GLint) program name



glUniformMatrix4fv : GLint -> GLsizei -> GLboolean -> (List GLfloat) -> IO ()
glUniformMatrix4fv location count transpose value = 
   do value' <- floatsToBuffer value
      res <- foreign FFI_C "glUniformMatrix4fv" ( GLint -> GLsizei -> GLboolean -> Ptr -> IO ()) location count transpose value' 
      free value'
      pure ()



glUniform3fv : GLint -> GLsizei -> (List GLfloat) -> IO ()
glUniform3fv location count value = 
   do value' <- floatsToBuffer value
      res <- foreign FFI_C "glUniform3fv" ( GLint -> GLsizei -> Ptr -> IO ()) location count value' 
      free value'
      pure ()



glUniform1f : GLint -> GLfloat -> IO ()
glUniform1f location v0 = 
  foreign FFI_C "glUniform1f" ( GLint -> GLfloat -> IO ()) location v0



glDetachShader : GLuint -> GLuint -> IO ()
glDetachShader program shader = 
  foreign FFI_C "glDetachShader" ( GLuint -> GLuint -> IO ()) program shader



glDeleteProgram : GLuint -> IO ()
glDeleteProgram program = 
  foreign FFI_C "glDeleteProgram" ( GLuint -> IO ()) program



glDisableVertexAttribArray : GLuint -> IO ()
glDisableVertexAttribArray index = 
  foreign FFI_C "glDisableVertexAttribArray" ( GLuint -> IO ()) index



glDeleteBuffers : GLsizei -> (List GLuint) -> IO ()
glDeleteBuffers n buffers = 
   do buffers' <- intsToBuffer buffers
      res <- foreign FFI_C "glDeleteBuffers" ( GLsizei -> Ptr -> IO ()) n buffers' 
      free buffers'
      pure ()



glDeleteVertexArrays : GLsizei -> (List GLuint) -> IO ()
glDeleteVertexArrays n arrays = 
   do arrays' <- intsToBuffer arrays
      res <- foreign FFI_C "glDeleteVertexArrays" ( GLsizei -> Ptr -> IO ()) n arrays' 
      free arrays'
      pure ()



glClearColor : GLfloat -> GLfloat -> GLfloat -> GLfloat -> IO ()
glClearColor red green blue alpha = 
  foreign FFI_C "glClearColor" ( GLfloat -> GLfloat -> GLfloat -> GLfloat -> IO ()) red green blue alpha



glClear : ClearBufferMask -> IO ()
glClear mask = 
  foreign FFI_C "glClear" ( Int -> IO ()) (toGlInt mask)



glBindTexture : TextureTarget -> GLuint -> IO ()
glBindTexture target texture = 
  foreign FFI_C "glBindTexture" ( Int -> GLuint -> IO ()) (toGlInt target) texture



glDrawElements : PrimitiveType -> GLsizei -> DrawElementsType -> Ptr -> IO ()
glDrawElements mode count type indices = 
  foreign FFI_C "glDrawElements" ( Int -> GLsizei -> Int -> Ptr -> IO ()) (toGlInt mode) count (toGlInt type) indices



glDrawArrays : PrimitiveType -> GLint -> GLsizei -> IO ()
glDrawArrays mode first count = 
  foreign FFI_C "glDrawArrays" ( Int -> GLint -> GLsizei -> IO ()) (toGlInt mode) first count



glEnable : EnableCap -> IO ()
glEnable cap = 
  foreign FFI_C "glEnable" ( Int -> IO ()) (toGlInt cap)



glDepthFunc : DepthFunction -> IO ()
glDepthFunc func = 
  foreign FFI_C "glDepthFunc" ( Int -> IO ()) (toGlInt func)



glActiveTexture : GLsizei -> IO ()
glActiveTexture texture = 
  foreign FFI_C "glActiveTexture" ( GLsizei -> IO ()) texture



glTexParameteri : TextureTarget -> TextureParameterName -> GLint -> IO ()
glTexParameteri target pname param = 
  foreign FFI_C "glTexParameteri" ( Int -> Int -> GLint -> IO ()) (toGlInt target) (toGlInt pname) param



glDeleteTextures : GLsizei -> (List GLuint) -> IO ()
glDeleteTextures n textures = 
   do textures' <- intsToBuffer textures
      res <- foreign FFI_C "glDeleteTextures" ( GLsizei -> Ptr -> IO ()) n textures' 
      free textures'
      pure ()



glUseProgram : GLuint -> IO ()
glUseProgram program = 
  foreign FFI_C "glUseProgram" ( GLuint -> IO ()) program



glDeleteShader : GLuint -> IO ()
glDeleteShader shader = 
  foreign FFI_C "glDeleteShader" ( GLuint -> IO ()) shader



glGetString : StringName -> IO String
glGetString name = 
  foreign FFI_C "glGetString" ( Int -> IO String) (toGlInt name)




namespace GlEnums 
  GL_DEPTH_BUFFER_BIT      : GLenum
  GL_DEPTH_BUFFER_BIT       = 0x00000100

  GL_STENCIL_BUFFER_BIT    : GLenum
  GL_STENCIL_BUFFER_BIT     = 0x00000400

  GL_COLOR_BUFFER_BIT      : GLenum
  GL_COLOR_BUFFER_BIT       = 0x00004000

  GL_FALSE                 : GLenum
  GL_FALSE                  = 0

  GL_TRUE                  : GLenum
  GL_TRUE                   = 1

  GL_POINTS                : GLenum
  GL_POINTS                 = 0x0000

  GL_LINES                 : GLenum
  GL_LINES                  = 0x0001

  GL_LINE_LOOP             : GLenum
  GL_LINE_LOOP              = 0x0002

  GL_LINE_STRIP            : GLenum
  GL_LINE_STRIP             = 0x0003

  GL_TRIANGLES             : GLenum
  GL_TRIANGLES              = 0x0004

  GL_TRIANGLE_STRIP        : GLenum
  GL_TRIANGLE_STRIP         = 0x0005

  GL_TRIANGLE_FAN          : GLenum
  GL_TRIANGLE_FAN           = 0x0006

  GL_NEVER                 : GLenum
  GL_NEVER                  = 0x0200

  GL_LESS                  : GLenum
  GL_LESS                   = 0x0201

  GL_EQUAL                 : GLenum
  GL_EQUAL                  = 0x0202

  GL_LEQUAL                : GLenum
  GL_LEQUAL                 = 0x0203

  GL_GREATER               : GLenum
  GL_GREATER                = 0x0204

  GL_NOTEQUAL              : GLenum
  GL_NOTEQUAL               = 0x0205

  GL_GEQUAL                : GLenum
  GL_GEQUAL                 = 0x0206

  GL_ALWAYS                : GLenum
  GL_ALWAYS                 = 0x0207

  GL_ZERO                  : GLenum
  GL_ZERO                   = 0

  GL_ONE                   : GLenum
  GL_ONE                    = 1

  GL_SRC_COLOR             : GLenum
  GL_SRC_COLOR              = 0x0300

  GL_ONE_MINUS_SRC_COLOR   : GLenum
  GL_ONE_MINUS_SRC_COLOR    = 0x0301

  GL_SRC_ALPHA             : GLenum
  GL_SRC_ALPHA              = 0x0302

  GL_ONE_MINUS_SRC_ALPHA   : GLenum
  GL_ONE_MINUS_SRC_ALPHA    = 0x0303

  GL_DST_ALPHA             : GLenum
  GL_DST_ALPHA              = 0x0304

  GL_ONE_MINUS_DST_ALPHA   : GLenum
  GL_ONE_MINUS_DST_ALPHA    = 0x0305

  GL_DST_COLOR             : GLenum
  GL_DST_COLOR              = 0x0306

  GL_ONE_MINUS_DST_COLOR   : GLenum
  GL_ONE_MINUS_DST_COLOR    = 0x0307

  GL_SRC_ALPHA_SATURATE    : GLenum
  GL_SRC_ALPHA_SATURATE     = 0x0308

  GL_NONE                  : GLenum
  GL_NONE                   = 0

  GL_FRONT_LEFT            : GLenum
  GL_FRONT_LEFT             = 0x0400

  GL_FRONT_RIGHT           : GLenum
  GL_FRONT_RIGHT            = 0x0401

  GL_BACK_LEFT             : GLenum
  GL_BACK_LEFT              = 0x0402

  GL_BACK_RIGHT            : GLenum
  GL_BACK_RIGHT             = 0x0403

  GL_FRONT                 : GLenum
  GL_FRONT                  = 0x0404

  GL_BACK                  : GLenum
  GL_BACK                   = 0x0405

  GL_LEFT                  : GLenum
  GL_LEFT                   = 0x0406

  GL_RIGHT                 : GLenum
  GL_RIGHT                  = 0x0407

  GL_FRONT_AND_BACK        : GLenum
  GL_FRONT_AND_BACK         = 0x0408

  GL_NO_ERROR              : GLenum
  GL_NO_ERROR               = 0

  GL_INVALID_ENUM          : GLenum
  GL_INVALID_ENUM           = 0x0500

  GL_INVALID_VALUE         : GLenum
  GL_INVALID_VALUE          = 0x0501

  GL_INVALID_OPERATION     : GLenum
  GL_INVALID_OPERATION      = 0x0502

  GL_OUT_OF_MEMORY         : GLenum
  GL_OUT_OF_MEMORY          = 0x0505

  GL_CW                    : GLenum
  GL_CW                     = 0x0900

  GL_CCW                   : GLenum
  GL_CCW                    = 0x0901

  GL_POINT_SIZE            : GLenum
  GL_POINT_SIZE             = 0x0B11

  GL_POINT_SIZE_RANGE      : GLenum
  GL_POINT_SIZE_RANGE       = 0x0B12

  GL_POINT_SIZE_GRANULARITY: GLenum
  GL_POINT_SIZE_GRANULARITY = 0x0B13

  GL_LINE_SMOOTH           : GLenum
  GL_LINE_SMOOTH            = 0x0B20

  GL_LINE_WIDTH            : GLenum
  GL_LINE_WIDTH             = 0x0B21

  GL_LINE_WIDTH_RANGE      : GLenum
  GL_LINE_WIDTH_RANGE       = 0x0B22

  GL_LINE_WIDTH_GRANULARITY: GLenum
  GL_LINE_WIDTH_GRANULARITY = 0x0B23

  GL_POLYGON_MODE          : GLenum
  GL_POLYGON_MODE           = 0x0B40

  GL_POLYGON_SMOOTH        : GLenum
  GL_POLYGON_SMOOTH         = 0x0B41

  GL_CULL_FACE             : GLenum
  GL_CULL_FACE              = 0x0B44

  GL_CULL_FACE_MODE        : GLenum
  GL_CULL_FACE_MODE         = 0x0B45

  GL_FRONT_FACE            : GLenum
  GL_FRONT_FACE             = 0x0B46

  GL_DEPTH_RANGE           : GLenum
  GL_DEPTH_RANGE            = 0x0B70

  GL_DEPTH_TEST            : GLenum
  GL_DEPTH_TEST             = 0x0B71

  GL_DEPTH_WRITEMASK       : GLenum
  GL_DEPTH_WRITEMASK        = 0x0B72

  GL_DEPTH_CLEAR_VALUE     : GLenum
  GL_DEPTH_CLEAR_VALUE      = 0x0B73

  GL_DEPTH_FUNC            : GLenum
  GL_DEPTH_FUNC             = 0x0B74

  GL_STENCIL_TEST          : GLenum
  GL_STENCIL_TEST           = 0x0B90

  GL_STENCIL_CLEAR_VALUE   : GLenum
  GL_STENCIL_CLEAR_VALUE    = 0x0B91

  GL_STENCIL_FUNC          : GLenum
  GL_STENCIL_FUNC           = 0x0B92

  GL_STENCIL_VALUE_MASK    : GLenum
  GL_STENCIL_VALUE_MASK     = 0x0B93

  GL_STENCIL_FAIL          : GLenum
  GL_STENCIL_FAIL           = 0x0B94

  GL_STENCIL_PASS_DEPTH_FAIL: GLenum
  GL_STENCIL_PASS_DEPTH_FAIL = 0x0B95

  GL_STENCIL_PASS_DEPTH_PASS: GLenum
  GL_STENCIL_PASS_DEPTH_PASS = 0x0B96

  GL_STENCIL_REF           : GLenum
  GL_STENCIL_REF            = 0x0B97

  GL_STENCIL_WRITEMASK     : GLenum
  GL_STENCIL_WRITEMASK      = 0x0B98

  GL_VIEWPORT              : GLenum
  GL_VIEWPORT               = 0x0BA2

  GL_DITHER                : GLenum
  GL_DITHER                 = 0x0BD0

  GL_BLEND_DST             : GLenum
  GL_BLEND_DST              = 0x0BE0

  GL_BLEND_SRC             : GLenum
  GL_BLEND_SRC              = 0x0BE1

  GL_BLEND                 : GLenum
  GL_BLEND                  = 0x0BE2

  GL_LOGIC_OP_MODE         : GLenum
  GL_LOGIC_OP_MODE          = 0x0BF0

  GL_COLOR_LOGIC_OP        : GLenum
  GL_COLOR_LOGIC_OP         = 0x0BF2

  GL_DRAW_BUFFER           : GLenum
  GL_DRAW_BUFFER            = 0x0C01

  GL_READ_BUFFER           : GLenum
  GL_READ_BUFFER            = 0x0C02

  GL_SCISSOR_BOX           : GLenum
  GL_SCISSOR_BOX            = 0x0C10

  GL_SCISSOR_TEST          : GLenum
  GL_SCISSOR_TEST           = 0x0C11

  GL_COLOR_CLEAR_VALUE     : GLenum
  GL_COLOR_CLEAR_VALUE      = 0x0C22

  GL_COLOR_WRITEMASK       : GLenum
  GL_COLOR_WRITEMASK        = 0x0C23

  GL_DOUBLEBUFFER          : GLenum
  GL_DOUBLEBUFFER           = 0x0C32

  GL_STEREO                : GLenum
  GL_STEREO                 = 0x0C33

  GL_LINE_SMOOTH_HINT      : GLenum
  GL_LINE_SMOOTH_HINT       = 0x0C52

  GL_POLYGON_SMOOTH_HINT   : GLenum
  GL_POLYGON_SMOOTH_HINT    = 0x0C53

  GL_UNPACK_SWAP_BYTES     : GLenum
  GL_UNPACK_SWAP_BYTES      = 0x0CF0

  GL_UNPACK_LSB_FIRST      : GLenum
  GL_UNPACK_LSB_FIRST       = 0x0CF1

  GL_UNPACK_ROW_LENGTH     : GLenum
  GL_UNPACK_ROW_LENGTH      = 0x0CF2

  GL_UNPACK_SKIP_ROWS      : GLenum
  GL_UNPACK_SKIP_ROWS       = 0x0CF3

  GL_UNPACK_SKIP_PIXELS    : GLenum
  GL_UNPACK_SKIP_PIXELS     = 0x0CF4

  GL_UNPACK_ALIGNMENT      : GLenum
  GL_UNPACK_ALIGNMENT       = 0x0CF5

  GL_PACK_SWAP_BYTES       : GLenum
  GL_PACK_SWAP_BYTES        = 0x0D00

  GL_PACK_LSB_FIRST        : GLenum
  GL_PACK_LSB_FIRST         = 0x0D01

  GL_PACK_ROW_LENGTH       : GLenum
  GL_PACK_ROW_LENGTH        = 0x0D02

  GL_PACK_SKIP_ROWS        : GLenum
  GL_PACK_SKIP_ROWS         = 0x0D03

  GL_PACK_SKIP_PIXELS      : GLenum
  GL_PACK_SKIP_PIXELS       = 0x0D04

  GL_PACK_ALIGNMENT        : GLenum
  GL_PACK_ALIGNMENT         = 0x0D05

  GL_MAX_TEXTURE_SIZE      : GLenum
  GL_MAX_TEXTURE_SIZE       = 0x0D33

  GL_MAX_VIEWPORT_DIMS     : GLenum
  GL_MAX_VIEWPORT_DIMS      = 0x0D3A

  GL_SUBPIXEL_BITS         : GLenum
  GL_SUBPIXEL_BITS          = 0x0D50

  GL_TEXTURE_1D            : GLenum
  GL_TEXTURE_1D             = 0x0DE0

  GL_TEXTURE_2D            : GLenum
  GL_TEXTURE_2D             = 0x0DE1

  GL_POLYGON_OFFSET_UNITS  : GLenum
  GL_POLYGON_OFFSET_UNITS   = 0x2A00

  GL_POLYGON_OFFSET_POINT  : GLenum
  GL_POLYGON_OFFSET_POINT   = 0x2A01

  GL_POLYGON_OFFSET_LINE   : GLenum
  GL_POLYGON_OFFSET_LINE    = 0x2A02

  GL_POLYGON_OFFSET_FILL   : GLenum
  GL_POLYGON_OFFSET_FILL    = 0x8037

  GL_POLYGON_OFFSET_FACTOR : GLenum
  GL_POLYGON_OFFSET_FACTOR  = 0x8038

  GL_TEXTURE_BINDING_1D    : GLenum
  GL_TEXTURE_BINDING_1D     = 0x8068

  GL_TEXTURE_BINDING_2D    : GLenum
  GL_TEXTURE_BINDING_2D     = 0x8069

  GL_TEXTURE_WIDTH         : GLenum
  GL_TEXTURE_WIDTH          = 0x1000

  GL_TEXTURE_HEIGHT        : GLenum
  GL_TEXTURE_HEIGHT         = 0x1001

  GL_TEXTURE_INTERNAL_FORMAT: GLenum
  GL_TEXTURE_INTERNAL_FORMAT = 0x1003

  GL_TEXTURE_BORDER_COLOR  : GLenum
  GL_TEXTURE_BORDER_COLOR   = 0x1004

  GL_TEXTURE_RED_SIZE      : GLenum
  GL_TEXTURE_RED_SIZE       = 0x805C

  GL_TEXTURE_GREEN_SIZE    : GLenum
  GL_TEXTURE_GREEN_SIZE     = 0x805D

  GL_TEXTURE_BLUE_SIZE     : GLenum
  GL_TEXTURE_BLUE_SIZE      = 0x805E

  GL_TEXTURE_ALPHA_SIZE    : GLenum
  GL_TEXTURE_ALPHA_SIZE     = 0x805F

  GL_DONT_CARE             : GLenum
  GL_DONT_CARE              = 0x1100

  GL_FASTEST               : GLenum
  GL_FASTEST                = 0x1101

  GL_NICEST                : GLenum
  GL_NICEST                 = 0x1102

  GL_BYTE                  : GLenum
  GL_BYTE                   = 0x1400

  GL_UNSIGNED_BYTE         : GLenum
  GL_UNSIGNED_BYTE          = 0x1401

  GL_SHORT                 : GLenum
  GL_SHORT                  = 0x1402

  GL_UNSIGNED_SHORT        : GLenum
  GL_UNSIGNED_SHORT         = 0x1403

  GL_INT                   : GLenum
  GL_INT                    = 0x1404

  GL_UNSIGNED_INT          : GLenum
  GL_UNSIGNED_INT           = 0x1405

  GL_FLOAT                 : GLenum
  GL_FLOAT                  = 0x1406

  GL_DOUBLE                : GLenum
  GL_DOUBLE                 = 0x140A

  GL_CLEAR                 : GLenum
  GL_CLEAR                  = 0x1500

  GL_AND                   : GLenum
  GL_AND                    = 0x1501

  GL_AND_REVERSE           : GLenum
  GL_AND_REVERSE            = 0x1502

  GL_COPY                  : GLenum
  GL_COPY                   = 0x1503

  GL_AND_INVERTED          : GLenum
  GL_AND_INVERTED           = 0x1504

  GL_NOOP                  : GLenum
  GL_NOOP                   = 0x1505

  GL_XOR                   : GLenum
  GL_XOR                    = 0x1506

  GL_OR                    : GLenum
  GL_OR                     = 0x1507

  GL_NOR                   : GLenum
  GL_NOR                    = 0x1508

  GL_EQUIV                 : GLenum
  GL_EQUIV                  = 0x1509

  GL_INVERT                : GLenum
  GL_INVERT                 = 0x150A

  GL_OR_REVERSE            : GLenum
  GL_OR_REVERSE             = 0x150B

  GL_COPY_INVERTED         : GLenum
  GL_COPY_INVERTED          = 0x150C

  GL_OR_INVERTED           : GLenum
  GL_OR_INVERTED            = 0x150D

  GL_NAND                  : GLenum
  GL_NAND                   = 0x150E

  GL_SET                   : GLenum
  GL_SET                    = 0x150F

  GL_TEXTURE               : GLenum
  GL_TEXTURE                = 0x1702

  GL_COLOR                 : GLenum
  GL_COLOR                  = 0x1800

  GL_DEPTH                 : GLenum
  GL_DEPTH                  = 0x1801

  GL_STENCIL               : GLenum
  GL_STENCIL                = 0x1802

  GL_STENCIL_INDEX         : GLenum
  GL_STENCIL_INDEX          = 0x1901

  GL_DEPTH_COMPONENT       : GLenum
  GL_DEPTH_COMPONENT        = 0x1902

  GL_RED                   : GLenum
  GL_RED                    = 0x1903

  GL_GREEN                 : GLenum
  GL_GREEN                  = 0x1904

  GL_BLUE                  : GLenum
  GL_BLUE                   = 0x1905

  GL_ALPHA                 : GLenum
  GL_ALPHA                  = 0x1906

  GL_RGB                   : GLenum
  GL_RGB                    = 0x1907

  GL_RGBA                  : GLenum
  GL_RGBA                   = 0x1908

  GL_POINT                 : GLenum
  GL_POINT                  = 0x1B00

  GL_LINE                  : GLenum
  GL_LINE                   = 0x1B01

  GL_FILL                  : GLenum
  GL_FILL                   = 0x1B02

  GL_KEEP                  : GLenum
  GL_KEEP                   = 0x1E00

  GL_REPLACE               : GLenum
  GL_REPLACE                = 0x1E01

  GL_INCR                  : GLenum
  GL_INCR                   = 0x1E02

  GL_DECR                  : GLenum
  GL_DECR                   = 0x1E03

  GL_VENDOR                : GLenum
  GL_VENDOR                 = 0x1F00

  GL_RENDERER              : GLenum
  GL_RENDERER               = 0x1F01

  GL_VERSION               : GLenum
  GL_VERSION                = 0x1F02

  GL_EXTENSIONS            : GLenum
  GL_EXTENSIONS             = 0x1F03

  GL_NEAREST               : GLenum
  GL_NEAREST                = 0x2600

  GL_LINEAR                : GLenum
  GL_LINEAR                 = 0x2601

  GL_NEAREST_MIPMAP_NEAREST: GLenum
  GL_NEAREST_MIPMAP_NEAREST = 0x2700

  GL_LINEAR_MIPMAP_NEAREST : GLenum
  GL_LINEAR_MIPMAP_NEAREST  = 0x2701

  GL_NEAREST_MIPMAP_LINEAR : GLenum
  GL_NEAREST_MIPMAP_LINEAR  = 0x2702

  GL_LINEAR_MIPMAP_LINEAR  : GLenum
  GL_LINEAR_MIPMAP_LINEAR   = 0x2703

  GL_TEXTURE_MAG_FILTER    : GLenum
  GL_TEXTURE_MAG_FILTER     = 0x2800

  GL_TEXTURE_MIN_FILTER    : GLenum
  GL_TEXTURE_MIN_FILTER     = 0x2801

  GL_TEXTURE_WRAP_S        : GLenum
  GL_TEXTURE_WRAP_S         = 0x2802

  GL_TEXTURE_WRAP_T        : GLenum
  GL_TEXTURE_WRAP_T         = 0x2803

  GL_PROXY_TEXTURE_1D      : GLenum
  GL_PROXY_TEXTURE_1D       = 0x8063

  GL_PROXY_TEXTURE_2D      : GLenum
  GL_PROXY_TEXTURE_2D       = 0x8064

  GL_REPEAT                : GLenum
  GL_REPEAT                 = 0x2901

  GL_R3_G3_B2              : GLenum
  GL_R3_G3_B2               = 0x2A10

  GL_RGB4                  : GLenum
  GL_RGB4                   = 0x804F

  GL_RGB5                  : GLenum
  GL_RGB5                   = 0x8050

  GL_RGB8                  : GLenum
  GL_RGB8                   = 0x8051

  GL_RGB10                 : GLenum
  GL_RGB10                  = 0x8052

  GL_RGB12                 : GLenum
  GL_RGB12                  = 0x8053

  GL_RGB16                 : GLenum
  GL_RGB16                  = 0x8054

  GL_RGBA2                 : GLenum
  GL_RGBA2                  = 0x8055

  GL_RGBA4                 : GLenum
  GL_RGBA4                  = 0x8056

  GL_RGB5_A1               : GLenum
  GL_RGB5_A1                = 0x8057

  GL_RGBA8                 : GLenum
  GL_RGBA8                  = 0x8058

  GL_RGB10_A2              : GLenum
  GL_RGB10_A2               = 0x8059

  GL_RGBA12                : GLenum
  GL_RGBA12                 = 0x805A

  GL_RGBA16                : GLenum
  GL_RGBA16                 = 0x805B

  GL_UNSIGNED_BYTE_3_3_2   : GLenum
  GL_UNSIGNED_BYTE_3_3_2    = 0x8032

  GL_UNSIGNED_SHORT_4_4_4_4: GLenum
  GL_UNSIGNED_SHORT_4_4_4_4 = 0x8033

  GL_UNSIGNED_SHORT_5_5_5_1: GLenum
  GL_UNSIGNED_SHORT_5_5_5_1 = 0x8034

  GL_UNSIGNED_INT_8_8_8_8  : GLenum
  GL_UNSIGNED_INT_8_8_8_8   = 0x8035

  GL_UNSIGNED_INT_10_10_10_2: GLenum
  GL_UNSIGNED_INT_10_10_10_2 = 0x8036

  GL_TEXTURE_BINDING_3D    : GLenum
  GL_TEXTURE_BINDING_3D     = 0x806A

  GL_PACK_SKIP_IMAGES      : GLenum
  GL_PACK_SKIP_IMAGES       = 0x806B

  GL_PACK_IMAGE_HEIGHT     : GLenum
  GL_PACK_IMAGE_HEIGHT      = 0x806C

  GL_UNPACK_SKIP_IMAGES    : GLenum
  GL_UNPACK_SKIP_IMAGES     = 0x806D

  GL_UNPACK_IMAGE_HEIGHT   : GLenum
  GL_UNPACK_IMAGE_HEIGHT    = 0x806E

  GL_TEXTURE_3D            : GLenum
  GL_TEXTURE_3D             = 0x806F

  GL_PROXY_TEXTURE_3D      : GLenum
  GL_PROXY_TEXTURE_3D       = 0x8070

  GL_TEXTURE_DEPTH         : GLenum
  GL_TEXTURE_DEPTH          = 0x8071

  GL_TEXTURE_WRAP_R        : GLenum
  GL_TEXTURE_WRAP_R         = 0x8072

  GL_MAX_3D_TEXTURE_SIZE   : GLenum
  GL_MAX_3D_TEXTURE_SIZE    = 0x8073

  GL_UNSIGNED_BYTE_2_3_3_REV: GLenum
  GL_UNSIGNED_BYTE_2_3_3_REV = 0x8362

  GL_UNSIGNED_SHORT_5_6_5  : GLenum
  GL_UNSIGNED_SHORT_5_6_5   = 0x8363

  GL_UNSIGNED_SHORT_5_6_5_REV: GLenum
  GL_UNSIGNED_SHORT_5_6_5_REV = 0x8364

  GL_UNSIGNED_SHORT_4_4_4_4_REV: GLenum
  GL_UNSIGNED_SHORT_4_4_4_4_REV = 0x8365

  GL_UNSIGNED_SHORT_1_5_5_5_REV: GLenum
  GL_UNSIGNED_SHORT_1_5_5_5_REV = 0x8366

  GL_UNSIGNED_INT_8_8_8_8_REV: GLenum
  GL_UNSIGNED_INT_8_8_8_8_REV = 0x8367

  GL_UNSIGNED_INT_2_10_10_10_REV: GLenum
  GL_UNSIGNED_INT_2_10_10_10_REV = 0x8368

  GL_BGR                   : GLenum
  GL_BGR                    = 0x80E0

  GL_BGRA                  : GLenum
  GL_BGRA                   = 0x80E1

  GL_MAX_ELEMENTS_VERTICES : GLenum
  GL_MAX_ELEMENTS_VERTICES  = 0x80E8

  GL_MAX_ELEMENTS_INDICES  : GLenum
  GL_MAX_ELEMENTS_INDICES   = 0x80E9

  GL_CLAMP_TO_EDGE         : GLenum
  GL_CLAMP_TO_EDGE          = 0x812F

  GL_TEXTURE_MIN_LOD       : GLenum
  GL_TEXTURE_MIN_LOD        = 0x813A

  GL_TEXTURE_MAX_LOD       : GLenum
  GL_TEXTURE_MAX_LOD        = 0x813B

  GL_TEXTURE_BASE_LEVEL    : GLenum
  GL_TEXTURE_BASE_LEVEL     = 0x813C

  GL_TEXTURE_MAX_LEVEL     : GLenum
  GL_TEXTURE_MAX_LEVEL      = 0x813D

  GL_SMOOTH_POINT_SIZE_RANGE: GLenum
  GL_SMOOTH_POINT_SIZE_RANGE = 0x0B12

  GL_SMOOTH_POINT_SIZE_GRANULARITY: GLenum
  GL_SMOOTH_POINT_SIZE_GRANULARITY = 0x0B13

  GL_SMOOTH_LINE_WIDTH_RANGE: GLenum
  GL_SMOOTH_LINE_WIDTH_RANGE = 0x0B22

  GL_SMOOTH_LINE_WIDTH_GRANULARITY: GLenum
  GL_SMOOTH_LINE_WIDTH_GRANULARITY = 0x0B23

  GL_ALIASED_LINE_WIDTH_RANGE: GLenum
  GL_ALIASED_LINE_WIDTH_RANGE = 0x846E

  GL_TEXTURE0              : GLenum
  GL_TEXTURE0               = 0x84C0

  GL_TEXTURE1              : GLenum
  GL_TEXTURE1               = 0x84C1

  GL_TEXTURE2              : GLenum
  GL_TEXTURE2               = 0x84C2

  GL_TEXTURE3              : GLenum
  GL_TEXTURE3               = 0x84C3

  GL_TEXTURE4              : GLenum
  GL_TEXTURE4               = 0x84C4

  GL_TEXTURE5              : GLenum
  GL_TEXTURE5               = 0x84C5

  GL_TEXTURE6              : GLenum
  GL_TEXTURE6               = 0x84C6

  GL_TEXTURE7              : GLenum
  GL_TEXTURE7               = 0x84C7

  GL_TEXTURE8              : GLenum
  GL_TEXTURE8               = 0x84C8

  GL_TEXTURE9              : GLenum
  GL_TEXTURE9               = 0x84C9

  GL_TEXTURE10             : GLenum
  GL_TEXTURE10              = 0x84CA

  GL_TEXTURE11             : GLenum
  GL_TEXTURE11              = 0x84CB

  GL_TEXTURE12             : GLenum
  GL_TEXTURE12              = 0x84CC

  GL_TEXTURE13             : GLenum
  GL_TEXTURE13              = 0x84CD

  GL_TEXTURE14             : GLenum
  GL_TEXTURE14              = 0x84CE

  GL_TEXTURE15             : GLenum
  GL_TEXTURE15              = 0x84CF

  GL_TEXTURE16             : GLenum
  GL_TEXTURE16              = 0x84D0

  GL_TEXTURE17             : GLenum
  GL_TEXTURE17              = 0x84D1

  GL_TEXTURE18             : GLenum
  GL_TEXTURE18              = 0x84D2

  GL_TEXTURE19             : GLenum
  GL_TEXTURE19              = 0x84D3

  GL_TEXTURE20             : GLenum
  GL_TEXTURE20              = 0x84D4

  GL_TEXTURE21             : GLenum
  GL_TEXTURE21              = 0x84D5

  GL_TEXTURE22             : GLenum
  GL_TEXTURE22              = 0x84D6

  GL_TEXTURE23             : GLenum
  GL_TEXTURE23              = 0x84D7

  GL_TEXTURE24             : GLenum
  GL_TEXTURE24              = 0x84D8

  GL_TEXTURE25             : GLenum
  GL_TEXTURE25              = 0x84D9

  GL_TEXTURE26             : GLenum
  GL_TEXTURE26              = 0x84DA

  GL_TEXTURE27             : GLenum
  GL_TEXTURE27              = 0x84DB

  GL_TEXTURE28             : GLenum
  GL_TEXTURE28              = 0x84DC

  GL_TEXTURE29             : GLenum
  GL_TEXTURE29              = 0x84DD

  GL_TEXTURE30             : GLenum
  GL_TEXTURE30              = 0x84DE

  GL_TEXTURE31             : GLenum
  GL_TEXTURE31              = 0x84DF

  GL_ACTIVE_TEXTURE        : GLenum
  GL_ACTIVE_TEXTURE         = 0x84E0

  GL_MULTISAMPLE           : GLenum
  GL_MULTISAMPLE            = 0x809D

  GL_SAMPLE_ALPHA_TO_COVERAGE: GLenum
  GL_SAMPLE_ALPHA_TO_COVERAGE = 0x809E

  GL_SAMPLE_ALPHA_TO_ONE   : GLenum
  GL_SAMPLE_ALPHA_TO_ONE    = 0x809F

  GL_SAMPLE_COVERAGE       : GLenum
  GL_SAMPLE_COVERAGE        = 0x80A0

  GL_SAMPLE_BUFFERS        : GLenum
  GL_SAMPLE_BUFFERS         = 0x80A8

  GL_SAMPLES               : GLenum
  GL_SAMPLES                = 0x80A9

  GL_SAMPLE_COVERAGE_VALUE : GLenum
  GL_SAMPLE_COVERAGE_VALUE  = 0x80AA

  GL_SAMPLE_COVERAGE_INVERT: GLenum
  GL_SAMPLE_COVERAGE_INVERT = 0x80AB

  GL_TEXTURE_CUBE_MAP      : GLenum
  GL_TEXTURE_CUBE_MAP       = 0x8513

  GL_TEXTURE_BINDING_CUBE_MAP: GLenum
  GL_TEXTURE_BINDING_CUBE_MAP = 0x8514

  GL_TEXTURE_CUBE_MAP_POSITIVE_X: GLenum
  GL_TEXTURE_CUBE_MAP_POSITIVE_X = 0x8515

  GL_TEXTURE_CUBE_MAP_NEGATIVE_X: GLenum
  GL_TEXTURE_CUBE_MAP_NEGATIVE_X = 0x8516

  GL_TEXTURE_CUBE_MAP_POSITIVE_Y: GLenum
  GL_TEXTURE_CUBE_MAP_POSITIVE_Y = 0x8517

  GL_TEXTURE_CUBE_MAP_NEGATIVE_Y: GLenum
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Y = 0x8518

  GL_TEXTURE_CUBE_MAP_POSITIVE_Z: GLenum
  GL_TEXTURE_CUBE_MAP_POSITIVE_Z = 0x8519

  GL_TEXTURE_CUBE_MAP_NEGATIVE_Z: GLenum
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Z = 0x851A

  GL_PROXY_TEXTURE_CUBE_MAP: GLenum
  GL_PROXY_TEXTURE_CUBE_MAP = 0x851B

  GL_MAX_CUBE_MAP_TEXTURE_SIZE: GLenum
  GL_MAX_CUBE_MAP_TEXTURE_SIZE = 0x851C

  GL_COMPRESSED_RGB        : GLenum
  GL_COMPRESSED_RGB         = 0x84ED

  GL_COMPRESSED_RGBA       : GLenum
  GL_COMPRESSED_RGBA        = 0x84EE

  GL_TEXTURE_COMPRESSION_HINT: GLenum
  GL_TEXTURE_COMPRESSION_HINT = 0x84EF

  GL_TEXTURE_COMPRESSED_IMAGE_SIZE: GLenum
  GL_TEXTURE_COMPRESSED_IMAGE_SIZE = 0x86A0

  GL_TEXTURE_COMPRESSED    : GLenum
  GL_TEXTURE_COMPRESSED     = 0x86A1

  GL_NUM_COMPRESSED_TEXTURE_FORMATS: GLenum
  GL_NUM_COMPRESSED_TEXTURE_FORMATS = 0x86A2

  GL_COMPRESSED_TEXTURE_FORMATS: GLenum
  GL_COMPRESSED_TEXTURE_FORMATS = 0x86A3

  GL_CLAMP_TO_BORDER       : GLenum
  GL_CLAMP_TO_BORDER        = 0x812D

  GL_BLEND_DST_RGB         : GLenum
  GL_BLEND_DST_RGB          = 0x80C8

  GL_BLEND_SRC_RGB         : GLenum
  GL_BLEND_SRC_RGB          = 0x80C9

  GL_BLEND_DST_ALPHA       : GLenum
  GL_BLEND_DST_ALPHA        = 0x80CA

  GL_BLEND_SRC_ALPHA       : GLenum
  GL_BLEND_SRC_ALPHA        = 0x80CB

  GL_POINT_FADE_THRESHOLD_SIZE: GLenum
  GL_POINT_FADE_THRESHOLD_SIZE = 0x8128

  GL_DEPTH_COMPONENT16     : GLenum
  GL_DEPTH_COMPONENT16      = 0x81A5

  GL_DEPTH_COMPONENT24     : GLenum
  GL_DEPTH_COMPONENT24      = 0x81A6

  GL_DEPTH_COMPONENT32     : GLenum
  GL_DEPTH_COMPONENT32      = 0x81A7

  GL_MIRRORED_REPEAT       : GLenum
  GL_MIRRORED_REPEAT        = 0x8370

  GL_MAX_TEXTURE_LOD_BIAS  : GLenum
  GL_MAX_TEXTURE_LOD_BIAS   = 0x84FD

  GL_TEXTURE_LOD_BIAS      : GLenum
  GL_TEXTURE_LOD_BIAS       = 0x8501

  GL_INCR_WRAP             : GLenum
  GL_INCR_WRAP              = 0x8507

  GL_DECR_WRAP             : GLenum
  GL_DECR_WRAP              = 0x8508

  GL_TEXTURE_DEPTH_SIZE    : GLenum
  GL_TEXTURE_DEPTH_SIZE     = 0x884A

  GL_TEXTURE_COMPARE_MODE  : GLenum
  GL_TEXTURE_COMPARE_MODE   = 0x884C

  GL_TEXTURE_COMPARE_FUNC  : GLenum
  GL_TEXTURE_COMPARE_FUNC   = 0x884D

  GL_FUNC_ADD              : GLenum
  GL_FUNC_ADD               = 0x8006

  GL_FUNC_SUBTRACT         : GLenum
  GL_FUNC_SUBTRACT          = 0x800A

  GL_FUNC_REVERSE_SUBTRACT : GLenum
  GL_FUNC_REVERSE_SUBTRACT  = 0x800B

  GL_MIN                   : GLenum
  GL_MIN                    = 0x8007

  GL_MAX                   : GLenum
  GL_MAX                    = 0x8008

  GL_CONSTANT_COLOR        : GLenum
  GL_CONSTANT_COLOR         = 0x8001

  GL_ONE_MINUS_CONSTANT_COLOR: GLenum
  GL_ONE_MINUS_CONSTANT_COLOR = 0x8002

  GL_CONSTANT_ALPHA        : GLenum
  GL_CONSTANT_ALPHA         = 0x8003

  GL_ONE_MINUS_CONSTANT_ALPHA: GLenum
  GL_ONE_MINUS_CONSTANT_ALPHA = 0x8004

  GL_BUFFER_SIZE           : GLenum
  GL_BUFFER_SIZE            = 0x8764

  GL_BUFFER_USAGE          : GLenum
  GL_BUFFER_USAGE           = 0x8765

  GL_QUERY_COUNTER_BITS    : GLenum
  GL_QUERY_COUNTER_BITS     = 0x8864

  GL_CURRENT_QUERY         : GLenum
  GL_CURRENT_QUERY          = 0x8865

  GL_QUERY_RESULT          : GLenum
  GL_QUERY_RESULT           = 0x8866

  GL_QUERY_RESULT_AVAILABLE: GLenum
  GL_QUERY_RESULT_AVAILABLE = 0x8867

  GL_ARRAY_BUFFER          : GLenum
  GL_ARRAY_BUFFER           = 0x8892

  GL_ELEMENT_ARRAY_BUFFER  : GLenum
  GL_ELEMENT_ARRAY_BUFFER   = 0x8893

  GL_ARRAY_BUFFER_BINDING  : GLenum
  GL_ARRAY_BUFFER_BINDING   = 0x8894

  GL_ELEMENT_ARRAY_BUFFER_BINDING: GLenum
  GL_ELEMENT_ARRAY_BUFFER_BINDING = 0x8895

  GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING: GLenum
  GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = 0x889F

  GL_READ_ONLY             : GLenum
  GL_READ_ONLY              = 0x88B8

  GL_WRITE_ONLY            : GLenum
  GL_WRITE_ONLY             = 0x88B9

  GL_READ_WRITE            : GLenum
  GL_READ_WRITE             = 0x88BA

  GL_BUFFER_ACCESS         : GLenum
  GL_BUFFER_ACCESS          = 0x88BB

  GL_BUFFER_MAPPED         : GLenum
  GL_BUFFER_MAPPED          = 0x88BC

  GL_BUFFER_MAP_POINTER    : GLenum
  GL_BUFFER_MAP_POINTER     = 0x88BD

  GL_STREAM_DRAW           : GLenum
  GL_STREAM_DRAW            = 0x88E0

  GL_STREAM_READ           : GLenum
  GL_STREAM_READ            = 0x88E1

  GL_STREAM_COPY           : GLenum
  GL_STREAM_COPY            = 0x88E2

  GL_STATIC_DRAW           : GLenum
  GL_STATIC_DRAW            = 0x88E4

  GL_STATIC_READ           : GLenum
  GL_STATIC_READ            = 0x88E5

  GL_STATIC_COPY           : GLenum
  GL_STATIC_COPY            = 0x88E6

  GL_DYNAMIC_DRAW          : GLenum
  GL_DYNAMIC_DRAW           = 0x88E8

  GL_DYNAMIC_READ          : GLenum
  GL_DYNAMIC_READ           = 0x88E9

  GL_DYNAMIC_COPY          : GLenum
  GL_DYNAMIC_COPY           = 0x88EA

  GL_SAMPLES_PASSED        : GLenum
  GL_SAMPLES_PASSED         = 0x8914

  GL_SRC1_ALPHA            : GLenum
  GL_SRC1_ALPHA             = 0x8589

  GL_BLEND_EQUATION_RGB    : GLenum
  GL_BLEND_EQUATION_RGB     = 0x8009

  GL_VERTEX_ATTRIB_ARRAY_ENABLED: GLenum
  GL_VERTEX_ATTRIB_ARRAY_ENABLED = 0x8622

  GL_VERTEX_ATTRIB_ARRAY_SIZE: GLenum
  GL_VERTEX_ATTRIB_ARRAY_SIZE = 0x8623

  GL_VERTEX_ATTRIB_ARRAY_STRIDE: GLenum
  GL_VERTEX_ATTRIB_ARRAY_STRIDE = 0x8624

  GL_VERTEX_ATTRIB_ARRAY_TYPE: GLenum
  GL_VERTEX_ATTRIB_ARRAY_TYPE = 0x8625

  GL_CURRENT_VERTEX_ATTRIB : GLenum
  GL_CURRENT_VERTEX_ATTRIB  = 0x8626

  GL_VERTEX_PROGRAM_POINT_SIZE: GLenum
  GL_VERTEX_PROGRAM_POINT_SIZE = 0x8642

  GL_VERTEX_ATTRIB_ARRAY_POINTER: GLenum
  GL_VERTEX_ATTRIB_ARRAY_POINTER = 0x8645

  GL_STENCIL_BACK_FUNC     : GLenum
  GL_STENCIL_BACK_FUNC      = 0x8800

  GL_STENCIL_BACK_FAIL     : GLenum
  GL_STENCIL_BACK_FAIL      = 0x8801

  GL_STENCIL_BACK_PASS_DEPTH_FAIL: GLenum
  GL_STENCIL_BACK_PASS_DEPTH_FAIL = 0x8802

  GL_STENCIL_BACK_PASS_DEPTH_PASS: GLenum
  GL_STENCIL_BACK_PASS_DEPTH_PASS = 0x8803

  GL_MAX_DRAW_BUFFERS      : GLenum
  GL_MAX_DRAW_BUFFERS       = 0x8824

  GL_DRAW_BUFFER0          : GLenum
  GL_DRAW_BUFFER0           = 0x8825

  GL_DRAW_BUFFER1          : GLenum
  GL_DRAW_BUFFER1           = 0x8826

  GL_DRAW_BUFFER2          : GLenum
  GL_DRAW_BUFFER2           = 0x8827

  GL_DRAW_BUFFER3          : GLenum
  GL_DRAW_BUFFER3           = 0x8828

  GL_DRAW_BUFFER4          : GLenum
  GL_DRAW_BUFFER4           = 0x8829

  GL_DRAW_BUFFER5          : GLenum
  GL_DRAW_BUFFER5           = 0x882A

  GL_DRAW_BUFFER6          : GLenum
  GL_DRAW_BUFFER6           = 0x882B

  GL_DRAW_BUFFER7          : GLenum
  GL_DRAW_BUFFER7           = 0x882C

  GL_DRAW_BUFFER8          : GLenum
  GL_DRAW_BUFFER8           = 0x882D

  GL_DRAW_BUFFER9          : GLenum
  GL_DRAW_BUFFER9           = 0x882E

  GL_DRAW_BUFFER10         : GLenum
  GL_DRAW_BUFFER10          = 0x882F

  GL_DRAW_BUFFER11         : GLenum
  GL_DRAW_BUFFER11          = 0x8830

  GL_DRAW_BUFFER12         : GLenum
  GL_DRAW_BUFFER12          = 0x8831

  GL_DRAW_BUFFER13         : GLenum
  GL_DRAW_BUFFER13          = 0x8832

  GL_DRAW_BUFFER14         : GLenum
  GL_DRAW_BUFFER14          = 0x8833

  GL_DRAW_BUFFER15         : GLenum
  GL_DRAW_BUFFER15          = 0x8834

  GL_BLEND_EQUATION_ALPHA  : GLenum
  GL_BLEND_EQUATION_ALPHA   = 0x883D

  GL_MAX_VERTEX_ATTRIBS    : GLenum
  GL_MAX_VERTEX_ATTRIBS     = 0x8869

  GL_VERTEX_ATTRIB_ARRAY_NORMALIZED: GLenum
  GL_VERTEX_ATTRIB_ARRAY_NORMALIZED = 0x886A

  GL_MAX_TEXTURE_IMAGE_UNITS: GLenum
  GL_MAX_TEXTURE_IMAGE_UNITS = 0x8872

  GL_FRAGMENT_SHADER       : GLenum
  GL_FRAGMENT_SHADER        = 0x8B30

  GL_VERTEX_SHADER         : GLenum
  GL_VERTEX_SHADER          = 0x8B31

  GL_MAX_FRAGMENT_UNIFORM_COMPONENTS: GLenum
  GL_MAX_FRAGMENT_UNIFORM_COMPONENTS = 0x8B49

  GL_MAX_VERTEX_UNIFORM_COMPONENTS: GLenum
  GL_MAX_VERTEX_UNIFORM_COMPONENTS = 0x8B4A

  GL_MAX_VARYING_FLOATS    : GLenum
  GL_MAX_VARYING_FLOATS     = 0x8B4B

  GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS: GLenum
  GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS = 0x8B4C

  GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS: GLenum
  GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS = 0x8B4D

  GL_SHADER_TYPE           : GLenum
  GL_SHADER_TYPE            = 0x8B4F

  GL_FLOAT_VEC2            : GLenum
  GL_FLOAT_VEC2             = 0x8B50

  GL_FLOAT_VEC3            : GLenum
  GL_FLOAT_VEC3             = 0x8B51

  GL_FLOAT_VEC4            : GLenum
  GL_FLOAT_VEC4             = 0x8B52

  GL_INT_VEC2              : GLenum
  GL_INT_VEC2               = 0x8B53

  GL_INT_VEC3              : GLenum
  GL_INT_VEC3               = 0x8B54

  GL_INT_VEC4              : GLenum
  GL_INT_VEC4               = 0x8B55

  GL_BOOL                  : GLenum
  GL_BOOL                   = 0x8B56

  GL_BOOL_VEC2             : GLenum
  GL_BOOL_VEC2              = 0x8B57

  GL_BOOL_VEC3             : GLenum
  GL_BOOL_VEC3              = 0x8B58

  GL_BOOL_VEC4             : GLenum
  GL_BOOL_VEC4              = 0x8B59

  GL_FLOAT_MAT2            : GLenum
  GL_FLOAT_MAT2             = 0x8B5A

  GL_FLOAT_MAT3            : GLenum
  GL_FLOAT_MAT3             = 0x8B5B

  GL_FLOAT_MAT4            : GLenum
  GL_FLOAT_MAT4             = 0x8B5C

  GL_SAMPLER_1D            : GLenum
  GL_SAMPLER_1D             = 0x8B5D

  GL_SAMPLER_2D            : GLenum
  GL_SAMPLER_2D             = 0x8B5E

  GL_SAMPLER_3D            : GLenum
  GL_SAMPLER_3D             = 0x8B5F

  GL_SAMPLER_CUBE          : GLenum
  GL_SAMPLER_CUBE           = 0x8B60

  GL_SAMPLER_1D_SHADOW     : GLenum
  GL_SAMPLER_1D_SHADOW      = 0x8B61

  GL_SAMPLER_2D_SHADOW     : GLenum
  GL_SAMPLER_2D_SHADOW      = 0x8B62

  GL_DELETE_STATUS         : GLenum
  GL_DELETE_STATUS          = 0x8B80

  GL_COMPILE_STATUS        : GLenum
  GL_COMPILE_STATUS         = 0x8B81

  GL_LINK_STATUS           : GLenum
  GL_LINK_STATUS            = 0x8B82

  GL_VALIDATE_STATUS       : GLenum
  GL_VALIDATE_STATUS        = 0x8B83

  GL_INFO_LOG_LENGTH       : GLenum
  GL_INFO_LOG_LENGTH        = 0x8B84

  GL_ATTACHED_SHADERS      : GLenum
  GL_ATTACHED_SHADERS       = 0x8B85

  GL_ACTIVE_UNIFORMS       : GLenum
  GL_ACTIVE_UNIFORMS        = 0x8B86

  GL_ACTIVE_UNIFORM_MAX_LENGTH: GLenum
  GL_ACTIVE_UNIFORM_MAX_LENGTH = 0x8B87

  GL_SHADER_SOURCE_LENGTH  : GLenum
  GL_SHADER_SOURCE_LENGTH   = 0x8B88

  GL_ACTIVE_ATTRIBUTES     : GLenum
  GL_ACTIVE_ATTRIBUTES      = 0x8B89

  GL_ACTIVE_ATTRIBUTE_MAX_LENGTH: GLenum
  GL_ACTIVE_ATTRIBUTE_MAX_LENGTH = 0x8B8A

  GL_FRAGMENT_SHADER_DERIVATIVE_HINT: GLenum
  GL_FRAGMENT_SHADER_DERIVATIVE_HINT = 0x8B8B

  GL_SHADING_LANGUAGE_VERSION: GLenum
  GL_SHADING_LANGUAGE_VERSION = 0x8B8C

  GL_CURRENT_PROGRAM       : GLenum
  GL_CURRENT_PROGRAM        = 0x8B8D

  GL_POINT_SPRITE_COORD_ORIGIN: GLenum
  GL_POINT_SPRITE_COORD_ORIGIN = 0x8CA0

  GL_LOWER_LEFT            : GLenum
  GL_LOWER_LEFT             = 0x8CA1

  GL_UPPER_LEFT            : GLenum
  GL_UPPER_LEFT             = 0x8CA2

  GL_STENCIL_BACK_REF      : GLenum
  GL_STENCIL_BACK_REF       = 0x8CA3

  GL_STENCIL_BACK_VALUE_MASK: GLenum
  GL_STENCIL_BACK_VALUE_MASK = 0x8CA4

  GL_STENCIL_BACK_WRITEMASK: GLenum
  GL_STENCIL_BACK_WRITEMASK = 0x8CA5

  GL_PIXEL_PACK_BUFFER     : GLenum
  GL_PIXEL_PACK_BUFFER      = 0x88EB

  GL_PIXEL_UNPACK_BUFFER   : GLenum
  GL_PIXEL_UNPACK_BUFFER    = 0x88EC

  GL_PIXEL_PACK_BUFFER_BINDING: GLenum
  GL_PIXEL_PACK_BUFFER_BINDING = 0x88ED

  GL_PIXEL_UNPACK_BUFFER_BINDING: GLenum
  GL_PIXEL_UNPACK_BUFFER_BINDING = 0x88EF

  GL_FLOAT_MAT2x3          : GLenum
  GL_FLOAT_MAT2x3           = 0x8B65

  GL_FLOAT_MAT2x4          : GLenum
  GL_FLOAT_MAT2x4           = 0x8B66

  GL_FLOAT_MAT3x2          : GLenum
  GL_FLOAT_MAT3x2           = 0x8B67

  GL_FLOAT_MAT3x4          : GLenum
  GL_FLOAT_MAT3x4           = 0x8B68

  GL_FLOAT_MAT4x2          : GLenum
  GL_FLOAT_MAT4x2           = 0x8B69

  GL_FLOAT_MAT4x3          : GLenum
  GL_FLOAT_MAT4x3           = 0x8B6A

  GL_SRGB                  : GLenum
  GL_SRGB                   = 0x8C40

  GL_SRGB8                 : GLenum
  GL_SRGB8                  = 0x8C41

  GL_SRGB_ALPHA            : GLenum
  GL_SRGB_ALPHA             = 0x8C42

  GL_SRGB8_ALPHA8          : GLenum
  GL_SRGB8_ALPHA8           = 0x8C43

  GL_COMPRESSED_SRGB       : GLenum
  GL_COMPRESSED_SRGB        = 0x8C48

  GL_COMPRESSED_SRGB_ALPHA : GLenum
  GL_COMPRESSED_SRGB_ALPHA  = 0x8C49

  GL_COMPARE_REF_TO_TEXTURE: GLenum
  GL_COMPARE_REF_TO_TEXTURE = 0x884E

  GL_CLIP_DISTANCE0        : GLenum
  GL_CLIP_DISTANCE0         = 0x3000

  GL_CLIP_DISTANCE1        : GLenum
  GL_CLIP_DISTANCE1         = 0x3001

  GL_CLIP_DISTANCE2        : GLenum
  GL_CLIP_DISTANCE2         = 0x3002

  GL_CLIP_DISTANCE3        : GLenum
  GL_CLIP_DISTANCE3         = 0x3003

  GL_CLIP_DISTANCE4        : GLenum
  GL_CLIP_DISTANCE4         = 0x3004

  GL_CLIP_DISTANCE5        : GLenum
  GL_CLIP_DISTANCE5         = 0x3005

  GL_CLIP_DISTANCE6        : GLenum
  GL_CLIP_DISTANCE6         = 0x3006

  GL_CLIP_DISTANCE7        : GLenum
  GL_CLIP_DISTANCE7         = 0x3007

  GL_MAX_CLIP_DISTANCES    : GLenum
  GL_MAX_CLIP_DISTANCES     = 0x0D32

  GL_MAJOR_VERSION         : GLenum
  GL_MAJOR_VERSION          = 0x821B

  GL_MINOR_VERSION         : GLenum
  GL_MINOR_VERSION          = 0x821C

  GL_NUM_EXTENSIONS        : GLenum
  GL_NUM_EXTENSIONS         = 0x821D

  GL_CONTEXT_FLAGS         : GLenum
  GL_CONTEXT_FLAGS          = 0x821E

  GL_COMPRESSED_RED        : GLenum
  GL_COMPRESSED_RED         = 0x8225

  GL_COMPRESSED_RG         : GLenum
  GL_COMPRESSED_RG          = 0x8226

  GL_CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT: GLenum
  GL_CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT = 0x00000001

  GL_RGBA32F               : GLenum
  GL_RGBA32F                = 0x8814

  GL_RGB32F                : GLenum
  GL_RGB32F                 = 0x8815

  GL_RGBA16F               : GLenum
  GL_RGBA16F                = 0x881A

  GL_RGB16F                : GLenum
  GL_RGB16F                 = 0x881B

  GL_VERTEX_ATTRIB_ARRAY_INTEGER: GLenum
  GL_VERTEX_ATTRIB_ARRAY_INTEGER = 0x88FD

  GL_MAX_ARRAY_TEXTURE_LAYERS: GLenum
  GL_MAX_ARRAY_TEXTURE_LAYERS = 0x88FF

  GL_MIN_PROGRAM_TEXEL_OFFSET: GLenum
  GL_MIN_PROGRAM_TEXEL_OFFSET = 0x8904

  GL_MAX_PROGRAM_TEXEL_OFFSET: GLenum
  GL_MAX_PROGRAM_TEXEL_OFFSET = 0x8905

  GL_CLAMP_READ_COLOR      : GLenum
  GL_CLAMP_READ_COLOR       = 0x891C

  GL_FIXED_ONLY            : GLenum
  GL_FIXED_ONLY             = 0x891D

  GL_MAX_VARYING_COMPONENTS: GLenum
  GL_MAX_VARYING_COMPONENTS = 0x8B4B

  GL_TEXTURE_1D_ARRAY      : GLenum
  GL_TEXTURE_1D_ARRAY       = 0x8C18

  GL_PROXY_TEXTURE_1D_ARRAY: GLenum
  GL_PROXY_TEXTURE_1D_ARRAY = 0x8C19

  GL_TEXTURE_2D_ARRAY      : GLenum
  GL_TEXTURE_2D_ARRAY       = 0x8C1A

  GL_PROXY_TEXTURE_2D_ARRAY: GLenum
  GL_PROXY_TEXTURE_2D_ARRAY = 0x8C1B

  GL_TEXTURE_BINDING_1D_ARRAY: GLenum
  GL_TEXTURE_BINDING_1D_ARRAY = 0x8C1C

  GL_TEXTURE_BINDING_2D_ARRAY: GLenum
  GL_TEXTURE_BINDING_2D_ARRAY = 0x8C1D

  GL_R11F_G11F_B10F        : GLenum
  GL_R11F_G11F_B10F         = 0x8C3A

  GL_UNSIGNED_INT_10F_11F_11F_REV: GLenum
  GL_UNSIGNED_INT_10F_11F_11F_REV = 0x8C3B

  GL_RGB9_E5               : GLenum
  GL_RGB9_E5                = 0x8C3D

  GL_UNSIGNED_INT_5_9_9_9_REV: GLenum
  GL_UNSIGNED_INT_5_9_9_9_REV = 0x8C3E

  GL_TEXTURE_SHARED_SIZE   : GLenum
  GL_TEXTURE_SHARED_SIZE    = 0x8C3F

  GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH: GLenum
  GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH = 0x8C76

  GL_TRANSFORM_FEEDBACK_BUFFER_MODE: GLenum
  GL_TRANSFORM_FEEDBACK_BUFFER_MODE = 0x8C7F

  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS: GLenum
  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS = 0x8C80

  GL_TRANSFORM_FEEDBACK_VARYINGS: GLenum
  GL_TRANSFORM_FEEDBACK_VARYINGS = 0x8C83

  GL_TRANSFORM_FEEDBACK_BUFFER_START: GLenum
  GL_TRANSFORM_FEEDBACK_BUFFER_START = 0x8C84

  GL_TRANSFORM_FEEDBACK_BUFFER_SIZE: GLenum
  GL_TRANSFORM_FEEDBACK_BUFFER_SIZE = 0x8C85

  GL_PRIMITIVES_GENERATED  : GLenum
  GL_PRIMITIVES_GENERATED   = 0x8C87

  GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN: GLenum
  GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN = 0x8C88

  GL_RASTERIZER_DISCARD    : GLenum
  GL_RASTERIZER_DISCARD     = 0x8C89

  GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS: GLenum
  GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS = 0x8C8A

  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS: GLenum
  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS = 0x8C8B

  GL_INTERLEAVED_ATTRIBS   : GLenum
  GL_INTERLEAVED_ATTRIBS    = 0x8C8C

  GL_SEPARATE_ATTRIBS      : GLenum
  GL_SEPARATE_ATTRIBS       = 0x8C8D

  GL_TRANSFORM_FEEDBACK_BUFFER: GLenum
  GL_TRANSFORM_FEEDBACK_BUFFER = 0x8C8E

  GL_TRANSFORM_FEEDBACK_BUFFER_BINDING: GLenum
  GL_TRANSFORM_FEEDBACK_BUFFER_BINDING = 0x8C8F

  GL_RGBA32UI              : GLenum
  GL_RGBA32UI               = 0x8D70

  GL_RGB32UI               : GLenum
  GL_RGB32UI                = 0x8D71

  GL_RGBA16UI              : GLenum
  GL_RGBA16UI               = 0x8D76

  GL_RGB16UI               : GLenum
  GL_RGB16UI                = 0x8D77

  GL_RGBA8UI               : GLenum
  GL_RGBA8UI                = 0x8D7C

  GL_RGB8UI                : GLenum
  GL_RGB8UI                 = 0x8D7D

  GL_RGBA32I               : GLenum
  GL_RGBA32I                = 0x8D82

  GL_RGB32I                : GLenum
  GL_RGB32I                 = 0x8D83

  GL_RGBA16I               : GLenum
  GL_RGBA16I                = 0x8D88

  GL_RGB16I                : GLenum
  GL_RGB16I                 = 0x8D89

  GL_RGBA8I                : GLenum
  GL_RGBA8I                 = 0x8D8E

  GL_RGB8I                 : GLenum
  GL_RGB8I                  = 0x8D8F

  GL_RED_INTEGER           : GLenum
  GL_RED_INTEGER            = 0x8D94

  GL_GREEN_INTEGER         : GLenum
  GL_GREEN_INTEGER          = 0x8D95

  GL_BLUE_INTEGER          : GLenum
  GL_BLUE_INTEGER           = 0x8D96

  GL_RGB_INTEGER           : GLenum
  GL_RGB_INTEGER            = 0x8D98

  GL_RGBA_INTEGER          : GLenum
  GL_RGBA_INTEGER           = 0x8D99

  GL_BGR_INTEGER           : GLenum
  GL_BGR_INTEGER            = 0x8D9A

  GL_BGRA_INTEGER          : GLenum
  GL_BGRA_INTEGER           = 0x8D9B

  GL_SAMPLER_1D_ARRAY      : GLenum
  GL_SAMPLER_1D_ARRAY       = 0x8DC0

  GL_SAMPLER_2D_ARRAY      : GLenum
  GL_SAMPLER_2D_ARRAY       = 0x8DC1

  GL_SAMPLER_1D_ARRAY_SHADOW: GLenum
  GL_SAMPLER_1D_ARRAY_SHADOW = 0x8DC3

  GL_SAMPLER_2D_ARRAY_SHADOW: GLenum
  GL_SAMPLER_2D_ARRAY_SHADOW = 0x8DC4

  GL_SAMPLER_CUBE_SHADOW   : GLenum
  GL_SAMPLER_CUBE_SHADOW    = 0x8DC5

  GL_UNSIGNED_INT_VEC2     : GLenum
  GL_UNSIGNED_INT_VEC2      = 0x8DC6

  GL_UNSIGNED_INT_VEC3     : GLenum
  GL_UNSIGNED_INT_VEC3      = 0x8DC7

  GL_UNSIGNED_INT_VEC4     : GLenum
  GL_UNSIGNED_INT_VEC4      = 0x8DC8

  GL_INT_SAMPLER_1D        : GLenum
  GL_INT_SAMPLER_1D         = 0x8DC9

  GL_INT_SAMPLER_2D        : GLenum
  GL_INT_SAMPLER_2D         = 0x8DCA

  GL_INT_SAMPLER_3D        : GLenum
  GL_INT_SAMPLER_3D         = 0x8DCB

  GL_INT_SAMPLER_CUBE      : GLenum
  GL_INT_SAMPLER_CUBE       = 0x8DCC

  GL_INT_SAMPLER_1D_ARRAY  : GLenum
  GL_INT_SAMPLER_1D_ARRAY   = 0x8DCE

  GL_INT_SAMPLER_2D_ARRAY  : GLenum
  GL_INT_SAMPLER_2D_ARRAY   = 0x8DCF

  GL_UNSIGNED_INT_SAMPLER_1D: GLenum
  GL_UNSIGNED_INT_SAMPLER_1D = 0x8DD1

  GL_UNSIGNED_INT_SAMPLER_2D: GLenum
  GL_UNSIGNED_INT_SAMPLER_2D = 0x8DD2

  GL_UNSIGNED_INT_SAMPLER_3D: GLenum
  GL_UNSIGNED_INT_SAMPLER_3D = 0x8DD3

  GL_UNSIGNED_INT_SAMPLER_CUBE: GLenum
  GL_UNSIGNED_INT_SAMPLER_CUBE = 0x8DD4

  GL_UNSIGNED_INT_SAMPLER_1D_ARRAY: GLenum
  GL_UNSIGNED_INT_SAMPLER_1D_ARRAY = 0x8DD6

  GL_UNSIGNED_INT_SAMPLER_2D_ARRAY: GLenum
  GL_UNSIGNED_INT_SAMPLER_2D_ARRAY = 0x8DD7

  GL_QUERY_WAIT            : GLenum
  GL_QUERY_WAIT             = 0x8E13

  GL_QUERY_NO_WAIT         : GLenum
  GL_QUERY_NO_WAIT          = 0x8E14

  GL_QUERY_BY_REGION_WAIT  : GLenum
  GL_QUERY_BY_REGION_WAIT   = 0x8E15

  GL_QUERY_BY_REGION_NO_WAIT: GLenum
  GL_QUERY_BY_REGION_NO_WAIT = 0x8E16

  GL_BUFFER_ACCESS_FLAGS   : GLenum
  GL_BUFFER_ACCESS_FLAGS    = 0x911F

  GL_BUFFER_MAP_LENGTH     : GLenum
  GL_BUFFER_MAP_LENGTH      = 0x9120

  GL_BUFFER_MAP_OFFSET     : GLenum
  GL_BUFFER_MAP_OFFSET      = 0x9121

  GL_DEPTH_COMPONENT32F    : GLenum
  GL_DEPTH_COMPONENT32F     = 0x8CAC

  GL_DEPTH32F_STENCIL8     : GLenum
  GL_DEPTH32F_STENCIL8      = 0x8CAD

  GL_FLOAT_32_UNSIGNED_INT_24_8_REV: GLenum
  GL_FLOAT_32_UNSIGNED_INT_24_8_REV = 0x8DAD

  GL_INVALID_FRAMEBUFFER_OPERATION: GLenum
  GL_INVALID_FRAMEBUFFER_OPERATION = 0x0506

  GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING: GLenum
  GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING = 0x8210

  GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE: GLenum
  GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE = 0x8211

  GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE: GLenum
  GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE = 0x8212

  GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE: GLenum
  GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE = 0x8213

  GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE: GLenum
  GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE = 0x8214

  GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE: GLenum
  GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE = 0x8215

  GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE: GLenum
  GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE = 0x8216

  GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE: GLenum
  GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE = 0x8217

  GL_FRAMEBUFFER_DEFAULT   : GLenum
  GL_FRAMEBUFFER_DEFAULT    = 0x8218

  GL_FRAMEBUFFER_UNDEFINED : GLenum
  GL_FRAMEBUFFER_UNDEFINED  = 0x8219

  GL_DEPTH_STENCIL_ATTACHMENT: GLenum
  GL_DEPTH_STENCIL_ATTACHMENT = 0x821A

  GL_MAX_RENDERBUFFER_SIZE : GLenum
  GL_MAX_RENDERBUFFER_SIZE  = 0x84E8

  GL_DEPTH_STENCIL         : GLenum
  GL_DEPTH_STENCIL          = 0x84F9

  GL_UNSIGNED_INT_24_8     : GLenum
  GL_UNSIGNED_INT_24_8      = 0x84FA

  GL_DEPTH24_STENCIL8      : GLenum
  GL_DEPTH24_STENCIL8       = 0x88F0

  GL_TEXTURE_STENCIL_SIZE  : GLenum
  GL_TEXTURE_STENCIL_SIZE   = 0x88F1

  GL_TEXTURE_RED_TYPE      : GLenum
  GL_TEXTURE_RED_TYPE       = 0x8C10

  GL_TEXTURE_GREEN_TYPE    : GLenum
  GL_TEXTURE_GREEN_TYPE     = 0x8C11

  GL_TEXTURE_BLUE_TYPE     : GLenum
  GL_TEXTURE_BLUE_TYPE      = 0x8C12

  GL_TEXTURE_ALPHA_TYPE    : GLenum
  GL_TEXTURE_ALPHA_TYPE     = 0x8C13

  GL_TEXTURE_DEPTH_TYPE    : GLenum
  GL_TEXTURE_DEPTH_TYPE     = 0x8C16

  GL_UNSIGNED_NORMALIZED   : GLenum
  GL_UNSIGNED_NORMALIZED    = 0x8C17

  GL_FRAMEBUFFER_BINDING   : GLenum
  GL_FRAMEBUFFER_BINDING    = 0x8CA6

  GL_DRAW_FRAMEBUFFER_BINDING: GLenum
  GL_DRAW_FRAMEBUFFER_BINDING = 0x8CA6

  GL_RENDERBUFFER_BINDING  : GLenum
  GL_RENDERBUFFER_BINDING   = 0x8CA7

  GL_READ_FRAMEBUFFER      : GLenum
  GL_READ_FRAMEBUFFER       = 0x8CA8

  GL_DRAW_FRAMEBUFFER      : GLenum
  GL_DRAW_FRAMEBUFFER       = 0x8CA9

  GL_READ_FRAMEBUFFER_BINDING: GLenum
  GL_READ_FRAMEBUFFER_BINDING = 0x8CAA

  GL_RENDERBUFFER_SAMPLES  : GLenum
  GL_RENDERBUFFER_SAMPLES   = 0x8CAB

  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE: GLenum
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE = 0x8CD0

  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME: GLenum
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME = 0x8CD1

  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL: GLenum
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL = 0x8CD2

  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE: GLenum
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE = 0x8CD3

  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER: GLenum
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER = 0x8CD4

  GL_FRAMEBUFFER_COMPLETE  : GLenum
  GL_FRAMEBUFFER_COMPLETE   = 0x8CD5

  GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT: GLenum
  GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT = 0x8CD6

  GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT: GLenum
  GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT = 0x8CD7

  GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER: GLenum
  GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER = 0x8CDB

  GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER: GLenum
  GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER = 0x8CDC

  GL_FRAMEBUFFER_UNSUPPORTED: GLenum
  GL_FRAMEBUFFER_UNSUPPORTED = 0x8CDD

  GL_MAX_COLOR_ATTACHMENTS : GLenum
  GL_MAX_COLOR_ATTACHMENTS  = 0x8CDF

  GL_COLOR_ATTACHMENT0     : GLenum
  GL_COLOR_ATTACHMENT0      = 0x8CE0

  GL_COLOR_ATTACHMENT1     : GLenum
  GL_COLOR_ATTACHMENT1      = 0x8CE1

  GL_COLOR_ATTACHMENT2     : GLenum
  GL_COLOR_ATTACHMENT2      = 0x8CE2

  GL_COLOR_ATTACHMENT3     : GLenum
  GL_COLOR_ATTACHMENT3      = 0x8CE3

  GL_COLOR_ATTACHMENT4     : GLenum
  GL_COLOR_ATTACHMENT4      = 0x8CE4

  GL_COLOR_ATTACHMENT5     : GLenum
  GL_COLOR_ATTACHMENT5      = 0x8CE5

  GL_COLOR_ATTACHMENT6     : GLenum
  GL_COLOR_ATTACHMENT6      = 0x8CE6

  GL_COLOR_ATTACHMENT7     : GLenum
  GL_COLOR_ATTACHMENT7      = 0x8CE7

  GL_COLOR_ATTACHMENT8     : GLenum
  GL_COLOR_ATTACHMENT8      = 0x8CE8

  GL_COLOR_ATTACHMENT9     : GLenum
  GL_COLOR_ATTACHMENT9      = 0x8CE9

  GL_COLOR_ATTACHMENT10    : GLenum
  GL_COLOR_ATTACHMENT10     = 0x8CEA

  GL_COLOR_ATTACHMENT11    : GLenum
  GL_COLOR_ATTACHMENT11     = 0x8CEB

  GL_COLOR_ATTACHMENT12    : GLenum
  GL_COLOR_ATTACHMENT12     = 0x8CEC

  GL_COLOR_ATTACHMENT13    : GLenum
  GL_COLOR_ATTACHMENT13     = 0x8CED

  GL_COLOR_ATTACHMENT14    : GLenum
  GL_COLOR_ATTACHMENT14     = 0x8CEE

  GL_COLOR_ATTACHMENT15    : GLenum
  GL_COLOR_ATTACHMENT15     = 0x8CEF

  GL_DEPTH_ATTACHMENT      : GLenum
  GL_DEPTH_ATTACHMENT       = 0x8D00

  GL_STENCIL_ATTACHMENT    : GLenum
  GL_STENCIL_ATTACHMENT     = 0x8D20

  GL_FRAMEBUFFER           : GLenum
  GL_FRAMEBUFFER            = 0x8D40

  GL_RENDERBUFFER          : GLenum
  GL_RENDERBUFFER           = 0x8D41

  GL_RENDERBUFFER_WIDTH    : GLenum
  GL_RENDERBUFFER_WIDTH     = 0x8D42

  GL_RENDERBUFFER_HEIGHT   : GLenum
  GL_RENDERBUFFER_HEIGHT    = 0x8D43

  GL_RENDERBUFFER_INTERNAL_FORMAT: GLenum
  GL_RENDERBUFFER_INTERNAL_FORMAT = 0x8D44

  GL_STENCIL_INDEX1        : GLenum
  GL_STENCIL_INDEX1         = 0x8D46

  GL_STENCIL_INDEX4        : GLenum
  GL_STENCIL_INDEX4         = 0x8D47

  GL_STENCIL_INDEX8        : GLenum
  GL_STENCIL_INDEX8         = 0x8D48

  GL_STENCIL_INDEX16       : GLenum
  GL_STENCIL_INDEX16        = 0x8D49

  GL_RENDERBUFFER_RED_SIZE : GLenum
  GL_RENDERBUFFER_RED_SIZE  = 0x8D50

  GL_RENDERBUFFER_GREEN_SIZE: GLenum
  GL_RENDERBUFFER_GREEN_SIZE = 0x8D51

  GL_RENDERBUFFER_BLUE_SIZE: GLenum
  GL_RENDERBUFFER_BLUE_SIZE = 0x8D52

  GL_RENDERBUFFER_ALPHA_SIZE: GLenum
  GL_RENDERBUFFER_ALPHA_SIZE = 0x8D53

  GL_RENDERBUFFER_DEPTH_SIZE: GLenum
  GL_RENDERBUFFER_DEPTH_SIZE = 0x8D54

  GL_RENDERBUFFER_STENCIL_SIZE: GLenum
  GL_RENDERBUFFER_STENCIL_SIZE = 0x8D55

  GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE: GLenum
  GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE = 0x8D56

  GL_MAX_SAMPLES           : GLenum
  GL_MAX_SAMPLES            = 0x8D57

  GL_FRAMEBUFFER_SRGB      : GLenum
  GL_FRAMEBUFFER_SRGB       = 0x8DB9

  GL_HALF_FLOAT            : GLenum
  GL_HALF_FLOAT             = 0x140B

  GL_MAP_READ_BIT          : GLenum
  GL_MAP_READ_BIT           = 0x0001

  GL_MAP_WRITE_BIT         : GLenum
  GL_MAP_WRITE_BIT          = 0x0002

  GL_MAP_INVALIDATE_RANGE_BIT: GLenum
  GL_MAP_INVALIDATE_RANGE_BIT = 0x0004

  GL_MAP_INVALIDATE_BUFFER_BIT: GLenum
  GL_MAP_INVALIDATE_BUFFER_BIT = 0x0008

  GL_MAP_FLUSH_EXPLICIT_BIT: GLenum
  GL_MAP_FLUSH_EXPLICIT_BIT = 0x0010

  GL_MAP_UNSYNCHRONIZED_BIT: GLenum
  GL_MAP_UNSYNCHRONIZED_BIT = 0x0020

  GL_COMPRESSED_RED_RGTC1  : GLenum
  GL_COMPRESSED_RED_RGTC1   = 0x8DBB

  GL_COMPRESSED_SIGNED_RED_RGTC1: GLenum
  GL_COMPRESSED_SIGNED_RED_RGTC1 = 0x8DBC

  GL_COMPRESSED_RG_RGTC2   : GLenum
  GL_COMPRESSED_RG_RGTC2    = 0x8DBD

  GL_COMPRESSED_SIGNED_RG_RGTC2: GLenum
  GL_COMPRESSED_SIGNED_RG_RGTC2 = 0x8DBE

  GL_RG                    : GLenum
  GL_RG                     = 0x8227

  GL_RG_INTEGER            : GLenum
  GL_RG_INTEGER             = 0x8228

  GL_R8                    : GLenum
  GL_R8                     = 0x8229

  GL_R16                   : GLenum
  GL_R16                    = 0x822A

  GL_RG8                   : GLenum
  GL_RG8                    = 0x822B

  GL_RG16                  : GLenum
  GL_RG16                   = 0x822C

  GL_R16F                  : GLenum
  GL_R16F                   = 0x822D

  GL_R32F                  : GLenum
  GL_R32F                   = 0x822E

  GL_RG16F                 : GLenum
  GL_RG16F                  = 0x822F

  GL_RG32F                 : GLenum
  GL_RG32F                  = 0x8230

  GL_R8I                   : GLenum
  GL_R8I                    = 0x8231

  GL_R8UI                  : GLenum
  GL_R8UI                   = 0x8232

  GL_R16I                  : GLenum
  GL_R16I                   = 0x8233

  GL_R16UI                 : GLenum
  GL_R16UI                  = 0x8234

  GL_R32I                  : GLenum
  GL_R32I                   = 0x8235

  GL_R32UI                 : GLenum
  GL_R32UI                  = 0x8236

  GL_RG8I                  : GLenum
  GL_RG8I                   = 0x8237

  GL_RG8UI                 : GLenum
  GL_RG8UI                  = 0x8238

  GL_RG16I                 : GLenum
  GL_RG16I                  = 0x8239

  GL_RG16UI                : GLenum
  GL_RG16UI                 = 0x823A

  GL_RG32I                 : GLenum
  GL_RG32I                  = 0x823B

  GL_RG32UI                : GLenum
  GL_RG32UI                 = 0x823C

  GL_VERTEX_ARRAY_BINDING  : GLenum
  GL_VERTEX_ARRAY_BINDING   = 0x85B5

  GL_SAMPLER_2D_RECT       : GLenum
  GL_SAMPLER_2D_RECT        = 0x8B63

  GL_SAMPLER_2D_RECT_SHADOW: GLenum
  GL_SAMPLER_2D_RECT_SHADOW = 0x8B64

  GL_SAMPLER_BUFFER        : GLenum
  GL_SAMPLER_BUFFER         = 0x8DC2

  GL_INT_SAMPLER_2D_RECT   : GLenum
  GL_INT_SAMPLER_2D_RECT    = 0x8DCD

  GL_INT_SAMPLER_BUFFER    : GLenum
  GL_INT_SAMPLER_BUFFER     = 0x8DD0

  GL_UNSIGNED_INT_SAMPLER_2D_RECT: GLenum
  GL_UNSIGNED_INT_SAMPLER_2D_RECT = 0x8DD5

  GL_UNSIGNED_INT_SAMPLER_BUFFER: GLenum
  GL_UNSIGNED_INT_SAMPLER_BUFFER = 0x8DD8

  GL_TEXTURE_BUFFER        : GLenum
  GL_TEXTURE_BUFFER         = 0x8C2A

  GL_MAX_TEXTURE_BUFFER_SIZE: GLenum
  GL_MAX_TEXTURE_BUFFER_SIZE = 0x8C2B

  GL_TEXTURE_BINDING_BUFFER: GLenum
  GL_TEXTURE_BINDING_BUFFER = 0x8C2C

  GL_TEXTURE_BUFFER_DATA_STORE_BINDING: GLenum
  GL_TEXTURE_BUFFER_DATA_STORE_BINDING = 0x8C2D

  GL_TEXTURE_RECTANGLE     : GLenum
  GL_TEXTURE_RECTANGLE      = 0x84F5

  GL_TEXTURE_BINDING_RECTANGLE: GLenum
  GL_TEXTURE_BINDING_RECTANGLE = 0x84F6

  GL_PROXY_TEXTURE_RECTANGLE: GLenum
  GL_PROXY_TEXTURE_RECTANGLE = 0x84F7

  GL_MAX_RECTANGLE_TEXTURE_SIZE: GLenum
  GL_MAX_RECTANGLE_TEXTURE_SIZE = 0x84F8

  GL_R8_SNORM              : GLenum
  GL_R8_SNORM               = 0x8F94

  GL_RG8_SNORM             : GLenum
  GL_RG8_SNORM              = 0x8F95

  GL_RGB8_SNORM            : GLenum
  GL_RGB8_SNORM             = 0x8F96

  GL_RGBA8_SNORM           : GLenum
  GL_RGBA8_SNORM            = 0x8F97

  GL_R16_SNORM             : GLenum
  GL_R16_SNORM              = 0x8F98

  GL_RG16_SNORM            : GLenum
  GL_RG16_SNORM             = 0x8F99

  GL_RGB16_SNORM           : GLenum
  GL_RGB16_SNORM            = 0x8F9A

  GL_RGBA16_SNORM          : GLenum
  GL_RGBA16_SNORM           = 0x8F9B

  GL_SIGNED_NORMALIZED     : GLenum
  GL_SIGNED_NORMALIZED      = 0x8F9C

  GL_PRIMITIVE_RESTART     : GLenum
  GL_PRIMITIVE_RESTART      = 0x8F9D

  GL_PRIMITIVE_RESTART_INDEX: GLenum
  GL_PRIMITIVE_RESTART_INDEX = 0x8F9E

  GL_COPY_READ_BUFFER      : GLenum
  GL_COPY_READ_BUFFER       = 0x8F36

  GL_COPY_WRITE_BUFFER     : GLenum
  GL_COPY_WRITE_BUFFER      = 0x8F37

  GL_UNIFORM_BUFFER        : GLenum
  GL_UNIFORM_BUFFER         = 0x8A11

  GL_UNIFORM_BUFFER_BINDING: GLenum
  GL_UNIFORM_BUFFER_BINDING = 0x8A28

  GL_UNIFORM_BUFFER_START  : GLenum
  GL_UNIFORM_BUFFER_START   = 0x8A29

  GL_UNIFORM_BUFFER_SIZE   : GLenum
  GL_UNIFORM_BUFFER_SIZE    = 0x8A2A

  GL_MAX_VERTEX_UNIFORM_BLOCKS: GLenum
  GL_MAX_VERTEX_UNIFORM_BLOCKS = 0x8A2B

  GL_MAX_GEOMETRY_UNIFORM_BLOCKS: GLenum
  GL_MAX_GEOMETRY_UNIFORM_BLOCKS = 0x8A2C

  GL_MAX_FRAGMENT_UNIFORM_BLOCKS: GLenum
  GL_MAX_FRAGMENT_UNIFORM_BLOCKS = 0x8A2D

  GL_MAX_COMBINED_UNIFORM_BLOCKS: GLenum
  GL_MAX_COMBINED_UNIFORM_BLOCKS = 0x8A2E

  GL_MAX_UNIFORM_BUFFER_BINDINGS: GLenum
  GL_MAX_UNIFORM_BUFFER_BINDINGS = 0x8A2F

  GL_MAX_UNIFORM_BLOCK_SIZE: GLenum
  GL_MAX_UNIFORM_BLOCK_SIZE = 0x8A30

  GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS: GLenum
  GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS = 0x8A31

  GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS: GLenum
  GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS = 0x8A32

  GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS: GLenum
  GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS = 0x8A33

  GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT: GLenum
  GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT = 0x8A34

  GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH: GLenum
  GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH = 0x8A35

  GL_ACTIVE_UNIFORM_BLOCKS : GLenum
  GL_ACTIVE_UNIFORM_BLOCKS  = 0x8A36

  GL_UNIFORM_TYPE          : GLenum
  GL_UNIFORM_TYPE           = 0x8A37

  GL_UNIFORM_SIZE          : GLenum
  GL_UNIFORM_SIZE           = 0x8A38

  GL_UNIFORM_NAME_LENGTH   : GLenum
  GL_UNIFORM_NAME_LENGTH    = 0x8A39

  GL_UNIFORM_BLOCK_INDEX   : GLenum
  GL_UNIFORM_BLOCK_INDEX    = 0x8A3A

  GL_UNIFORM_OFFSET        : GLenum
  GL_UNIFORM_OFFSET         = 0x8A3B

  GL_UNIFORM_ARRAY_STRIDE  : GLenum
  GL_UNIFORM_ARRAY_STRIDE   = 0x8A3C

  GL_UNIFORM_MATRIX_STRIDE : GLenum
  GL_UNIFORM_MATRIX_STRIDE  = 0x8A3D

  GL_UNIFORM_IS_ROW_MAJOR  : GLenum
  GL_UNIFORM_IS_ROW_MAJOR   = 0x8A3E

  GL_UNIFORM_BLOCK_BINDING : GLenum
  GL_UNIFORM_BLOCK_BINDING  = 0x8A3F

  GL_UNIFORM_BLOCK_DATA_SIZE: GLenum
  GL_UNIFORM_BLOCK_DATA_SIZE = 0x8A40

  GL_UNIFORM_BLOCK_NAME_LENGTH: GLenum
  GL_UNIFORM_BLOCK_NAME_LENGTH = 0x8A41

  GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS: GLenum
  GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS = 0x8A42

  GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES: GLenum
  GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES = 0x8A43

  GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER: GLenum
  GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER = 0x8A44

  GL_UNIFORM_BLOCK_REFERENCED_BY_GEOMETRY_SHADER: GLenum
  GL_UNIFORM_BLOCK_REFERENCED_BY_GEOMETRY_SHADER = 0x8A45

  GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER: GLenum
  GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER = 0x8A46

  GL_INVALID_INDEX         : GLenum
  GL_INVALID_INDEX          = 0xFFFFFFFF

  GL_CONTEXT_CORE_PROFILE_BIT: GLenum
  GL_CONTEXT_CORE_PROFILE_BIT = 0x00000001

  GL_CONTEXT_COMPATIBILITY_PROFILE_BIT: GLenum
  GL_CONTEXT_COMPATIBILITY_PROFILE_BIT = 0x00000002

  GL_LINES_ADJACENCY       : GLenum
  GL_LINES_ADJACENCY        = 0x000A

  GL_LINE_STRIP_ADJACENCY  : GLenum
  GL_LINE_STRIP_ADJACENCY   = 0x000B

  GL_TRIANGLES_ADJACENCY   : GLenum
  GL_TRIANGLES_ADJACENCY    = 0x000C

  GL_TRIANGLE_STRIP_ADJACENCY: GLenum
  GL_TRIANGLE_STRIP_ADJACENCY = 0x000D

  GL_PROGRAM_POINT_SIZE    : GLenum
  GL_PROGRAM_POINT_SIZE     = 0x8642

  GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS: GLenum
  GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS = 0x8C29

  GL_FRAMEBUFFER_ATTACHMENT_LAYERED: GLenum
  GL_FRAMEBUFFER_ATTACHMENT_LAYERED = 0x8DA7

  GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS: GLenum
  GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS = 0x8DA8

  GL_GEOMETRY_SHADER       : GLenum
  GL_GEOMETRY_SHADER        = 0x8DD9

  GL_GEOMETRY_VERTICES_OUT : GLenum
  GL_GEOMETRY_VERTICES_OUT  = 0x8916

  GL_GEOMETRY_INPUT_TYPE   : GLenum
  GL_GEOMETRY_INPUT_TYPE    = 0x8917

  GL_GEOMETRY_OUTPUT_TYPE  : GLenum
  GL_GEOMETRY_OUTPUT_TYPE   = 0x8918

  GL_MAX_GEOMETRY_UNIFORM_COMPONENTS: GLenum
  GL_MAX_GEOMETRY_UNIFORM_COMPONENTS = 0x8DDF

  GL_MAX_GEOMETRY_OUTPUT_VERTICES: GLenum
  GL_MAX_GEOMETRY_OUTPUT_VERTICES = 0x8DE0

  GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS: GLenum
  GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS = 0x8DE1

  GL_MAX_VERTEX_OUTPUT_COMPONENTS: GLenum
  GL_MAX_VERTEX_OUTPUT_COMPONENTS = 0x9122

  GL_MAX_GEOMETRY_INPUT_COMPONENTS: GLenum
  GL_MAX_GEOMETRY_INPUT_COMPONENTS = 0x9123

  GL_MAX_GEOMETRY_OUTPUT_COMPONENTS: GLenum
  GL_MAX_GEOMETRY_OUTPUT_COMPONENTS = 0x9124

  GL_MAX_FRAGMENT_INPUT_COMPONENTS: GLenum
  GL_MAX_FRAGMENT_INPUT_COMPONENTS = 0x9125

  GL_CONTEXT_PROFILE_MASK  : GLenum
  GL_CONTEXT_PROFILE_MASK   = 0x9126

  GL_DEPTH_CLAMP           : GLenum
  GL_DEPTH_CLAMP            = 0x864F

  GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION: GLenum
  GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION = 0x8E4C

  GL_FIRST_VERTEX_CONVENTION: GLenum
  GL_FIRST_VERTEX_CONVENTION = 0x8E4D

  GL_LAST_VERTEX_CONVENTION: GLenum
  GL_LAST_VERTEX_CONVENTION = 0x8E4E

  GL_PROVOKING_VERTEX      : GLenum
  GL_PROVOKING_VERTEX       = 0x8E4F

  GL_TEXTURE_CUBE_MAP_SEAMLESS: GLenum
  GL_TEXTURE_CUBE_MAP_SEAMLESS = 0x884F

  GL_MAX_SERVER_WAIT_TIMEOUT: GLenum
  GL_MAX_SERVER_WAIT_TIMEOUT = 0x9111

  GL_OBJECT_TYPE           : GLenum
  GL_OBJECT_TYPE            = 0x9112

  GL_SYNC_CONDITION        : GLenum
  GL_SYNC_CONDITION         = 0x9113

  GL_SYNC_STATUS           : GLenum
  GL_SYNC_STATUS            = 0x9114

  GL_SYNC_FLAGS            : GLenum
  GL_SYNC_FLAGS             = 0x9115

  GL_SYNC_FENCE            : GLenum
  GL_SYNC_FENCE             = 0x9116

  GL_SYNC_GPU_COMMANDS_COMPLETE: GLenum
  GL_SYNC_GPU_COMMANDS_COMPLETE = 0x9117

  GL_UNSIGNALED            : GLenum
  GL_UNSIGNALED             = 0x9118

  GL_SIGNALED              : GLenum
  GL_SIGNALED               = 0x9119

  GL_ALREADY_SIGNALED      : GLenum
  GL_ALREADY_SIGNALED       = 0x911A

  GL_TIMEOUT_EXPIRED       : GLenum
  GL_TIMEOUT_EXPIRED        = 0x911B

  GL_CONDITION_SATISFIED   : GLenum
  GL_CONDITION_SATISFIED    = 0x911C

  GL_WAIT_FAILED           : GLenum
  GL_WAIT_FAILED            = 0x911D

  GL_TIMEOUT_IGNORED       : GLenum
  GL_TIMEOUT_IGNORED        = 0xFFFFFFFFFFFFFFFF

  GL_SYNC_FLUSH_COMMANDS_BIT: GLenum
  GL_SYNC_FLUSH_COMMANDS_BIT = 0x00000001

  GL_SAMPLE_POSITION       : GLenum
  GL_SAMPLE_POSITION        = 0x8E50

  GL_SAMPLE_MASK           : GLenum
  GL_SAMPLE_MASK            = 0x8E51

  GL_SAMPLE_MASK_VALUE     : GLenum
  GL_SAMPLE_MASK_VALUE      = 0x8E52

  GL_MAX_SAMPLE_MASK_WORDS : GLenum
  GL_MAX_SAMPLE_MASK_WORDS  = 0x8E59

  GL_TEXTURE_2D_MULTISAMPLE: GLenum
  GL_TEXTURE_2D_MULTISAMPLE = 0x9100

  GL_PROXY_TEXTURE_2D_MULTISAMPLE: GLenum
  GL_PROXY_TEXTURE_2D_MULTISAMPLE = 0x9101

  GL_TEXTURE_2D_MULTISAMPLE_ARRAY: GLenum
  GL_TEXTURE_2D_MULTISAMPLE_ARRAY = 0x9102

  GL_PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY: GLenum
  GL_PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY = 0x9103

  GL_TEXTURE_BINDING_2D_MULTISAMPLE: GLenum
  GL_TEXTURE_BINDING_2D_MULTISAMPLE = 0x9104

  GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY: GLenum
  GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY = 0x9105

  GL_TEXTURE_SAMPLES       : GLenum
  GL_TEXTURE_SAMPLES        = 0x9106

  GL_TEXTURE_FIXED_SAMPLE_LOCATIONS: GLenum
  GL_TEXTURE_FIXED_SAMPLE_LOCATIONS = 0x9107

  GL_SAMPLER_2D_MULTISAMPLE: GLenum
  GL_SAMPLER_2D_MULTISAMPLE = 0x9108

  GL_INT_SAMPLER_2D_MULTISAMPLE: GLenum
  GL_INT_SAMPLER_2D_MULTISAMPLE = 0x9109

  GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE: GLenum
  GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE = 0x910A

  GL_SAMPLER_2D_MULTISAMPLE_ARRAY: GLenum
  GL_SAMPLER_2D_MULTISAMPLE_ARRAY = 0x910B

  GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY: GLenum
  GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = 0x910C

  GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY: GLenum
  GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = 0x910D

  GL_MAX_COLOR_TEXTURE_SAMPLES: GLenum
  GL_MAX_COLOR_TEXTURE_SAMPLES = 0x910E

  GL_MAX_DEPTH_TEXTURE_SAMPLES: GLenum
  GL_MAX_DEPTH_TEXTURE_SAMPLES = 0x910F

  GL_MAX_INTEGER_SAMPLES   : GLenum
  GL_MAX_INTEGER_SAMPLES    = 0x9110

  GL_VERTEX_ATTRIB_ARRAY_DIVISOR: GLenum
  GL_VERTEX_ATTRIB_ARRAY_DIVISOR = 0x88FE

  GL_SRC1_COLOR            : GLenum
  GL_SRC1_COLOR             = 0x88F9

  GL_ONE_MINUS_SRC1_COLOR  : GLenum
  GL_ONE_MINUS_SRC1_COLOR   = 0x88FA

  GL_ONE_MINUS_SRC1_ALPHA  : GLenum
  GL_ONE_MINUS_SRC1_ALPHA   = 0x88FB

  GL_MAX_DUAL_SOURCE_DRAW_BUFFERS: GLenum
  GL_MAX_DUAL_SOURCE_DRAW_BUFFERS = 0x88FC

  GL_ANY_SAMPLES_PASSED    : GLenum
  GL_ANY_SAMPLES_PASSED     = 0x8C2F

  GL_SAMPLER_BINDING       : GLenum
  GL_SAMPLER_BINDING        = 0x8919

  GL_RGB10_A2UI            : GLenum
  GL_RGB10_A2UI             = 0x906F

  GL_TEXTURE_SWIZZLE_R     : GLenum
  GL_TEXTURE_SWIZZLE_R      = 0x8E42

  GL_TEXTURE_SWIZZLE_G     : GLenum
  GL_TEXTURE_SWIZZLE_G      = 0x8E43

  GL_TEXTURE_SWIZZLE_B     : GLenum
  GL_TEXTURE_SWIZZLE_B      = 0x8E44

  GL_TEXTURE_SWIZZLE_A     : GLenum
  GL_TEXTURE_SWIZZLE_A      = 0x8E45

  GL_TEXTURE_SWIZZLE_RGBA  : GLenum
  GL_TEXTURE_SWIZZLE_RGBA   = 0x8E46

  GL_TIME_ELAPSED          : GLenum
  GL_TIME_ELAPSED           = 0x88BF

  GL_TIMESTAMP             : GLenum
  GL_TIMESTAMP              = 0x8E28

  GL_INT_2_10_10_10_REV    : GLenum
  GL_INT_2_10_10_10_REV     = 0x8D9F

  GL_SAMPLE_SHADING        : GLenum
  GL_SAMPLE_SHADING         = 0x8C36

  GL_MIN_SAMPLE_SHADING_VALUE: GLenum
  GL_MIN_SAMPLE_SHADING_VALUE = 0x8C37

  GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET: GLenum
  GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET = 0x8E5E

  GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET: GLenum
  GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET = 0x8E5F

  GL_TEXTURE_CUBE_MAP_ARRAY: GLenum
  GL_TEXTURE_CUBE_MAP_ARRAY = 0x9009

  GL_TEXTURE_BINDING_CUBE_MAP_ARRAY: GLenum
  GL_TEXTURE_BINDING_CUBE_MAP_ARRAY = 0x900A

  GL_PROXY_TEXTURE_CUBE_MAP_ARRAY: GLenum
  GL_PROXY_TEXTURE_CUBE_MAP_ARRAY = 0x900B

  GL_SAMPLER_CUBE_MAP_ARRAY: GLenum
  GL_SAMPLER_CUBE_MAP_ARRAY = 0x900C

  GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW: GLenum
  GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW = 0x900D

  GL_INT_SAMPLER_CUBE_MAP_ARRAY: GLenum
  GL_INT_SAMPLER_CUBE_MAP_ARRAY = 0x900E

  GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY: GLenum
  GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY = 0x900F

  GL_DRAW_INDIRECT_BUFFER  : GLenum
  GL_DRAW_INDIRECT_BUFFER   = 0x8F3F

  GL_DRAW_INDIRECT_BUFFER_BINDING: GLenum
  GL_DRAW_INDIRECT_BUFFER_BINDING = 0x8F43

  GL_GEOMETRY_SHADER_INVOCATIONS: GLenum
  GL_GEOMETRY_SHADER_INVOCATIONS = 0x887F

  GL_MAX_GEOMETRY_SHADER_INVOCATIONS: GLenum
  GL_MAX_GEOMETRY_SHADER_INVOCATIONS = 0x8E5A

  GL_MIN_FRAGMENT_INTERPOLATION_OFFSET: GLenum
  GL_MIN_FRAGMENT_INTERPOLATION_OFFSET = 0x8E5B

  GL_MAX_FRAGMENT_INTERPOLATION_OFFSET: GLenum
  GL_MAX_FRAGMENT_INTERPOLATION_OFFSET = 0x8E5C

  GL_FRAGMENT_INTERPOLATION_OFFSET_BITS: GLenum
  GL_FRAGMENT_INTERPOLATION_OFFSET_BITS = 0x8E5D

  GL_MAX_VERTEX_STREAMS    : GLenum
  GL_MAX_VERTEX_STREAMS     = 0x8E71

  GL_DOUBLE_VEC2           : GLenum
  GL_DOUBLE_VEC2            = 0x8FFC

  GL_DOUBLE_VEC3           : GLenum
  GL_DOUBLE_VEC3            = 0x8FFD

  GL_DOUBLE_VEC4           : GLenum
  GL_DOUBLE_VEC4            = 0x8FFE

  GL_DOUBLE_MAT2           : GLenum
  GL_DOUBLE_MAT2            = 0x8F46

  GL_DOUBLE_MAT3           : GLenum
  GL_DOUBLE_MAT3            = 0x8F47

  GL_DOUBLE_MAT4           : GLenum
  GL_DOUBLE_MAT4            = 0x8F48

  GL_DOUBLE_MAT2x3         : GLenum
  GL_DOUBLE_MAT2x3          = 0x8F49

  GL_DOUBLE_MAT2x4         : GLenum
  GL_DOUBLE_MAT2x4          = 0x8F4A

  GL_DOUBLE_MAT3x2         : GLenum
  GL_DOUBLE_MAT3x2          = 0x8F4B

  GL_DOUBLE_MAT3x4         : GLenum
  GL_DOUBLE_MAT3x4          = 0x8F4C

  GL_DOUBLE_MAT4x2         : GLenum
  GL_DOUBLE_MAT4x2          = 0x8F4D

  GL_DOUBLE_MAT4x3         : GLenum
  GL_DOUBLE_MAT4x3          = 0x8F4E

  GL_ACTIVE_SUBROUTINES    : GLenum
  GL_ACTIVE_SUBROUTINES     = 0x8DE5

  GL_ACTIVE_SUBROUTINE_UNIFORMS: GLenum
  GL_ACTIVE_SUBROUTINE_UNIFORMS = 0x8DE6

  GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS: GLenum
  GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS = 0x8E47

  GL_ACTIVE_SUBROUTINE_MAX_LENGTH: GLenum
  GL_ACTIVE_SUBROUTINE_MAX_LENGTH = 0x8E48

  GL_ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH: GLenum
  GL_ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH = 0x8E49

  GL_MAX_SUBROUTINES       : GLenum
  GL_MAX_SUBROUTINES        = 0x8DE7

  GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS: GLenum
  GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS = 0x8DE8

  GL_NUM_COMPATIBLE_SUBROUTINES: GLenum
  GL_NUM_COMPATIBLE_SUBROUTINES = 0x8E4A

  GL_COMPATIBLE_SUBROUTINES: GLenum
  GL_COMPATIBLE_SUBROUTINES = 0x8E4B

  GL_PATCHES               : GLenum
  GL_PATCHES                = 0x000E

  GL_PATCH_VERTICES        : GLenum
  GL_PATCH_VERTICES         = 0x8E72

  GL_PATCH_DEFAULT_INNER_LEVEL: GLenum
  GL_PATCH_DEFAULT_INNER_LEVEL = 0x8E73

  GL_PATCH_DEFAULT_OUTER_LEVEL: GLenum
  GL_PATCH_DEFAULT_OUTER_LEVEL = 0x8E74

  GL_TESS_CONTROL_OUTPUT_VERTICES: GLenum
  GL_TESS_CONTROL_OUTPUT_VERTICES = 0x8E75

  GL_TESS_GEN_MODE         : GLenum
  GL_TESS_GEN_MODE          = 0x8E76

  GL_TESS_GEN_SPACING      : GLenum
  GL_TESS_GEN_SPACING       = 0x8E77

  GL_TESS_GEN_VERTEX_ORDER : GLenum
  GL_TESS_GEN_VERTEX_ORDER  = 0x8E78

  GL_TESS_GEN_POINT_MODE   : GLenum
  GL_TESS_GEN_POINT_MODE    = 0x8E79

  GL_ISOLINES              : GLenum
  GL_ISOLINES               = 0x8E7A

  GL_QUADS                 : GLenum
  GL_QUADS                  = 0x0007

  GL_FRACTIONAL_ODD        : GLenum
  GL_FRACTIONAL_ODD         = 0x8E7B

  GL_FRACTIONAL_EVEN       : GLenum
  GL_FRACTIONAL_EVEN        = 0x8E7C

  GL_MAX_PATCH_VERTICES    : GLenum
  GL_MAX_PATCH_VERTICES     = 0x8E7D

  GL_MAX_TESS_GEN_LEVEL    : GLenum
  GL_MAX_TESS_GEN_LEVEL     = 0x8E7E

  GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS: GLenum
  GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS = 0x8E7F

  GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS: GLenum
  GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS = 0x8E80

  GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS: GLenum
  GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS = 0x8E81

  GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS: GLenum
  GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS = 0x8E82

  GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS: GLenum
  GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS = 0x8E83

  GL_MAX_TESS_PATCH_COMPONENTS: GLenum
  GL_MAX_TESS_PATCH_COMPONENTS = 0x8E84

  GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS: GLenum
  GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS = 0x8E85

  GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS: GLenum
  GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS = 0x8E86

  GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS: GLenum
  GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS = 0x8E89

  GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS: GLenum
  GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS = 0x8E8A

  GL_MAX_TESS_CONTROL_INPUT_COMPONENTS: GLenum
  GL_MAX_TESS_CONTROL_INPUT_COMPONENTS = 0x886C

  GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS: GLenum
  GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS = 0x886D

  GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS: GLenum
  GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS = 0x8E1E

  GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS: GLenum
  GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS = 0x8E1F

  GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_CONTROL_SHADER: GLenum
  GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_CONTROL_SHADER = 0x84F0

  GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_EVALUATION_SHADER: GLenum
  GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_EVALUATION_SHADER = 0x84F1

  GL_TESS_EVALUATION_SHADER: GLenum
  GL_TESS_EVALUATION_SHADER = 0x8E87

  GL_TESS_CONTROL_SHADER   : GLenum
  GL_TESS_CONTROL_SHADER    = 0x8E88

  GL_TRANSFORM_FEEDBACK    : GLenum
  GL_TRANSFORM_FEEDBACK     = 0x8E22

  GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED: GLenum
  GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED = 0x8E23

  GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE: GLenum
  GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE = 0x8E24

  GL_TRANSFORM_FEEDBACK_BINDING: GLenum
  GL_TRANSFORM_FEEDBACK_BINDING = 0x8E25

  GL_MAX_TRANSFORM_FEEDBACK_BUFFERS: GLenum
  GL_MAX_TRANSFORM_FEEDBACK_BUFFERS = 0x8E70

  GL_FIXED                 : GLenum
  GL_FIXED                  = 0x140C

  GL_IMPLEMENTATION_COLOR_READ_TYPE: GLenum
  GL_IMPLEMENTATION_COLOR_READ_TYPE = 0x8B9A

  GL_IMPLEMENTATION_COLOR_READ_FORMAT: GLenum
  GL_IMPLEMENTATION_COLOR_READ_FORMAT = 0x8B9B

  GL_LOW_FLOAT             : GLenum
  GL_LOW_FLOAT              = 0x8DF0

  GL_MEDIUM_FLOAT          : GLenum
  GL_MEDIUM_FLOAT           = 0x8DF1

  GL_HIGH_FLOAT            : GLenum
  GL_HIGH_FLOAT             = 0x8DF2

  GL_LOW_INT               : GLenum
  GL_LOW_INT                = 0x8DF3

  GL_MEDIUM_INT            : GLenum
  GL_MEDIUM_INT             = 0x8DF4

  GL_HIGH_INT              : GLenum
  GL_HIGH_INT               = 0x8DF5

  GL_SHADER_COMPILER       : GLenum
  GL_SHADER_COMPILER        = 0x8DFA

  GL_SHADER_BINARY_FORMATS : GLenum
  GL_SHADER_BINARY_FORMATS  = 0x8DF8

  GL_NUM_SHADER_BINARY_FORMATS: GLenum
  GL_NUM_SHADER_BINARY_FORMATS = 0x8DF9

  GL_MAX_VERTEX_UNIFORM_VECTORS: GLenum
  GL_MAX_VERTEX_UNIFORM_VECTORS = 0x8DFB

  GL_MAX_VARYING_VECTORS   : GLenum
  GL_MAX_VARYING_VECTORS    = 0x8DFC

  GL_MAX_FRAGMENT_UNIFORM_VECTORS: GLenum
  GL_MAX_FRAGMENT_UNIFORM_VECTORS = 0x8DFD

  GL_RGB565                : GLenum
  GL_RGB565                 = 0x8D62

  GL_PROGRAM_BINARY_RETRIEVABLE_HINT: GLenum
  GL_PROGRAM_BINARY_RETRIEVABLE_HINT = 0x8257

  GL_PROGRAM_BINARY_LENGTH : GLenum
  GL_PROGRAM_BINARY_LENGTH  = 0x8741

  GL_NUM_PROGRAM_BINARY_FORMATS: GLenum
  GL_NUM_PROGRAM_BINARY_FORMATS = 0x87FE

  GL_PROGRAM_BINARY_FORMATS: GLenum
  GL_PROGRAM_BINARY_FORMATS = 0x87FF

  GL_VERTEX_SHADER_BIT     : GLenum
  GL_VERTEX_SHADER_BIT      = 0x00000001

  GL_FRAGMENT_SHADER_BIT   : GLenum
  GL_FRAGMENT_SHADER_BIT    = 0x00000002

  GL_GEOMETRY_SHADER_BIT   : GLenum
  GL_GEOMETRY_SHADER_BIT    = 0x00000004

  GL_TESS_CONTROL_SHADER_BIT: GLenum
  GL_TESS_CONTROL_SHADER_BIT = 0x00000008

  GL_TESS_EVALUATION_SHADER_BIT: GLenum
  GL_TESS_EVALUATION_SHADER_BIT = 0x00000010

  GL_ALL_SHADER_BITS       : GLenum
  GL_ALL_SHADER_BITS        = 0xFFFFFFFF

  GL_PROGRAM_SEPARABLE     : GLenum
  GL_PROGRAM_SEPARABLE      = 0x8258

  GL_ACTIVE_PROGRAM        : GLenum
  GL_ACTIVE_PROGRAM         = 0x8259

  GL_PROGRAM_PIPELINE_BINDING: GLenum
  GL_PROGRAM_PIPELINE_BINDING = 0x825A

  GL_MAX_VIEWPORTS         : GLenum
  GL_MAX_VIEWPORTS          = 0x825B

  GL_VIEWPORT_SUBPIXEL_BITS: GLenum
  GL_VIEWPORT_SUBPIXEL_BITS = 0x825C

  GL_VIEWPORT_BOUNDS_RANGE : GLenum
  GL_VIEWPORT_BOUNDS_RANGE  = 0x825D

  GL_LAYER_PROVOKING_VERTEX: GLenum
  GL_LAYER_PROVOKING_VERTEX = 0x825E

  GL_VIEWPORT_INDEX_PROVOKING_VERTEX: GLenum
  GL_VIEWPORT_INDEX_PROVOKING_VERTEX = 0x825F

  GL_UNDEFINED_VERTEX      : GLenum
  GL_UNDEFINED_VERTEX       = 0x8260

