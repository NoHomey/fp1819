fibonacci :: Int -> Int
fibonacci 1 = 0
fibonacci 2 = 1
fibonacci n = (fibonacci (n - 1)) + (fibonacci (n - 2))

fibonacci' :: Int -> Int
fibonacci' n = helper 0 1 1 n                   -- можем да пропуснем n от двете страни и да запишем fibonacci' = helper 0 1 1
  where helper curr next i n = if (i == n)
                               then curr
                               else helper next (curr + next) (i + 1) n
