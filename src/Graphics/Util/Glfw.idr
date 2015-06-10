module Graphics.Util.Glfw

import Graphics.Rendering.Config

%include C "gl_idris.h"
%include C "GLFW/glfw3.h"
%link C "gl_idris.o"

%access private

||| Glfw Window
abstract
data Window = Win Ptr

class GlfwConstant a b where
  toInt   : a -> b
  fromInt : b -> a

public
data KeyEventTy
  = GLFW_PRESS
  | GLFW_RELEASE
  | GLFW_REPEAT

instance GlfwConstant KeyEventTy Int where
  toInt   GLFW_PRESS   = 1
  toInt   GLFW_RELEASE = 0
  toInt   GLFW_REPEAT  = 2
  fromInt 1            = GLFW_PRESS
  fromInt 0            = GLFW_RELEASE 
  fromInt 2            = GLFW_REPEAT

-- | Special key is a key not represented in the 32 - 127 printable ASCII range.
public
data SpecialKey
  = UNKNOWN
  | ESC
  | F1
  | F2
  | F3
  | F4
  | F5
  | F6
  | F7
  | F8
  | F9
  | F10
  | F11
  | F12
  | F13
  | F14
  | F15
  | F16
  | F17
  | F18
  | F19
  | F20
  | F21
  | F22
  | F23
  | F24
  | F25
  | UP
  | DOWN
  | LEFT
  | RIGHT
  | LSHIFT
  | RSHIFT
  | LCTRL
  | RCTRL
  | LALT
  | RALT
  | TAB
  | ENTER
  | BACKSPACE
  | INSERT
  | DEL
  | PAGEUP
  | PAGEDOWN
  | HOME
  | END
  | KP_0
  | KP_1
  | KP_2
  | KP_3
  | KP_4
  | KP_5
  | KP_6
  | KP_7
  | KP_8
  | KP_9
  | KP_DIVIDE
  | KP_MULTIPLY
  | KP_SUBTRACT
  | KP_ADD
  | KP_DECIMAL
  | KP_EQUAL
  | KP_ENTER

instance GlfwConstant SpecialKey Int where
  toInt UNKNOWN     = -1
  toInt ESC         = 257
  toInt F1          = 258
  toInt F2          = 259
  toInt F3          = 260
  toInt F4          = 261
  toInt F5          = 262
  toInt F6          = 263
  toInt F7          = 264
  toInt F8          = 265
  toInt F9          = 266
  toInt F10         = 267
  toInt F11         = 268
  toInt F12         = 269
  toInt F13         = 270
  toInt F14         = 271
  toInt F15         = 272
  toInt F16         = 273
  toInt F17         = 274
  toInt F18         = 275
  toInt F19         = 276
  toInt F20         = 277
  toInt F21         = 278
  toInt F22         = 279
  toInt F23         = 280
  toInt F24         = 281
  toInt F25         = 282
  toInt UP          = 283
  toInt DOWN        = 284
  toInt LEFT        = 285
  toInt RIGHT       = 286
  toInt LSHIFT      = 287
  toInt RSHIFT      = 288
  toInt LCTRL       = 289
  toInt RCTRL       = 290
  toInt LALT        = 291
  toInt RALT        = 292
  toInt TAB         = 293
  toInt ENTER       = 294
  toInt BACKSPACE   = 295
  toInt INSERT      = 296
  toInt DEL         = 297
  toInt PAGEUP      = 298
  toInt PAGEDOWN    = 299
  toInt HOME        = 300
  toInt END         = 301
  toInt KP_0        = 302
  toInt KP_1        = 303
  toInt KP_2        = 304
  toInt KP_3        = 305
  toInt KP_4        = 306
  toInt KP_5        = 307
  toInt KP_6        = 308
  toInt KP_7        = 309
  toInt KP_8        = 310
  toInt KP_9        = 311
  toInt KP_DIVIDE   = 312
  toInt KP_MULTIPLY = 313
  toInt KP_SUBTRACT = 314
  toInt KP_ADD      = 315
  toInt KP_DECIMAL  = 316
  toInt KP_EQUAL    = 317
  toInt KP_ENTER    = 318
  fromInt 257 = ESC
  fromInt 258 = F1
  fromInt 259 = F2
  fromInt 260 = F3
  fromInt 261 = F4
  fromInt 262 = F5
  fromInt 263 = F6
  fromInt 264 = F7
  fromInt 265 = F8
  fromInt 266 = F9
  fromInt 267 = F10
  fromInt 268 = F11
  fromInt 269 = F12
  fromInt 270 = F13
  fromInt 271 = F14
  fromInt 272 = F15
  fromInt 273 = F16
  fromInt 274 = F17
  fromInt 275 = F18
  fromInt 276 = F19
  fromInt 277 = F20
  fromInt 278 = F21
  fromInt 279 = F22
  fromInt 280 = F23
  fromInt 281 = F24
  fromInt 282 = F25
  fromInt 283 = UP
  fromInt 284 = DOWN
  fromInt 285 = LEFT
  fromInt 286 = RIGHT
  fromInt 287 = LSHIFT
  fromInt 288 = RSHIFT
  fromInt 289 = LCTRL
  fromInt 290 = RCTRL
  fromInt 291 = LALT
  fromInt 292 = RALT
  fromInt 293 = TAB
  fromInt 294 = ENTER
  fromInt 295 = BACKSPACE
  fromInt 296 = INSERT
  fromInt 297 = DEL
  fromInt 298 = PAGEUP
  fromInt 299 = PAGEDOWN
  fromInt 300 = HOME
  fromInt 301 = END
  fromInt 302 = KP_0
  fromInt 303 = KP_1
  fromInt 304 = KP_2
  fromInt 305 = KP_3
  fromInt 306 = KP_4
  fromInt 307 = KP_5
  fromInt 308 = KP_6
  fromInt 309 = KP_7
  fromInt 310 = KP_8
  fromInt 311 = KP_9
  fromInt 312 = KP_DIVIDE
  fromInt 313 = KP_MULTIPLY
  fromInt 314 = KP_SUBTRACT
  fromInt 315 = KP_ADD
  fromInt 316 = KP_DECIMAL
  fromInt 317 = KP_EQUAL
  fromInt 318 = KP_ENTER
  fromInt _   = UNKNOWN

