module Graphics.Rendering.Gl.Buffers

%include C "gl_idris.h"
%link C "gl_idris.o"

%access public export

free : Ptr -> IO ()
free ptr = foreign FFI_C "free" (Ptr -> IO ()) ptr

-- ----------------------------------------------------------------- [ Double Buffers ]
private
setDouble : Ptr -> (idx: Nat) -> Double -> IO ()
setDouble ptr idx d = foreign FFI_C "idr_buffers_set_double" (Ptr -> Int -> Double -> IO ()) ptr (cast idx) d

||| allocates a C-Array for n doubles
||| @n the number of doubles to store
doubleBuffer : (n: Int) -> IO Ptr
doubleBuffer n = foreign FFI_C "idr_buffers_double_buffer" (Int -> IO Ptr) n

||| convert a List of doubles to a C-Array
doublesToBuffer : List Double -> IO Ptr
doublesToBuffer xs = 
  do ptr <- doubleBuffer $ toIntNat $ length xs
     writeDoubleBuffer' ptr Z xs
     pure ptr
  where writeDoubleBuffer' : Ptr -> Nat -> List Double -> IO ()
        writeDoubleBuffer' ptr i []        = pure ()
        writeDoubleBuffer' ptr i (d :: ds) = do setDouble ptr i d 
                                                writeDoubleBuffer' ptr (S i) ds

||| the size of a C-double
sizeofDouble : IO Int
sizeofDouble = foreign FFI_C "idr_buffers_double_size" (IO Int)

-- ----------------------------------------------------------------- [ Float Buffers ]

private
setFloat : Ptr -> (idx: Nat) -> Double -> IO ()
setFloat ptr idx d = foreign FFI_C "idr_buffers_set_float" (Ptr -> Int -> Double -> IO ()) ptr (cast idx) d

||| allocates a C-Array of floats for n doubles
||| @n the number of doubles to store
floatBuffer : (n: Int) -> IO Ptr
floatBuffer n = foreign FFI_C "idr_buffers_float_buffer" (Int -> IO Ptr) n

||| converts n Doubles to a C-Array containing n floats
floatsToBuffer : List Double -> IO Ptr
floatsToBuffer xs =
  do ptr <- floatBuffer $ toIntNat $ length xs
     writeFloatBuffer' ptr Z xs
     pure ptr
  where writeFloatBuffer' : Ptr -> Nat -> List Double -> IO ()
        writeFloatBuffer' ptr i []        = pure ()
        writeFloatBuffer' ptr i (d :: ds) = do setFloat ptr i d 
                                               writeFloatBuffer' ptr (S i) ds

||| the size of a C-float
sizeofFloat : IO Int
sizeofFloat = foreign FFI_C "idr_buffers_float_size" (IO Int)

-- ----------------------------------------------------------------- [ String Buffers ]

private
setString : Ptr -> (idx: Nat) -> String -> IO ()
setString ptr idx str = foreign FFI_C "idr_buffers_set_string" (Ptr -> Int -> String -> IO ()) ptr (cast idx) str

stringBuffer : (n: Int) -> IO Ptr
stringBuffer n = foreign FFI_C "idr_buffers_string_buffer" (Int -> IO Ptr) n

||| convers n Strings to a C-Array 
stringsToBuffer : List String -> IO Ptr
stringsToBuffer xs = 
  do ptr <- stringBuffer $ toIntNat $ length xs
     writeStringBuffer' ptr Z xs
     pure ptr
  where writeStringBuffer' : Ptr -> Nat -> List String -> IO ()
        writeStringBuffer' ptr i []        = pure ()
        writeStringBuffer' ptr i (d :: ds) = do setString ptr i d 
                                                writeStringBuffer' ptr (S i) ds

freeStringBuffer : Ptr -> (n: Int) -> IO ()
freeStringBuffer ptr n = foreign FFI_C "idr_buffers_free_string_buffer" (Ptr -> Int -> IO ()) ptr n

-- ----------------------------------------------------------------- [ Int Buffers ]

private
setInt : Ptr -> (idx: Nat) -> Int -> IO ()
setInt ptr idx i = foreign FFI_C "idr_buffers_set_int" (Ptr -> Int -> Int -> IO ()) ptr (cast idx) i

private
readInt : Ptr -> (idx: Nat) -> IO Int
readInt ptr idx = foreign FFI_C "idr_buffers_read_int" (Ptr -> Int -> IO Int) ptr (cast idx)

||| allocates a C-Array for n ints
||| @n the number of ints to store
intBuffer : (n: Int) -> IO Ptr
intBuffer n = foreign FFI_C "idr_buffers_int_buffer" (Int -> IO Ptr) n

||| convers n Strings to a C-Array 
intsToBuffer : List Int -> IO Ptr
intsToBuffer xs = 
  do ptr <- intBuffer $ toIntNat $ length xs
     writeIntBuffer' ptr Z xs
     pure ptr
  where writeIntBuffer' : Ptr -> Nat -> List Int -> IO ()
        writeIntBuffer' ptr i []        = pure ()
        writeIntBuffer' ptr i (d :: ds) = do setInt ptr i d 
                                             writeIntBuffer' ptr (S i) ds

||| convert a C-Array of ints to a List
||| @ n how many ints to read from the buffer 
intBufferToList : Ptr -> (n: Int) -> IO (List Int)
intBufferToList ptr n = readIntBuffer' ptr [] (cast n)
  where readIntBuffer' : Ptr -> List Int -> Nat -> IO (List Int)
        readIntBuffer' ptr xs Z     = pure xs
        readIntBuffer' ptr xs (S k) = do x <- readInt ptr k 
                                         readIntBuffer' ptr (x :: xs) k 

||| the size of a C-int
sizeofInt : IO Int
sizeofInt = foreign FFI_C "idr_buffers_int_size" (IO Int)


