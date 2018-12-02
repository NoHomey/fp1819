sum' :: Int -> Int -> Int
sum' start end = if (start > end)
                    then 0
                    else start + sum' (start + 1) end

sum'' :: Int -> Int -> Int
sum'' start end = helper start end 0
  where helper start end accum = if (start > end)
                                    then accum
                                    else helper (start + 1) end (start + accum)
