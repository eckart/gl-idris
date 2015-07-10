module Graphics.Util.Glfw

import Graphics.Rendering.Config

%include C "GL/glew.h"
%include C "GLFW/glfw3.h"
%include C "gl_idris.h"
%link C "gl_idris.o"

%access private

||| Glfw Window
abstract
data GlfwWindow = Win Ptr

||| Glfw Monitor
abstract
data GlfwMonitor = Monitor Ptr | DefaultMonitor

public 
defaultMonitor : GlfwMonitor
defaultMonitor = DefaultMonitor

public
class Flag a where
  toInt   : a -> Int

class Flag a => GlfwConstant a where
  fromInt : Int -> a

public
data KeyEventTy
  = GLFW_PRESS
  | GLFW_RELEASE
  | GLFW_REPEAT

instance Flag KeyEventTy where
  toInt   GLFW_PRESS   = 1
  toInt   GLFW_RELEASE = 0
  toInt   GLFW_REPEAT  = 2

instance GlfwConstant KeyEventTy where
  fromInt 1            = GLFW_PRESS
  fromInt 0            = GLFW_RELEASE 
  fromInt 2            = GLFW_REPEAT

instance Eq KeyEventTy where
  GLFW_PRESS   == GLFW_PRESS   = True
  GLFW_RELEASE == GLFW_RELEASE = True
  GLFW_REPEAT  == GLFW_REPEAT  = True
  _            == _            = False
  
instance Show KeyEventTy where
  show GLFW_PRESS   = "GLFW_PRESS"
  show GLFW_RELEASE = "GLFW_RELEASE"
  show GLFW_REPEAT  = "GLFW_REPEAT"

-- | Special key is a key not represented in the 32 - 127 printable ASCII range.
public
data FunctionKey
  = UNKNOWN
  | GLFW_KEY_ESCAPE
  | GLFW_KEY_ENTER
  | GLFW_KEY_TAB
  | GLFW_KEY_BACKSPACE
  | GLFW_KEY_INSERT
  | GLFW_KEY_DELETE
  | GLFW_KEY_RIGHT
  | GLFW_KEY_LEFT
  | GLFW_KEY_DOWN
  | GLFW_KEY_UP
  | GLFW_KEY_PAGE_UP
  | GLFW_KEY_PAGE_DOWN
  | GLFW_KEY_HOME
  | GLFW_KEY_END
  | GLFW_KEY_CAPS_LOCK
  | GLFW_KEY_SCROLL_LOCK
  | GLFW_KEY_NUM_LOCK
  | GLFW_KEY_PRINT_SCREEN
  | GLFW_KEY_PAUSE
  | GLFW_KEY_F1
  | GLFW_KEY_F2
  | GLFW_KEY_F3
  | GLFW_KEY_F4
  | GLFW_KEY_F5
  | GLFW_KEY_F6
  | GLFW_KEY_F7
  | GLFW_KEY_F8
  | GLFW_KEY_F9
  | GLFW_KEY_F10
  | GLFW_KEY_F11
  | GLFW_KEY_F12
  | GLFW_KEY_F13
  | GLFW_KEY_F14
  | GLFW_KEY_F15
  | GLFW_KEY_F16
  | GLFW_KEY_F17
  | GLFW_KEY_F18
  | GLFW_KEY_F19
  | GLFW_KEY_F20
  | GLFW_KEY_F21
  | GLFW_KEY_F22
  | GLFW_KEY_F23
  | GLFW_KEY_F24
  | GLFW_KEY_F25
  | GLFW_KEY_KP_0
  | GLFW_KEY_KP_1
  | GLFW_KEY_KP_2
  | GLFW_KEY_KP_3
  | GLFW_KEY_KP_4
  | GLFW_KEY_KP_5
  | GLFW_KEY_KP_6
  | GLFW_KEY_KP_7
  | GLFW_KEY_KP_8
  | GLFW_KEY_KP_9
  | GLFW_KEY_KP_DECIMAL
  | GLFW_KEY_KP_DIVIDE
  | GLFW_KEY_KP_MULTIPLY
  | GLFW_KEY_KP_SUBTRACT
  | GLFW_KEY_KP_ADD
  | GLFW_KEY_KP_ENTER
  | GLFW_KEY_KP_EQUAL
  | GLFW_KEY_LEFT_SHIFT
  | GLFW_KEY_LEFT_CONTROL
  | GLFW_KEY_LEFT_ALT
  | GLFW_KEY_LEFT_SUPER
  | GLFW_KEY_RIGHT_SHIFT
  | GLFW_KEY_RIGHT_CONTROL
  | GLFW_KEY_RIGHT_ALT
  | GLFW_KEY_RIGHT_SUPER
  | GLFW_KEY_MENU
  | GLFW_KEY_LAST


