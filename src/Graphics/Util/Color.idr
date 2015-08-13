module Graphics.Util.Color

%access public

data Color : Type where
  RGBA : (red: Double) -> (green: Double) -> (blue: Double) -> (alpha: Double) -> Color
  

 
