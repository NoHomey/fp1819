prime :: Int -> Bool
prime 1      = True
prime number = helper 2 number
  where divides a b = b `mod` a == 0
        helper i number
          | i == number      = True
          | divides i number = False
          | otherwise        = helper (i + 1) number

-- Хипотезата на Голдбах е, че
-- всяко четно цяло число по-голямо от 2 може да бъде изразено като сбор от две прости числа

-- намира двете прости числа, чиято сума е number
goldbach :: Int -> (Int, Int)
goldbach number = helper 1 number
  where helper i number
          | i == number                   = error "Goldbach was wrong!!1!"
          | prime i && prime (number - i) = (i, number - i)
          | otherwise                     = helper (i + 1) number
