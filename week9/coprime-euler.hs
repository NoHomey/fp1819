gcd' :: Int -> Int -> Int
gcd' a b
  | a == b = a
  | a > b  = gcd' (a - b) b
  | otherwise = gcd' a (b - a)

coprime :: Int -> Int -> Bool
coprime a b = gcd' a b == 1

-- Функцията на Ойлер се дефинира като
-- φ(n) = броя на естествените числа, ненадминаващи n и взаимно прости с n

-- прилага функцията на Ойлер над number
euler :: Int -> Int
euler number = helper 1 number
  where helper i number
          | i > number       = 0
          | coprime i number = 1 + helper (i + 1) number
          | otherwise        = helper (i + 1) number
