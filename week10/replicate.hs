replicate' :: Int -> a -> [a]
replicate' 0 _       = []
replicate' n element = element : replicate' (n - 1) element
