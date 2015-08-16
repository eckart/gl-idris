module Graphics.Util.Transforms

import Data.Matrix
import Data.Floats
import Data.Vect
import Control.Algebra

%access public

-- ----------------------------------------------------------------- [ Types ]

data Angle = Radians Double | Degree Double

Pos : Type
Pos = Vect 3 Double

TransformationMatrix : Type
TransformationMatrix = Matrix 4 4 Double

-- ----------------------------------------------------------------- [ Math support function ]

private
getRadians : Angle -> Double
getRadians (Radians a) = a
getRadians (Degree a)  = a * pi / 180

||| 3D Vector cross product
cross: Pos -> Pos -> Pos
cross (x1 :: x2 :: x3 :: []) (y1 :: y2 :: y3 :: []) = [x2*y3-x3*y2, x3*y1-x1*y3, x1*y2-x2*y1]

dot: Pos -> Pos -> Double
dot x y = x <:> y
                 
||| scalar multiplication
scalar : Double -> Vect n Double -> Vect n Double
scalar s v = map (\e => s*e) v
                 
                 
norm : Vect n Double -> Double
norm v = sqrt $ v <:> v             
     
||| normalizes a vector to a unit vector                  
normalize : Vect n Double -> Vect n Double
normalize v = map (\e => e / l ) v
              where l = norm v
                 
||| convert to a row major List 
toGl : TransformationMatrix -> Vect 16 Double
toGl m = concat $ transpose m

-- ----------------------------------------------------------------- [ Transformation Matrices ]

identity : TransformationMatrix
identity = [
           [1, 0, 0, 0],
           [0, 1, 0, 0],
           [0, 0, 1, 0],
           [0, 0, 0, 1]
           ]

translate : Pos -> TransformationMatrix
translate (x :: y :: z :: []) = [           
           [1, 0, 0, x],
           [0, 1, 0, y],
           [0, 0, 1, z],
           [0, 0, 0, 1]
           ]

scale : Pos -> TransformationMatrix
scale (sx :: sy :: sz :: []) = [           
           [sx, 0,  0, 0],
           [0, sy,  0, 0],
           [0,  0, sz, 0],
           [0,  0,  0, 1]
           ]
           
scaleAll : Double -> TransformationMatrix
scaleAll s = scale [s, s, s]

rotateX : Angle -> TransformationMatrix
rotateX angle = [           
           [1,       0,         0,  0],
           [0,  (cos a),  -(sin a), 0],
           [0,  (sin a),   (cos a), 0],
           [0,       0,         0,  1]
           ]
           where a = getRadians angle

rotateY : Angle -> TransformationMatrix
rotateY angle = [           
           [  (cos a),       0, (sin a),  0],
           [       0 ,       1,      0 ,  0],
           [ -(sin a),       0, (cos a),  0],
           [       0 ,       0,      0 ,  1]
           ]
           where a = getRadians angle


rotateZ : Angle -> TransformationMatrix
rotateZ angle = [           
           [  (cos a), -(sin a), 0,  0],
           [  (sin a),  (cos a), 0,  0],
           [       0 ,       0 , 1,  0],
           [       0 ,       0,  0,  1]
           ]
           where a = getRadians angle

rotate : Vect 3 Angle -> TransformationMatrix
rotate (ax :: ay :: az :: []) = (rotateX ax) <> (rotateY ay) <> (rotateZ az)

-- ----------------------------------------------------------------- [ Projection Matrices ]

orthographicProjection : (Double, Double) -> (Double, Double) -> (Double, Double) -> TransformationMatrix
orthographicProjection (right, left) (top, bottom) (near, far) = [           
           [ 2/(right-left),              0,             0,  -(right + left)/ (right-left)],
           [       0,        2/(top-bottom),             0,  -(top+bottom)  / (top-bottom)],
           [       0,                     0, -2/(far-near),  -(far+near)    / (far-near)  ],
           [       0,                     0,             0,                1              ]
           ]

||| Matrix for Perspective Projection
||| @ fov    field of view / viewing angle
||| @ aspect aspect ration for the projection
||| @ clipping near and far clipping planes
perspectiveProjection : (fov: Angle) -> (aspect: Double) -> (clipping: (Double, Double)) -> TransformationMatrix
perspectiveProjection fov aspect (near, far) = [ 
           [ 2 * near/(right-left),                    0,  (right + left)/ (right-left),              0                ],
           [       0,                2*near/(top-bottom),  (top+bottom)  / (top-bottom),              0                ],
           [       0,                                  0, -(far+near)    / (far - near), -2 * far * near / (far - near)],
           [       0,                                  0,               -1             ,              0                ]
           ]
           where top    = near * tan((getRadians fov)/ 2)
                 bottom = -top
                 right  = top * aspect
                 left   = -right

                 
||| transformation matrix to transform from world coordinates to view coordinates
||| @ eye position of the viewer
||| @ center where the camera aims - a vector
||| @ up up direction for the viewer                 
viewMatrix : (eye: Pos) -> (center: Pos) -> (up: Pos) -> TransformationMatrix
viewMatrix eye center up = (transpose m) ++ [v] 
                           where
                               f : Pos
                               f = normalize (eye <-> center)
                               s : Pos
                               s = normalize (cross f up)
                               u : Pos
                               u = cross s f
                               m : Matrix 4 3 Double
                               m = [s, u, (scalar (-1) f), [0,0,0]]
                               v : Vect 4 Double
                               v = [0,0,0,1]
                               

defaultViewMatrix : TransformationMatrix
defaultViewMatrix = viewMatrix [0,0,-1] [0,0,0] [0,1,0]


-- ----------------------------------------------------------------- [ Quaternions ]

record Quaternion where
  constructor Q
  scalar : Double
  vector : Vect 3 Double

instance Show Quaternion where
  show (Q s (v1 :: v2 :: v3 :: [])) = (show s)++" + " ++ (show v1) ++"i + "++ (show v2) ++ "k + "++ (show v3)++"j"

||| returns the quaternion as a 4 dimensional Vector with the scalar part last
||| this corresponds to the representation as a (x,y,z,w) vector
toVect : Quaternion -> Vect 4 Double
toVect (Q s v) = v ++ [s] 

fromVect : Vect 4 Double -> Quaternion
fromVect (x :: y :: z :: w :: Nil) = Q w [x, y, z]

conjugate : Quaternion -> Quaternion
conjugate (Q s v) = Q s (scalar (-1) v)

qsum : Quaternion -> Quaternion -> Quaternion
qsum (Q s1 v1) (Q s2 v2) = Q (s1+s2) (v1 <+> v2)

qmultiply : Quaternion -> Quaternion -> Quaternion
qmultiply (Q s1 v1) (Q s2 v2) = Q (s1*s2 - (dot v1 v2)) ( (scalar s1 v2) <+> (scalar s2 v1) <+> (cross v1 v2))

qnorm : Quaternion -> Double
qnorm (Q s v) = let q = s :: v
                in norm q

qinverse : Quaternion -> Quaternion
qinverse q@(Q s v) = let q' = s :: v
                         q'' = (1 / (q' <:> q'))
                     in Q (s / q'') (scalar q'' v)
