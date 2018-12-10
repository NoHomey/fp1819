-- Телевизионно предаване се представя с наредена тройка от
-- име (низ),
-- начален час (наредена двойка от час и минути) и
-- продължителност (брой минути).

-- a. Да се напише функция lastShow, която
-- по списък от предавания
-- връща името на това, което завършва най-късно.

-- приема телевизионно предаване и връща името му
getName :: (String, (Int, Int), Int) -> String
getName (name, _, _) = name

-- приема наредена двойка от час и минути и връща броя минути, изминали от началото на деня
fromStartOfDay :: (Int, Int) -> Int
fromStartOfDay (hours, minutes) = hours * 60 + minutes

-- проверява дали първото подадено телевизионно предаване приключва
-- по-късно от второто такова
endsLater :: (String, (Int, Int), Int) -> (String, (Int, Int), Int) -> Bool
endsLater (_, startTime1, duration1) (_, startTime2, duration2) =
  (fromStartOfDay startTime1 + duration1) > (fromStartOfDay startTime2 + duration2)

-- lastShow :: [(String, (Integer, Integer), Integer)] -> String
lastShow (first : rest) = getName (lastShowHelper rest first)
  where lastShowHelper rest lastShow =
          foldl
            (\lastShow curr ->
              if (endsLater curr lastShow)
                then curr
                else lastShow)
            lastShow
            rest

-- b. Да се напише функция longestProgram, която
-- по даден списък от предавания
-- генерира възможно най-дълга телевизионна програма, т.е. сумата от продължителностите на предаванията в нея е максимална.s

-- проверява дали първото подадено предаване започва след началото на второто подадено такова
startsLater :: (String, (Int, Int), Int) -> (String, (Int, Int), Int) -> Bool
startsLater (_, startTime1, _) (_, startTime2, _) =
  (fromStartOfDay startTime1) > (fromStartOfDay startTime2)

-- проверява дали първото подадено предаване започва след края на второто подадено такова
startsAfter :: (String, (Int, Int), Int) -> (String, (Int, Int), Int) -> Bool
startsAfter (_, startTime1, _) (_, startTime2, duration) =
  (fromStartOfDay startTime1) >= (fromStartOfDay startTime2 + duration)

-- сортира във възходящ ред телевизионните програми по началния им час
quicksort :: [(String, (Int, Int), Int)] -> [(String, (Int, Int), Int)]
quicksort []     = []
quicksort (firstShow@(_, startTime, _):xs) = (quicksort earlier) ++ [firstShow] ++ (quicksort later)
    where earlier = filter (\currShow -> not (startsLater currShow firstShow)) xs
          later   = filter (\currShow -> startsLater currShow firstShow) xs

allCombinations :: [a] -> [[a]]
allCombinations [] = [[]]
allCombinations (x:xs) = map (x:) rest ++ rest
  where rest = allCombinations xs

-- проверява дали подадената последователност от предавания прави програма
-- т.е. дали предаванията са в нарастващ ред и непресичащи се
isProgram :: [(String, (Int, Int), Int)] -> Bool
isProgram [_] = True
isProgram (firstShow : secondShow : rest) =
  (startsAfter secondShow firstShow) && isProgram (secondShow : rest)

generateAllPrograms :: [(String, (Int, Int), Int)] -> [[(String, (Int, Int), Int)]]
generateAllPrograms tvShows = (filter isProgram (map quicksort (init (allCombinations tvShows))))

-- приема програма от телевизионни предавания и връща общата и продължителност
getProgramDuration :: [(String, (Int, Int), Int)] -> Int
getProgramDuration program = sum (map (\(_, _, duration) -> duration) program)

-- longestProgram и lastShow следват един и същ pattern
-- можем да изнесем общата логика в нова функция maximumBy, на която подаваме
-- сравняваща функция / comparator, за да избегнем дублирането на код
longestProgram :: [(String, (Int, Int), Int)] -> [(String, (Int, Int), Int)]
longestProgram tvShows =
  foldl
    (\longest curr ->
      if (getProgramDuration curr > getProgramDuration longest)
        then curr
        else longest)
    (head allPrograms)
    (tail allPrograms)
  where allPrograms = generateAllPrograms tvShows