instance Flag FunctionKey where
  toInt UNKNOWN                     = -1
  toInt GLFW_KEY_ESCAPE             = 256
  toInt GLFW_KEY_ENTER              = 257
  toInt GLFW_KEY_TAB                = 258
  toInt GLFW_KEY_BACKSPACE          = 259
  toInt GLFW_KEY_INSERT             = 260
  toInt GLFW_KEY_DELETE             = 261
  toInt GLFW_KEY_RIGHT              = 262
  toInt GLFW_KEY_LEFT               = 263
  toInt GLFW_KEY_DOWN               = 264
  toInt GLFW_KEY_UP                 = 265
  toInt GLFW_KEY_PAGE_UP            = 266
  toInt GLFW_KEY_PAGE_DOWN          = 267
  toInt GLFW_KEY_HOME               = 268
  toInt GLFW_KEY_END                = 269
  toInt GLFW_KEY_CAPS_LOCK          = 280
  toInt GLFW_KEY_SCROLL_LOCK        = 281
  toInt GLFW_KEY_NUM_LOCK           = 282
  toInt GLFW_KEY_PRINT_SCREEN       = 283
  toInt GLFW_KEY_PAUSE              = 284
  toInt GLFW_KEY_F1                 = 290
  toInt GLFW_KEY_F2                 = 291
  toInt GLFW_KEY_F3                 = 292
  toInt GLFW_KEY_F4                 = 293
  toInt GLFW_KEY_F5                 = 294
  toInt GLFW_KEY_F6                 = 295
  toInt GLFW_KEY_F7                 = 296
  toInt GLFW_KEY_F8                 = 297
  toInt GLFW_KEY_F9                 = 298
  toInt GLFW_KEY_F10                = 299
  toInt GLFW_KEY_F11                = 300
  toInt GLFW_KEY_F12                = 301
  toInt GLFW_KEY_F13                = 302
  toInt GLFW_KEY_F14                = 303
  toInt GLFW_KEY_F15                = 304
  toInt GLFW_KEY_F16                = 305
  toInt GLFW_KEY_F17                = 306
  toInt GLFW_KEY_F18                = 307
  toInt GLFW_KEY_F19                = 308
  toInt GLFW_KEY_F20                = 309
  toInt GLFW_KEY_F21                = 310
  toInt GLFW_KEY_F22                = 311
  toInt GLFW_KEY_F23                = 312
  toInt GLFW_KEY_F24                = 313
  toInt GLFW_KEY_F25                = 314
  toInt GLFW_KEY_KP_0               = 320
  toInt GLFW_KEY_KP_1               = 321
  toInt GLFW_KEY_KP_2               = 322
  toInt GLFW_KEY_KP_3               = 323
  toInt GLFW_KEY_KP_4               = 324
  toInt GLFW_KEY_KP_5               = 325
  toInt GLFW_KEY_KP_6               = 326
  toInt GLFW_KEY_KP_7               = 327
  toInt GLFW_KEY_KP_8               = 328
  toInt GLFW_KEY_KP_9               = 329
  toInt GLFW_KEY_KP_DECIMAL         = 330
  toInt GLFW_KEY_KP_DIVIDE          = 331
  toInt GLFW_KEY_KP_MULTIPLY        = 332
  toInt GLFW_KEY_KP_SUBTRACT        = 333
  toInt GLFW_KEY_KP_ADD             = 334
  toInt GLFW_KEY_KP_ENTER           = 335
  toInt GLFW_KEY_KP_EQUAL           = 336
  toInt GLFW_KEY_LEFT_SHIFT         = 340
  toInt GLFW_KEY_LEFT_CONTROL       = 341
  toInt GLFW_KEY_LEFT_ALT           = 342
  toInt GLFW_KEY_LEFT_SUPER         = 343
  toInt GLFW_KEY_RIGHT_SHIFT        = 344
  toInt GLFW_KEY_RIGHT_CONTROL      = 345
  toInt GLFW_KEY_RIGHT_ALT          = 346
  toInt GLFW_KEY_RIGHT_SUPER        = 347
  toInt GLFW_KEY_MENU               = 348
  toInt GLFW_KEY_LAST               = 348


