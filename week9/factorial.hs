factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)

factorial' :: Int -> Int
factorial' n = helper 1 1 n                   -- можем да пропуснем n от двете страни тук и да запишем factorial' n = helper 1 1
  where helper accum i n = if (i > n)
                              then accum
                              else helper (i * accum) (i + 1) n
