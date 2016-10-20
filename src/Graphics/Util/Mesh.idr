module Graphics.Util.Mesh

import Data.Vect 

%access public export
%default total
Vec2 : Type
Vec2 = Vect 2 Double

Vec3 : Type
Vec3 = Vect 3 Double

Vec4 : Type
Vec4 = Vect 4 Double

||| a data type for meshes.
|||
||| a mesh is a collection of positions, of UV texture coordinates, vertex normals and indices
||| 
data Mesh : Type where
  UvMesh :  (positions: Vect n Vec3)
         -> (normals: Vect n Vec3) 
         -> (uvs: Vect n Vec2)
         -> (indices: List Int)
         -> Mesh

positions : Mesh -> List Vec3
positions (UvMesh p _ _ _) = toList p

indices : Mesh -> List Int
indices (UvMesh _ _ _ xs) = xs
