module Graphics.Rendering.Gl.Types

{--
  data C_IntTypes : Type -> Type where
       C_IntChar   : C_IntTypes Char
       C_IntNative : C_IntTypes Int
       C_IntBits8  : C_IntTypes Bits8
       C_IntBits16 : C_IntTypes Bits16
       C_IntBits32 : C_IntTypes Bits32
       C_IntBits64 : C_IntTypes Bits64

  -- Supported C foreign types
  data C_Types : Type -> Type where
       C_Str   : C_Types String
       C_Float : C_Types Float
       C_Ptr   : C_Types Ptr
       C_MPtr  : C_Types ManagedPtr
       C_Unit  : C_Types ()
       C_Any   : C_Types (Raw a)
       C_IntT  : C_IntTypes i -> C_Types i
--}
GLenum : Type
GLenum = Int

GLbitfield : Type
GLbitfield = Int

GLboolean : Type
GLboolean = Char

GLbyte : Type
GLbyte = Bits8

GLubyte : Type
GLubyte = Bits8

GLshort : Type
GLshort = Int

GLushort : Type
GLushort = Int

GLint : Type
GLint = Int

GLuint : Type
GLuint = Int

GLsizei : Type
GLsizei = Int

GLchar : Type
GLchar = Char

GLdouble : Type
GLdouble = Double

GLclampd : Type
GLclampd = Double

-- only temporary
GLfloat : Type
GLfloat = Double

GLclampf : Type
GLclampf = Double

-- the pointer size of the data len*sizeof(whatever)
GLsizeiptr : Type
GLsizeiptr = Int
