-- ще си говорим за Eq typeclass-a малко по-късно,
-- тази типова декларация означава, че за а са дефинирани операторите == и /=
-- може засега и remdups :: [Int] -> [Int]
remdups :: (Eq a) => [a] -> [a]
remdups lst =
  foldr remdupsHelper [] lst
  where remdupsHelper element [] = [element]
        remdupsHelper element accum@(x:xs) =
          if (element == x)
            then accum
            else element:accum

-- същата логика, но използвайки case of синтаксиса, вместо
-- да дефинираме помощна функция
remdups' :: (Eq a) => [a] -> [a]
remdups' lst =
  foldr
    (\element accum ->
      case accum of
        [] -> [element]
        (x:xs) -> if (element == x)
                    then accum
                    else element:accum)
  []
  lst
