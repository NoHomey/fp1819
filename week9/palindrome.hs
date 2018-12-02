reverse' :: Int -> Int
reverse' number = helper 0 number
  where helper accum number = if (number == 0)
                              then accum
                              else helper (10 * accum + (number `mod` 10)) (number `div` 10)

palindrome :: Int -> Bool
palindrome number = number == reverse' number
