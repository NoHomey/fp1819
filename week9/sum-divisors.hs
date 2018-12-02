sumDivisors :: Int -> Int
sumDivisors number = helper 1 number
  where divides a b = b `mod` a == 0
        helper i number
          | i > number       = 0
          | divides i number = i + helper (i + 1) number
          | otherwise        = helper (i + 1) number
