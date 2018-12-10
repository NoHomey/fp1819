-- брои срещанията на всеки елемент в списъка xs
-- histogram [1,1,3,2] връща [(1,2), (3,1), (2,1)]
histogram :: [Int] -> [(Int, Int)]
histogram []         = []
histogram lst@(x:xs) = (x, length equals) : histogram diffs
  where equals = filter (==x) lst
        diffs  = filter (/=x) lst

-- взема списък и връща списък от най-често срещаните елементи в него
-- [1,1,3,2] връща [1]
-- [1,5]     връща [1,5]
mostFrequentInList :: [Int] -> [Int]
mostFrequentInList lst =
  map
    fst
    (filter
      (\(element, occurences) ->
        occurences == maxOccurences)
      elOccurences)
  where elOccurences  = histogram lst
        maxOccurences = maximum (map snd elOccurences)

-- проверява дали подадения елемент се съдържа във всички подсписъци на подадения списък
-- elemAll 1 [[1],[1,2]] връща True
-- elemAll 1 [[1],[2,3]] връща False
elemAll :: Int -> [[Int]] -> Bool
elemAll element llst =
  foldr
    (\lst accum ->
      (elem element lst) && accum)
    True
    llst

-- по даден списък от списъци от числа
-- връща числото, което е сред най-често срещаните числа във всички списъци,
-- ако такова има, или 0 иначе
-- mostFrequent [[1,1,3,2],[1,1,5],[1,5],[1,1,1,3]] връща 1
-- mostFrequent [[1,1,3,2],[1,5,5],[1,5],[1,1,1,3]] връща 0
mostFrequent:: [[Int]] -> Int
mostFrequent lst =
  if (null mostFrequentElements)
    then 0
    else (head mostFrequentElements)
  where mostFrequentLists = map mostFrequentInList lst
        mostFrequentElements =
          filter
            (\element ->
              elemAll element (tail mostFrequentLists))
            (head mostFrequentLists)
