catalan :: (Enum a, Integral a) => a -> a
catalan n = (product [(n+2)..(2*n)]) `div` (product [1..n])

main = do
  line <- getLine
  print $ catalan ((read line) :: Integer)
