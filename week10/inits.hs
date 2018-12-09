inits :: [a] -> [[a]]
inits lst =
  foldr
  (\element accum ->
    []:(map (element:) accum))
  [[]]
  lst
