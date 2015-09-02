module Graphics.Util.Time

%include C "gl_idris.h"
%link C "gl_idris.o"

record Time where
  constructor MicroTime
  seconds : Int
  microseconds : Int

instance Show Time where
  show (MicroTime seconds useconds) = (show seconds) ++ "." ++ (show useconds)

||| get the current time as a pair of seconds and microseconds since epoch
currentTimeMicros : IO Time
currentTimeMicros 
    = do MkRaw e <- 
               foreign FFI_C "idr_currentTimeMicros" (Ptr -> IO (Raw (Time))) prim__vm
         return e

instance Eq Time where 
  (MicroTime s1 us1) == (MicroTime s2 us2) = s1 == s2 && us1 == us2

instance Ord Time where 
  compare (MicroTime s1 us1) (MicroTime s2 us2) = if (s1 < s2) then LT
                                                  else if (s1 > s2) then GT
                                                       else compare us1 us2
--difference : Time -> Time -> Integer
--difference (MicroTime s1 us1) (MicroTime s2 us2) = (s1 - s2) * 1000000 + (s)
