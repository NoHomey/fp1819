applyMultiple :: Int -> (Int -> Int) -> (Int -> Int) -> Int -> Int
applyMultiple 0     _ _ argument = argument
applyMultiple times f g argument = f (applyMultiple (times - 1) g f argument)

permutable :: Int -> Int -> (Int -> Int) -> (Int -> Int) -> Bool
permutable start end f g =
  (all
    (\i ->
      (applyMultiple i f g i) == (applyMultiple i g f i))
    (filter even [start..end]))
