filterCount :: (Int -> Bool) -> Int -> Int -> Int
filterCount pred a b
  | a > b     = 0
  | pred a    = 1 + filterCount pred (a + 1) b
  | otherwise = filterCount pred (a + 1) b
