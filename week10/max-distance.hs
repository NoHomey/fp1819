maxDistance :: [(Double, Double)] -> Double
maxDistance points = maximum [ distance point1 point2 | point1 <- points, point2 <- points]
  where distance (a, b) (c, d) = sqrt (((abs (a - c)) ^ 2) + ((abs (b - d)) ^ 2))
