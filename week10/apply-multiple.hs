applyMultiple :: Int -> (a -> a) -> a -> a
applyMultiple 0     _ arg = arg
applyMultiple times f arg = applyMultiple (times - 1) f (f arg)
