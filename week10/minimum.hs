-- ще си говорим за Ord typeclass-a малко по-късно,
-- тази типова декларация означава, че а е от "сравним" тип - има дефинирани >, <, >=, <= за него
-- може засега и histogram :: [Int] -> [(Int, Int)] или histogram :: [Char] -> [(Char, Int)]
minimum' :: (Ord a) => [a] -> a
minimum' []     = error "I dunno, what kind of question is that?"
minimum' (x:xs) =
  foldl
    (\element minElement ->
      if (element < minElement)
        then element
        else minElement)
    x
    xs
