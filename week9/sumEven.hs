sumEven :: Int -> Int -> Int
sumEven start end
  | start > end = 0
  | even start  = start + sumEven (start + 1) end
  | otherwise   = sumEven (start + 1) end