instance Eq FunctionKey where
  (==) k l = (toInt k) == (toInt l)

instance Show FunctionKey where
  show k = "Key " ++ (show (toInt k)) 

public
data GlfwFlags 
  = GLFW_FOCUSED
  | GLFW_ICONIFIED
  | GLFW_RESIZABLE
  | GLFW_VISIBLE  
  | GLFW_DECORATED
  | GLFW_AUTO_ICONIFY
  | GLFW_FLOATING
  | GLFW_RED_BITS
  | GLFW_GREEN_BITS
  | GLFW_BLUE_BITS
  | GLFW_ALPHA_BITS
  | GLFW_DEPTH_BITS
  | GLFW_STENCIL_BITS
  | GLFW_ACCUM_RED_BITS
  | GLFW_ACCUM_GREEN_BITS
  | GLFW_ACCUM_BLUE_BITS
  | GLFW_ACCUM_ALPHA_BITS
  | GLFW_AUX_BUFFERS
  | GLFW_STEREO
  | GLFW_SAMPLES
  | GLFW_SRGB_CAPABLE
  | GLFW_REFRESH_RATE
  | GLFW_DOUBLEBUFFER
  | GLFW_CLIENT_API
  | GLFW_CONTEXT_VERSION_MAJOR
  | GLFW_CONTEXT_VERSION_MINOR
  | GLFW_CONTEXT_REVISION
  | GLFW_CONTEXT_ROBUSTNESS
  | GLFW_OPENGL_FORWARD_COMPAT
  | GLFW_OPENGL_DEBUG_CONTEXT
  | GLFW_OPENGL_PROFILE
  | GLFW_CONTEXT_RELEASE_BEHAVIOR
  | GLFW_OPENGL_API
  | GLFW_OPENGL_ES_API
  | GLFW_NO_ROBUSTNESS
  | GLFW_NO_RESET_NOTIFICATION
  | GLFW_LOSE_CONTEXT_ON_RESET
  | GLFW_OPENGL_ANY_PROFILE
  | GLFW_OPENGL_CORE_PROFILE
  | GLFW_OPENGL_COMPAT_PROFILE
  | GLFW_CURSOR
  | GLFW_STICKY_KEYS
  | GLFW_STICKY_MOUSE_BUTTONS
  | GLFW_CURSOR_NORMAL
  | GLFW_CURSOR_HIDDEN
  | GLFW_CURSOR_DISABLED
  | GLFW_ANY_RELEASE_BEHAVIOR
  | GLFW_RELEASE_BEHAVIOR_FLUSH
  | GLFW_RELEASE_BEHAVIOR_NONE

  
