calculate :: (Int -> Int -> Int) -> Int -> Int -> Int
calculate f i j = if i == (j - 1)
                    then f i j
                    else f i (calculate f (i + 1) j)

findMax :: (Int -> Int -> Int) -> Int -> Int -> Int
findMax f start end = maximum [calculate f i j | i <- [start..end], j <- [start..end], i < j]
