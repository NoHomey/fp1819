shift :: [a] -> [a]
shift []     = []
shift (x:xs) = xs ++ [x]

rotate :: [a] -> Int -> [a]
rotate lst 0 = lst
rotate lst i
  | i > 0 = shift (rotate lst (i - 1))
  | i < 0 = rotate lst (length lst + i)

rotations :: [a] -> [[a]]
rotations lst =
  foldr
  (\times accum -> (rotate lst times) : accum)
  []
  [0..(length lst - 1)]