public
data GlfwFlags 
  = GLFW_STICKY_KEYS   
  
instance GlfwConstant GlfwFlags Int where 
  toInt   GLFW_STICKY_KEYS = 0x00033002  
  fromInt 0x00033002       = GLFW_STICKY_KEYS

instance GlfwConstant Bool Int where
  toInt   True  = 1
  toInt   False = 0
  fromInt 1     = True
  fromInt 0     = False

-- GLFW from here  
public 
createWindow : (title: String) -> (width: Int) -> (height: Int) -> IO Window
createWindow title width height = 
  do ptr <- foreign FFI_C "idr_glfw_create_window" (String -> Int -> Int -> IO Ptr) title width height
     pure $ Win ptr

public 
makeContextCurrent : Window -> IO ()
makeContextCurrent (Win ptr) = foreign FFI_C "glfwMakeContextCurrent" (Ptr -> IO()) ptr


public 
closeWindow : Window -> IO ()
closeWindow (Win ptr) = foreign FFI_C "glfwDestroyWindow" (Ptr -> IO()) ptr

public 
terminate : Window -> IO ()
terminate win = do makeContextCurrent win
                   closeWindow win
                   foreign FFI_C "glfwTerminate" (IO ())

public
swapBuffers : Window -> IO ()
swapBuffers (Win ptr) = foreign FFI_C "glfwSwapBuffers" (Ptr -> IO()) ptr

public 
waitEvents : IO ()
waitEvents = foreign FFI_C "glfwWaitEvents" (IO ())

public 
pollEvents : IO ()
pollEvents = foreign FFI_C "glfwPollEvents" (IO ())

public 
setInputMode : Window -> GlfwFlags -> Int -> IO ()
setInputMode (Win ptr) flag val = foreign FFI_C "glfwSetInputMode" (Ptr -> Int -> Int -> IO ()) ptr (toInt flag) val

public 
getKey : Window -> SpecialKey -> IO KeyEventTy
getKey (Win ptr) k = do e <- foreign FFI_C "glfwGetKey" (Ptr -> Int -> IO Int) ptr (toInt k)
                        pure $ fromInt e
                        
public 
windowShouldClose : Window -> IO Bool
windowShouldClose (Win ptr) = do flag <- foreign FFI_C "glfwWindowShouldClose" (Ptr -> IO Int) ptr
                                 let bool = if flag == 0 then False else True
                                 pure bool
