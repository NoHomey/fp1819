-- Нека е даден
-- списък от наредени двойки от числа, представляващи точки в равнината.
-- Да се напише функция `findMedoid`, която
-- намира такава точка от списъка, за която
-- сумата от квадратите на разстоянията до всички останали точки в списъка е минимална

-- намира разстоянието между две точки
distance :: (Double, Double) -> (Double, Double) -> Double
distance (a, b) (c, d) = sqrt (((a - c) ^ 2) + ((b - d) ^ 2))

-- намира сумата от квадратите на разстоянията от дадената точка до всички останали точки
findSum :: (Double, Double) -> [(Double, Double)] -> Double
findSum point points = sum [(distance point anotherPoint)^2 | anotherPoint <- points]

-- получава списък от наредени двойки (точка, сумата_от_квадратите_на_whatever_)
-- връща наредена двойка от (точка, сума), точка е точката, за която сумата от квадратите на разстоянията до всички останали
-- точки в списъка е минимална
findMinPoint :: [((Double, Double), Double)] -> ((Double, Double), Double)
findMinPoint (point : rest) =
  foldl
  (\min@(_, distSum1) curr@(_, distSum2) ->
    if distSum2 < distSum1
      then curr
      else min)
  point
  rest

findMedoid :: [(Double, Double)] -> (Double, Double)
findMedoid points = fst (findMinPoint (map
                                        (\point -> (point, findSum point points))
                                        points))
