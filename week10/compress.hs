-- ще си говорим за Eq typeclass-a малко по-късно,
-- тази типова декларация означава, че за а са дефинирани операторите == и /=
-- може засега и compress :: [Int] -> [(Int, Int)] или compress :: [Char] -> [(Char, Int)]
compress :: (Eq a) => [a] -> [(a, Int)]
compress []  = []
compress lst =
  foldr
    (\element accum@((el, count) : rest) →        -- следният синтаксис при pattern matching - lst@(head : tail) ни позволява да реферираме целия списък чрез променливата lst
        then (element, (count + 1)) : rest
        else (element, 1) : accum)
    [(last lst, 1)]
    (init lst)          -- inti връща подадения му списък без последния му елемент
