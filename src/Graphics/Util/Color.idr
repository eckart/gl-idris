module Graphics.Util.Color

%access public export

data Color : Type where
  RGBA : (red: Double) -> (green: Double) -> (blue: Double) -> (alpha: Double) -> Color
  

 
