module Data.Matrix.Transformation

import Data.Matrix
import Data.Floats
import Control.Algebra
--import Data.Vect as V

--- 3D Transformation Matrices
--- 

%access public

-- ----------------------------------------------------------------- [ Effects ]

data Angle = Radians Double | Degree Double

private
getRadians : Angle -> Double
getRadians (Radians a) = a
getRadians (Degree a)  = a * pi / 180

Pos : Type
Pos = Vect 3 Double

TransformationMatrix : Type
TransformationMatrix = Matrix 4 4 Double

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
{--
perspectiveProjection fov aspect (near, far) = [ 
           [    1.0/(aspect*tanHalfFovy),      0,     0,     0  ],
           [       0,      1.0/tanHalfFovy,             0,     0  ],
           [       0,      0,     -(far+near)/(far-near),     -2*far*near/(far-near) ],
           [       0,      0,     -1,     0  ]
           ]
           where tanHalfFovy    = tan((getRadians fov)/ 2)
--}
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

                 
(+): Num a => (Vect n a) -> (Vect n a) -> (Vect n a) 
(+) v1 v2 = zipWith (+) v1 v2

(-): Num a => (Vect n a) -> (Vect n a) -> (Vect n a) 
(-) v1 v2 = zipWith (-) v1 v2

cross: Vect 3 Double -> Vect 3 Double -> Vect 3 Double
cross (x1 :: x2 :: x3 :: []) (y1 :: y2 :: y3 :: []) = [x2*y3-x3*y2, x3*y1-x1*y3, x1*y2-x2*y1]
                 
                 
scalar : Double -> Vect n Double -> Vect n Double
scalar s v = map (\e => s*e) v
                 

||| normalizes a vector to a unit vector                  
normalize : Vect n Double -> Vect n Double
normalize v = map (\e => e / l ) v
              where l = sqrt $ v <:> v
                 
||| transformation matrix to transform from world coordinates to view coordinates
||| @ eye position of the viewer
||| @ center where the camera aims
||| @ up up direction for the viewer                 
--viewMatrix : (eye: Pos) -> (center: Pos) -> (up: Pos) -> TransformationMatrix
viewMatrix : (eye: Pos) -> (center: Pos) -> (up: Pos) -> Matrix 4 4 Double
--viewMatrix eye center up = (transpose m) ++ [[(-1 * (s <:> eye)), (-1 * (u <:> eye)), (-1 * (f <:> eye)), 1]]
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
                               

{--
detail::tvec3<T, P> const f(normalize(center - eye));
		detail::tvec3<T, P> const s(normalize(cross(f, up)));
		detail::tvec3<T, P> const u(cross(s, f));

		detail::tmat4x4<T, P> Result(1);
		Result[0][0] = s.x;
		Result[1][0] = s.y;
		Result[2][0] = s.z;
		Result[0][1] = u.x;
		Result[1][1] = u.y;
		Result[2][1] = u.z;
		Result[0][2] =-f.x;
		Result[1][2] =-f.y;
		Result[2][2] =-f.z;
		Result[3][0] =-dot(s, eye);
		Result[3][1] =-dot(u, eye);
		Result[3][2] = dot(f, eye);
		
mat4 LookAtRH( vec3 eye, vec3 target, vec3 up )
{
    vec3 zaxis = normal(eye - target);    // The "forward" vector.
    vec3 xaxis = normal(cross(up, zaxis));// The "right" vector.
    vec3 yaxis = cross(zaxis, xaxis);     // The "up" vector.
 
    // Create a 4x4 view matrix from the right, up, forward and eye position vectors
    mat4 viewMatrix = {
        vec4(      xaxis.x,            yaxis.x,            zaxis.x,       0 ),
        vec4(      xaxis.y,            yaxis.y,            zaxis.y,       0 ),
        vec4(      xaxis.z,            yaxis.z,            zaxis.z,       0 ),
        vec4(-dot( xaxis, eye ), -dot( yaxis, eye ), -dot( zaxis, eye ),  1 )
    };
     
    return viewMatrix;
}		
		
mat4 LookAtRH( vec3 eye, vec3 target, vec3 up )
{
    vec3 zaxis = normal(eye - target);    // The "forward" vector.
    vec3 xaxis = normal(cross(up, zaxis));// The "right" vector.
    vec3 yaxis = cross(zaxis, xaxis);     // The "up" vector.
 
    // Create a 4x4 orientation matrix from the right, up, and forward vectors
    // This is transposed which is equivalent to performing an inverse 
    // if the matrix is orthonormalized (in this case, it is).
    mat4 orientation = {
       vec4( xaxis.x, yaxis.x, zaxis.x, 0 ),
       vec4( xaxis.y, yaxis.y, zaxis.y, 0 ),
       vec4( xaxis.z, yaxis.z, zaxis.z, 0 ),
       vec4(   0,       0,       0,     1 )
    };
     
    // Create a 4x4 translation matrix.
    // The eye position is negated which is equivalent
    // to the inverse of the translation matrix. 
    // T(v)^-1 == T(-v)
    mat4 translation = {
        vec4(   1,      0,      0,   0 ),
        vec4(   0,      1,      0,   0 ), 
        vec4(   0,      0,      1,   0 ),
        vec4(-eye.x, -eye.y, -eye.z, 1 )
    };
 
    // Combine the orientation and translation to compute 
    // the final view matrix
    return ( orientation * translation );
}		
--}
defaultViewMatrix : TransformationMatrix
defaultViewMatrix = viewMatrix [0,0,-1] [0,0,0] [0,1,0]


toGl : TransformationMatrix -> Vect 16 Double
toGl m = concat $ transpose m
