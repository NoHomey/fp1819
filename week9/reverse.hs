length' :: Int -> Int
length' number = if (number < 10)
                    then 1
                    else 1 + length' (number `div` 10)

reverse' :: Int -> Int
reverse' number
  | number < 10 = number
  | otherwise   = remainder * (10 ^ (length'' - 1)) + reverse' quotient
  where quotient = number `div` 10
        remainder = number `mod` 10
        length'' = length' number

reverse'' :: Int -> Int
reverse'' number = helper 0 number                     -- можем да пропуснем number от двете страни и да запишем reverse' = helper 0
  where helper accum number = if (number == 0)
                              then accum
                              else helper (10 * accum + (number `mod` 10)) (number `div` 10)
