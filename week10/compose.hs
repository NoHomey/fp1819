-- ще си говорим за Eq typeclass-a малко по-късно,
-- тази типова декларация означава, че за а са дефинирани операторите == и /=
-- може засега и compose :: [(Int, Int)] -> [(Int, Int)] -> [(Int, Int)]
compose :: (Eq a, Eq b, Eq c) => [(a, b)] -> [(b, c)] -> [(a, c)]
compose lst1 lst2 = foldr
  (\(a, b) accum ->
    let eqKeys = filter (\(c,d) -> c == b) lst2
    in if (null eqKeys)
        then accum
        else (a, snd (head eqKeys)):accum)
  []
  lst1
