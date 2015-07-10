module Data.Matrix.Transformation

import Data.Matrix
import Data.Floats
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


private
(+): Num a => (Vect n a) -> (Vect n a) -> (Vect n a) 
(+) v1 v2 = zipWith (+) v1 v2

private
(-): Num a => (Vect n a) -> (Vect n a) -> (Vect n a) 
(-) v1 v2 = zipWith (-) v1 v2


||| 3D Vector cross product
cross: Pos -> Pos -> Pos
cross (x1 :: x2 :: x3 :: []) (y1 :: y2 :: y3 :: []) = [x2*y3-x3*y2, x3*y1-x1*y3, x1*y2-x2*y1]
                 
||| scalar multiplication
scalar : Double -> Vect n Double -> Vect n Double
scalar s v = map (\e => s*e) v
                 
||| normalizes a vector to a unit vector                  
normalize : Vect n Double -> Vect n Double
normalize v = map (\e => e / l ) v
              where l = sqrt $ v <:> v
                 
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
||| @ center where the camera aims
||| @ up up direction for the viewer                 
viewMatrix : (eye: Pos) -> (center: Pos) -> (up: Pos) -> TransformationMatrix
viewMatrix eye center up = (transpose m) ++ [v] 
                           where
                               f : Pos
                               f = normalize (eye - center)
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


