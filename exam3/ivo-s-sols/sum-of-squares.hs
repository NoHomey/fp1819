sumOfSquares :: Integer
sumOfSquares = [a^2 + b^2 | a <- [1..], b <- [1..a]]

main = print $ take 10 sumOfSquares
