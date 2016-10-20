module Graphics.Util.Transforms

import Data.So
import Data.Matrix
import Data.Matrix.Algebraic
import Data.Vect
import Control.Algebra
import Debug.Trace

%access public export

-- ----------------------------------------------------------------- [ Types ]

data Angle = Radians Double | Degree Double

Pos : Type
Pos = Vect 3 Double

TransformationMatrix : Type
TransformationMatrix = Matrix 4 4 Double

vmult : Matrix n m Double -> Vect m Double -> Vect n Double
vmult m v = map (<:> v) m

-- ----------------------------------------------------------------- [ Utilities ]
data Interval : Type where
   MkInterval : (lower : Double) -> (upper : Double) ->
                So (lower < upper) -> Interval
                
                
pattern syntax "[" [x] "..." [y] "]" = MkInterval x y Oh
term    syntax "[" [x] "..." [y] "]" = MkInterval x y ?bounds_lemma

                
UnitInterval : Interval
UnitInterval = MkInterval 0.0 1.0 Oh
                                                
clamp : Double -> Interval -> Double
clamp val (MkInterval lower upper _) = 
  if val < lower
  then lower
  else if val > upper
       then upper
       else val

-- ----------------------------------------------------------------- [ Angles ]

export
getRadians : Angle -> Double
getRadians (Radians a) = a
getRadians (Degree a)  = a * pi / 180

private
cosA : Angle -> Double
cosA a = cos $ getRadians a

private
sinA : Angle -> Double
sinA a = sin $ getRadians a

-- ----------------------------------------------------------------- [ Vectors + Matrices ]

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
||| @ eye where the camera aims - a vector
||| @ center location of the center of the camera
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
                               
||| a view matrix where the camera is located at the origin and points down the z-axis
||| while the y-axis is the "up" direction
defaultViewMatrix : TransformationMatrix
defaultViewMatrix = viewMatrix [0,0,-1] [0,0,0] [0,1,0]

||| a view matrix for a camer located at the origin
||| @ eye direction of the camera (where the camera is pointing)
standardViewMatrix : (eye: Pos) -> TransformationMatrix
standardViewMatrix eye = viewMatrix eye [0,0,0] [0,1,0]


-- ----------------------------------------------------------------- [ Quaternions ]