instance Flag GlfwFlags where 
  toInt GLFW_FOCUSED                = 0x00020001
  toInt GLFW_ICONIFIED              = 0x00020002
  toInt GLFW_RESIZABLE              = 0x00020003
  toInt GLFW_VISIBLE                = 0x00020004
  toInt GLFW_DECORATED              = 0x00020005
  toInt GLFW_AUTO_ICONIFY           = 0x00020006
  toInt GLFW_FLOATING               = 0x00020007
  toInt GLFW_RED_BITS               = 0x00021001
  toInt GLFW_GREEN_BITS             = 0x00021002
  toInt GLFW_BLUE_BITS              = 0x00021003
  toInt GLFW_ALPHA_BITS             = 0x00021004
  toInt GLFW_DEPTH_BITS             = 0x00021005
  toInt GLFW_STENCIL_BITS           = 0x00021006
  toInt GLFW_ACCUM_RED_BITS         = 0x00021007
  toInt GLFW_ACCUM_GREEN_BITS       = 0x00021008
  toInt GLFW_ACCUM_BLUE_BITS        = 0x00021009
  toInt GLFW_ACCUM_ALPHA_BITS       = 0x0002100A
  toInt GLFW_AUX_BUFFERS            = 0x0002100B
  toInt GLFW_STEREO                 = 0x0002100C
  toInt GLFW_SAMPLES                = 0x0002100D
  toInt GLFW_SRGB_CAPABLE           = 0x0002100E
  toInt GLFW_REFRESH_RATE           = 0x0002100F
  toInt GLFW_DOUBLEBUFFER           = 0x00021010
  toInt GLFW_CLIENT_API             = 0x00022001
  toInt GLFW_CONTEXT_VERSION_MAJOR  = 0x00022002
  toInt GLFW_CONTEXT_VERSION_MINOR  = 0x00022003
  toInt GLFW_CONTEXT_REVISION       = 0x00022004
  toInt GLFW_CONTEXT_ROBUSTNESS     = 0x00022005
  toInt GLFW_OPENGL_FORWARD_COMPAT  = 0x00022006
  toInt GLFW_OPENGL_DEBUG_CONTEXT   = 0x00022007
  toInt GLFW_OPENGL_PROFILE         = 0x00022008
  toInt GLFW_CONTEXT_RELEASE_BEHAVIOR = 0x00022009
  toInt GLFW_OPENGL_API             = 0x00030001
  toInt GLFW_OPENGL_ES_API          = 0x00030002
  toInt GLFW_NO_ROBUSTNESS          =          0
  toInt GLFW_NO_RESET_NOTIFICATION  = 0x00031001
  toInt GLFW_LOSE_CONTEXT_ON_RESET  = 0x00031002
  toInt GLFW_OPENGL_ANY_PROFILE     =          0
  toInt GLFW_OPENGL_CORE_PROFILE    = 0x00032001
  toInt GLFW_OPENGL_COMPAT_PROFILE  = 0x00032002
  toInt GLFW_CURSOR                 = 0x00033001
  toInt GLFW_STICKY_KEYS            = 0x00033002
  toInt GLFW_STICKY_MOUSE_BUTTONS   = 0x00033003
  toInt GLFW_CURSOR_NORMAL          = 0x00034001
  toInt GLFW_CURSOR_HIDDEN          = 0x00034002
  toInt GLFW_CURSOR_DISABLED        = 0x00034003
  toInt GLFW_ANY_RELEASE_BEHAVIOR   =          0
  toInt GLFW_RELEASE_BEHAVIOR_FLUSH = 0x00035001
  toInt GLFW_RELEASE_BEHAVIOR_NONE  = 0x00035002


instance Flag Bool where
  toInt   True  = 1
  toInt   False = 0

instance GlfwConstant Bool where
  fromInt 1     = True
  fromInt 0     = False

-- GLEW 
public
glewInit : IO Int
glewInit = foreign FFI_C "idr_init_glew" (IO Int) 


-- GLFW from here  

public
glfwInit : IO Bool
glfwInit = do ret <- foreign FFI_C "glfwInit" (IO Int)
              pure $ if ret == 1 then True else False

public
glfwWindowHint : GlfwFlags -> Int -> IO ()
glfwWindowHint flag val = foreign FFI_C "glfwWindowHint" (Int -> Int -> IO ()) (toInt flag) val

public
glfwGetPrimaryMonitor : IO GlfwMonitor
glfwGetPrimaryMonitor = do p <- foreign FFI_C "glfwGetPrimaryMonitor" (IO Ptr) 
                           pure $ Monitor p

public 
createWindowSimple : (title: String) -> (width: Int) -> (height: Int) -> IO GlfwWindow
createWindowSimple title width height = 
  do ptr <- foreign FFI_C "idr_glfw_create_window" (String -> Int -> Int -> IO Ptr) title width height
     pure $ Win ptr

public 
glfwCreateWindow : (title: String) -> (width: Int) -> (height: Int) -> GlfwMonitor -> IO GlfwWindow 
glfwCreateWindow title width height (Monitor ptr) = 
  do p <- foreign FFI_C "glfwCreateWindow" (Int -> Int -> String -> Ptr -> Ptr -> IO Ptr) width height title ptr prim__null
     pure $ Win p
glfwCreateWindow title width height DefaultMonitor = 
  do p <- foreign FFI_C "glfwCreateWindow" (Int -> Int -> String -> Ptr -> Ptr -> IO Ptr) width height title prim__null prim__null
     pure $ Win p

public 
isWindow : GlfwWindow -> IO Bool
isWindow (Win ptr) = nullPtr ptr

public 
glfwMakeContextCurrent : GlfwWindow -> IO ()
glfwMakeContextCurrent (Win ptr) = foreign FFI_C "glfwMakeContextCurrent" (Ptr -> IO()) ptr


public 
glfwDestroyWindow : GlfwWindow -> IO ()
glfwDestroyWindow (Win ptr) = foreign FFI_C "glfwDestroyWindow" (Ptr -> IO()) ptr

