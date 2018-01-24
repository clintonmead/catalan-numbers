import Data.Bits (Bits, shiftL)

-- | As long as 'f' is associative, this should produce the same result "foldl1 f (map g [0..(n-1)])"
--   However, some folds are more efficient if you bisect the input instead of just going left to right.
--   Easy to use with arrays or any other structure with indexing, for example, bisect (*) (x !) (length x) 
--   will work out the product of an array x. But naturally you don't even have to create an array, you
--   just need to provide a function from ints.
bisect :: (a -> a -> a) -> (Int -> a) -> Int -> a
bisect f g n = go 0 n where
  go x y = case (x + 1 == y) of
    True -> g x
    False -> let midpoint = x + ((y - x) `div` 2) in go x midpoint `f` go midpoint y

-- Use the bisect function here. Probably slower for small n due to the more complex recursion but quite a bit faster for large n.
-- Product of no range is naturally the multiplicative identity, we need to catch that separately as 'bisect' breaks with an empty range.
productStep :: (Enum a, Integral a) => a -> a -> a -> a
productStep step x y = if (x > y) then 1 else bisect (*) (\i -> x + fromIntegral i * step) (fromIntegral $ ((y - x) `div` step) + 1)

productRange :: (Enum a, Integral a) => a -> a -> a
productRange = productStep 1

fact :: (Enum a, Integral a) => a -> a
fact = productRange 1

-- | We can be tricky and remove some of the divisions by pairing up
--   the lower half of the numbers from 'fact' with the even numbers from `product`,
--   i.e for n = 6 we have:
--   catalan 6 
--     = (8 * 9 * 10 * 11 * 12) / (1 * 2 * 3 * 4 * 5 * 6)
--     = ((8 / 4) * (10 / 5) * (12 / 6) * 9 * 11) / (1 * 2 * 3)
--     = 2 * 2 * 2 * 9 * 11 / (1 * 2 * 3)
--     = (2 ^ 3) * 9 * 11 / (1 * 2 * 3)
--     = (shiftLeft (9 * 11) 3) / (fact 3)
--  
--   This is fast as bit shifts are easy and as a result we've removed half our operations
--   The code is a bit hacky though as we need to deal with odds and even input arguments differently.
catalan :: (Bits a, Enum a, Integral a) => a -> a
catalan n = 
  let 
    numEvens = n `div` 2
    numOdds = n - numEvens
    firstOdd = n + 3 - n `mod` 2
  in
    (shiftL (productStep 2 firstOdd (2*n)) (fromIntegral numEvens)) `div` (fact numOdds)

main = do
  line <- getLine
  print $ catalan ((read line) :: Integer)
