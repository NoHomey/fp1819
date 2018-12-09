-- ще си говорим за Eq typeclass-a малко по-късно,
-- тази типова декларация означава, че за а са дефинирани операторите == и /=
-- може засега и histogram :: [Int] -> [(Int, Int)] или histogram :: [Char] -> [(Char, Int)]
histogram :: (Eq a) => [a] -> [(a, Int)]
histogram []         = []
histogram lst@(x:xs) = (x, length equals) : histogram diffs
  where equals = filter (==x) lst
        diffs  = filter (/=x) lst
