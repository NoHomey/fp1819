doubleFactorial :: Int -> Int
doubleFactorial 1 = 1
doubleFactorial 2 = 2
doubleFactorial n = n * doubleFactorial (n - 2)

doubleFactorial' :: Int -> Int
doubleFactorial' n
  | odd n     = helper 1 1 n
  | otherwise = helper 1 2 n
  where helper accum i n = if (i > n)
                              then accum
                              else helper (i * accum) (i + 2) n