public 
glfwTerminate : IO ()
glfwTerminate  = foreign FFI_C "glfwTerminate" (IO ())

public
glfwSwapBuffers : GlfwWindow -> IO ()
glfwSwapBuffers (Win ptr) = foreign FFI_C "glfwSwapBuffers" (Ptr -> IO()) ptr

public 
glfwWaitEvents : IO ()
glfwWaitEvents = foreign FFI_C "glfwWaitEvents" (IO ())

public 
glfwPollEvents : IO ()
glfwPollEvents = foreign FFI_C "glfwPollEvents" (IO ())

public 
glfwSetInputMode : GlfwWindow -> GlfwFlags -> Int -> IO ()
glfwSetInputMode (Win ptr) flag val = foreign FFI_C "glfwSetInputMode" (Ptr -> Int -> Int -> IO ()) ptr (toInt flag) val

public 
glfwGetFunctionKey : GlfwWindow -> FunctionKey -> IO KeyEventTy
glfwGetFunctionKey (Win ptr) k = do e <- foreign FFI_C "glfwGetKey" (Ptr -> Int -> IO Int) ptr (toInt k)
                                    pure $ fromInt e
public 
glfwGetKey : GlfwWindow -> Char -> IO KeyEventTy
glfwGetKey (Win ptr) k = do e <- foreign FFI_C "glfwGetKey" (Ptr -> Int -> IO Int) ptr (ord $ toUpper k)
                            pure $ fromInt e
                        
public 
glfwWindowShouldClose : GlfwWindow -> IO Bool
glfwWindowShouldClose (Win ptr) = do flag <- foreign FFI_C "glfwWindowShouldClose" (Ptr -> IO Int) ptr
                                     let bool = if flag == 0 then False else True
                                     pure bool