-- Quaternions
-- TODO: introduce a separate type for unit quaternions
namespace Quaternions
  
  record Quaternion where
    constructor Q
    scalar : Double
    vector : Vect 3 Double
  
  realPart : Quaternion -> Double
  realPart = scalar

  imagPart : Quaternion -> Vect 3 Double
  imagPart = vector

  qnorm : Quaternion -> Double
  qnorm (Q s v) = let q = s :: v
                  in norm q


  implementation Show Quaternion where
    show (Q s (v1 :: v2 :: v3 :: [])) = (show s)++" + " ++ (show v1) ++"i + "++ (show v2) ++ "k + "++ (show v3)++"j"

  implementation Eq Quaternion where
    (==) q p = realPart q == realPart p && imagPart q == imagPart p

  ||| returns the quaternion as a 4 dimensional Vector with the scalar part last
  ||| this corresponds to the representation as a (x,y,z,w) vector
  toVect : Quaternion -> Vect 4 Double
  toVect (Q s v) = v ++ [s] 

  fromVect : Vect 4 Double -> Quaternion
  fromVect (x :: y :: z :: w :: Nil) = Q w [x, y, z]

  export
  fromAxis : (rotation: Angle) -> (axis: Vect 3 Double) -> Quaternion
  fromAxis rot (bx :: by :: bz :: Nil) = 
    let a = (getRadians rot) / 2
    in Q (cos a) [(sin a)*bx, (sin a)*by, (sin a)*bz]

  toMatrix : Quaternion -> TransformationMatrix
  toMatrix q@(Q w (x :: y :: z :: Nil)) = 
    let s = 2 / (qnorm q)
    in [
       [(1-s*(y*y+z*z)),     s*(x*y-w*z),       s*(x*z+w*y),   0],
       [    s*(x*y+w*z),  (1-s*(x*x+z*z)),      s*(y*z-w*x),   0],
       [    s*(x*z-w*y),     s*(y*z+w*x),    (1-s*(x*x+y*y)),  0],
       [              0,               0,                 0,   1]
       ]

  conjugate : Quaternion -> Quaternion
  conjugate (Q s v) = Q s (scalar (-1) v)

  qsum : Quaternion -> Quaternion -> Quaternion
  qsum (Q s1 v1) (Q s2 v2) = Q (s1+s2) (v1 <+> v2)

  qmultiply : Quaternion -> Quaternion -> Quaternion
  qmultiply (Q s1 v1) (Q s2 v2) = Q (s1*s2 - (dot v1 v2)) ( (scalar s1 v2) <+> (scalar s2 v1) <+> (cross v1 v2))

  qinverse : Quaternion -> Quaternion
  qinverse q@(Q s v) = let q' = s :: v
                           q'' = (1 / (q' <:> q'))
                       in Q (s / q'') (scalar q'' v)

  ||| Exponential e^q
  qexp : Quaternion -> Quaternion
  qexp (Q s v) = let n = norm v 
                     e = exp s
                 in Q (e * cos n) ( scalar ((sin n) / n) v) 

  qlog : Quaternion -> Quaternion
  qlog q@(Q s v) = let q' = qnorm q
                   in Q (log q') (scalar ((acos (s / q')) / (norm v)) v)
  
    
  qnormalize : Quaternion -> Quaternion
  qnormalize q = fromVect $ normalize (toVect q)                
  
  ||| x ^ y
  rpow : Double -> Double -> Double
  rpow y x = let e = x * (log (abs y))
             in if y < 0 
                then 1 / (exp e)
                else if y > 0
                     then exp e
                     else 1

  ||| q^t where t is a Real
  qpow : Quaternion -> Double -> Quaternion    
  qpow q@(Q s v) a = let e     = (rpow (qnorm q) a)
                         theta = acos (s / (qnorm q)) 
                     in Q (e * cos (s * theta)) (scalar (sin (s*theta)) v) 
  
  ||| scalar multiplication
  qscalar : Double -> Quaternion -> Quaternion
  qscalar s (Q w v) = Q (s*w) (scalar s v)                   

  data GimbalPole = NorthPole | SouthPole | NoPole

  ||| Get the pole of the gimbal lock, if any. 
  ||| If we have either a north pole or a south pole there is a gimbal lock
  gimbalPole : Quaternion -> GimbalPole
  gimbalPole (Q s v) = let v' = s :: v 
                           n' = v' <:> v' 
                       in if n' > 0.499
                          then NorthPole 
                          else if n' < -0.499 
                               then SouthPole
                               else NoPole

  gimbalMultiplier : GimbalPole -> Double
  gimbalMultiplier NoPole    = 0
  gimbalMultiplier NorthPole = 1
  gimbalMultiplier SouthPole = -1

  -- conversion between euler angles and quaternions
  -- see https://en.wikipedia.org/wiki/Conversion_between_quaternions_and_Euler_angles

  ||| the roll = rotation around x-axis
  export
  roll : Quaternion -> Angle 
  roll q = let q' = qnormalize q
               (Q w (x :: y :: z :: Nil)) = q' 
           in case (gimbalPole q) of
                   NoPole    => Radians $ atan2 (2*(w*z + y*x)) (1 - 2*(x*x+z*z)) 
                   p@(_)     => Radians $ (2 * (atan2 y w)) * (gimbalMultiplier p)

  ||| rotation around y-axis  
  export
  pitch : Quaternion -> Angle 
  pitch q = let q' = qnormalize q
                (Q w (x :: y :: z :: Nil)) = q' 
            in case (gimbalPole q) of
                    NoPole => Radians $ asin (2*(w*x - z*y)) -- might need clamping for asin
                    _      => Radians $ (pi / 2)

  ||| rotation around z-axis  
  export
  yaw : Quaternion -> Angle
  yaw q = let q' = qnormalize q
              (Q w (x :: y :: z :: Nil)) = q' 
          in case (gimbalPole q) of
                    NoPole => Radians $ atan2 (2*(y*w + x*z)) (1 - 2*(y*y + x*x))
                    _      => Radians $ 0

  ||| creates a quaternion from a vector of euler angles 
  export
  fromEulerAngles : Vect 3 Angle -> Quaternion
  fromEulerAngles (yaw :: pitch :: roll :: Nil) = 
    let yawR = (getRadians yaw) / 2; pitchR = (getRadians pitch) / 2; rollR = (getRadians roll) / 2
        w    = (cos yawR) * (cos pitchR) * (cos rollR) + (sin yawR) * (sin pitchR) * (sin rollR)
        x    = (cos yawR) * (sin pitchR) * (cos rollR) + (sin yawR) * (cos pitchR) * (sin rollR)
        y    = (sin yawR) * (cos pitchR) * (cos rollR) - (cos yawR) * (sin pitchR) * (sin rollR)
        z    = (cos yawR) * (cos pitchR) * (sin rollR) - (sin yawR) * (sin pitchR) * (cos rollR)
    in (Q w [x,y,z])    

  export
  toEulerAngles : Quaternion -> Vect 3 Angle
  toEulerAngles q = [roll q, pitch q, yaw q]

  export
  fromCross : Vect 3 Double -> Vect 3 Double-> Quaternion
  fromCross v1 v2 = let theta = acos (dot (normalize v1) (normalize v2))
                        vec   = cross (normalize v1) (normalize v2)
                    in fromAxis (Radians theta) vec    


  {--
  slerpBetween : Vect (S n) Quaternion -> Quaternion
  slerpBetween qs = ?slerpBetween

  slerpBetweenWeighted : Vect (S n) (Quaternion, Double) -> Quaternion
  slerpBetweenWeighted qs = ?slerpBetweenWeighted
  --}

  -- ----------------------------------------------------------------- [ Algenbraic Classes for Quaternions ]

  implementation Semigroup Quaternion where
    (<+>) = qsum

  implementation Monoid Quaternion where
    neutral = Q 0 [0, 0, 0]

  implementation Group Quaternion where
    inverse (Q s v) = Q (-1*s) (scalar (-1) v)

  implementation AbelianGroup Quaternion where {}

  implementation Ring Quaternion where
    (<.>) = qmultiply

  implementation RingWithUnity Quaternion where
    unity = Q 1 [0,0,0]

  implementation Num Quaternion where
    (+) = qsum
    (*) = qmultiply
    fromInteger x = Q (fromInteger x) [0,0,0]

  
  implementation Field Quaternion where 
    inverseM q _ = qinverse q

  -- ----------------------------------------------------------------- [ Quaternion Rotation ]

  qrotate : Vect 3 Double -> Quaternion -> Vect 3 Double
  qrotate v q = let p  = Q 0 v        -- make the vector a quaternion
                    q' = qnormalize q -- normalize the rotation quaternion (until we have unit quaternions as a type)
                    in imagPart $ q' <.> p <.> (conjugate q')

  ||| linear interpolation of quaternions
  ||| TODO handle corner cases (sintheta < 0.00001)
  slerp : Quaternion -> Quaternion -> Double -> Quaternion
  slerp q0 q1 t = let n1 = qnormalize q0
                      n2 = qnormalize q1
                      theta = acos ((toVect n1) <:> (toVect n2))
                      sintheta = sin theta
                      weight1 = (sin (theta * (1-t))) / sintheta
                      weight2 = (sin (theta*t)) / sintheta
                  in ((qscalar weight1 n1) + (qscalar weight2 n2))
                  
{--
// if theta = 180 degrees then result is not fully defined
	// we could rotate around any axis normal to qa or qb
	if (fabs(sinHalfTheta) < 0.001){ // fabs is floating point absolute
		qm.w = (qa.w * 0.5 + qb.w * 0.5);
		qm.x = (qa.x * 0.5 + qb.x * 0.5);
		qm.y = (qa.y * 0.5 + qb.y * 0.5);
		qm.z = (qa.z * 0.5 + qb.z * 0.5);
		return qm;
	}                  
--}                     

{--
#define SLERP_TO_LERP_SWITCH_THRESHOLD 0.01f

Quaternion Quaternion_slerp(Quaternion left, Quaternion right, float value) {
	float leftWeight, rightWeight, difference;
	Quaternion result;
	
	difference = left.x * right.x + left.y * right.y + left.z * right.z + left.w * right.w;
	if (1.0f - fabs(difference) > SLERP_TO_LERP_SWITCH_THRESHOLD) {
		float theta, oneOverSinTheta;
		
		theta = acos(fabs(difference));
		oneOverSinTheta = 1.0f / sin(theta);
		leftWeight = sin(theta * (1.0f - value)) * oneOverSinTheta;
		rightWeight = sin(theta * value) * oneOverSinTheta;
		if (difference < 0.0f) {
			leftWeight = -leftWeight;
		}
	} else {
		leftWeight = 1.0f - value;
		rightWeight = value;
	}
	result.x = left.x * leftWeight + right.x * rightWeight;
	result.y = left.y * leftWeight + right.y * rightWeight;
	result.z = left.z * leftWeight + right.z * rightWeight;
	result.w = left.w * leftWeight + right.w * rightWeight;
	Quaternion_normalize(&result);
	
	return result;
}
--}