{--
GLFWAPI void glfwGetVersion(int* major, int* minor, int* rev);
GLFWAPI const char* glfwGetVersionString(void);
GLFWAPI GLFWerrorfun glfwSetErrorCallback(GLFWerrorfun cbfun);
GLFWAPI GLFWmonitor** glfwGetMonitors(int* count);

GLFWAPI void glfwGetMonitorPos(GLFWmonitor* monitor, int* xpos, int* ypos);
GLFWAPI void glfwGetMonitorPhysicalSize(GLFWmonitor* monitor, int* widthMM, int* heightMM);
GLFWAPI const char* glfwGetMonitorName(GLFWmonitor* monitor);
GLFWAPI GLFWmonitorfun glfwSetMonitorCallback(GLFWmonitorfun cbfun);
GLFWAPI const GLFWvidmode* glfwGetVideoModes(GLFWmonitor* monitor, int* count);
GLFWAPI const GLFWvidmode* glfwGetVideoMode(GLFWmonitor* monitor);
GLFWAPI void glfwSetGamma(GLFWmonitor* monitor, float gamma);
GLFWAPI const GLFWgammaramp* glfwGetGammaRamp(GLFWmonitor* monitor);
GLFWAPI void glfwSetGammaRamp(GLFWmonitor* monitor, const GLFWgammaramp* ramp);
GLFWAPI void glfwDefaultWindowHints(void);

GLFWAPI GLFWwindow* glfwCreateWindow(int width, int height, const char* title, GLFWmonitor* monitor, GLFWwindow* share);


GLFWAPI void glfwSetWindowShouldClose(GLFWwindow* window, int value);
GLFWAPI void glfwSetWindowTitle(GLFWwindow* window, const char* title);
GLFWAPI void glfwGetWindowPos(GLFWwindow* window, int* xpos, int* ypos);
GLFWAPI void glfwSetWindowPos(GLFWwindow* window, int xpos, int ypos);
GLFWAPI void glfwGetWindowSize(GLFWwindow* window, int* width, int* height);
GLFWAPI void glfwSetWindowSize(GLFWwindow* window, int width, int height);
GLFWAPI void glfwGetFramebufferSize(GLFWwindow* window, int* width, int* height);
GLFWAPI void glfwGetWindowFrameSize(GLFWwindow* window, int* left, int* top, int* right, int* bottom);
GLFWAPI void glfwIconifyWindow(GLFWwindow* window);
GLFWAPI void glfwRestoreWindow(GLFWwindow* window);
GLFWAPI void glfwShowWindow(GLFWwindow* window);
GLFWAPI void glfwHideWindow(GLFWwindow* window);
GLFWAPI GLFWmonitor* glfwGetWindowMonitor(GLFWwindow* window);
GLFWAPI int glfwGetWindowAttrib(GLFWwindow* window, int attrib);
GLFWAPI void glfwSetWindowUserPointer(GLFWwindow* window, void* pointer);
GLFWAPI void* glfwGetWindowUserPointer(GLFWwindow* window);
GLFWAPI GLFWwindowposfun glfwSetWindowPosCallback(GLFWwindow* window, GLFWwindowposfun cbfun);
GLFWAPI GLFWwindowsizefun glfwSetWindowSizeCallback(GLFWwindow* window, GLFWwindowsizefun cbfun);
GLFWAPI GLFWwindowclosefun glfwSetWindowCloseCallback(GLFWwindow* window, GLFWwindowclosefun cbfun);
GLFWAPI GLFWwindowrefreshfun glfwSetWindowRefreshCallback(GLFWwindow* window, GLFWwindowrefreshfun cbfun);
GLFWAPI GLFWwindowfocusfun glfwSetWindowFocusCallback(GLFWwindow* window, GLFWwindowfocusfun cbfun);
GLFWAPI GLFWwindowiconifyfun glfwSetWindowIconifyCallback(GLFWwindow* window, GLFWwindowiconifyfun cbfun);
GLFWAPI GLFWframebuffersizefun glfwSetFramebufferSizeCallback(GLFWwindow* window, GLFWframebuffersizefun cbfun);


GLFWAPI void glfwPostEmptyEvent(void);
GLFWAPI int glfwGetInputMode(GLFWwindow* window, int mode);
GLFWAPI void glfwSetInputMode(GLFWwindow* window, int mode, int value);

GLFWAPI int glfwGetMouseButton(GLFWwindow* window, int button);
GLFWAPI void glfwGetCursorPos(GLFWwindow* window, double* xpos, double* ypos);
GLFWAPI void glfwSetCursorPos(GLFWwindow* window, double xpos, double ypos);
GLFWAPI GLFWcursor* glfwCreateCursor(const GLFWimage* image, int xhot, int yhot);
GLFWAPI GLFWcursor* glfwCreateStandardCursor(int shape);
GLFWAPI void glfwDestroyCursor(GLFWcursor* cursor);
GLFWAPI void glfwSetCursor(GLFWwindow* window, GLFWcursor* cursor);
GLFWAPI GLFWkeyfun glfwSetKeyCallback(GLFWwindow* window, GLFWkeyfun cbfun);
GLFWAPI GLFWcharfun glfwSetCharCallback(GLFWwindow* window, GLFWcharfun cbfun);
GLFWAPI GLFWcharmodsfun glfwSetCharModsCallback(GLFWwindow* window, GLFWcharmodsfun cbfun);
GLFWAPI GLFWmousebuttonfun glfwSetMouseButtonCallback(GLFWwindow* window, GLFWmousebuttonfun cbfun);
GLFWAPI GLFWcursorposfun glfwSetCursorPosCallback(GLFWwindow* window, GLFWcursorposfun cbfun);
GLFWAPI GLFWcursorenterfun glfwSetCursorEnterCallback(GLFWwindow* window, GLFWcursorenterfun cbfun);
GLFWAPI GLFWscrollfun glfwSetScrollCallback(GLFWwindow* window, GLFWscrollfun cbfun);
GLFWAPI GLFWdropfun glfwSetDropCallback(GLFWwindow* window, GLFWdropfun cbfun);
GLFWAPI int glfwJoystickPresent(int joy);
GLFWAPI const float* glfwGetJoystickAxes(int joy, int* count);
GLFWAPI const unsigned char* glfwGetJoystickButtons(int joy, int* count);
GLFWAPI const char* glfwGetJoystickName(int joy);
GLFWAPI void glfwSetClipboardString(GLFWwindow* window, const char* string);
GLFWAPI const char* glfwGetClipboardString(GLFWwindow* window);
GLFWAPI double glfwGetTime(void);
GLFWAPI void glfwSetTime(double time);

GLFWAPI GLFWwindow* glfwGetCurrentContext(void);

GLFWAPI int glfwExtensionSupported(const char* extension);
GLFWAPI GLFWglproc glfwGetProcAddress(const char* procname);

--}

public
glfwSwapInterval : Int -> IO ()
glfwSwapInterval interval = foreign FFI_C "glfwSwapInterval" (Int -> IO ()) interval

