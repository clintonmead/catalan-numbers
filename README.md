A couple of implementations of calculating Catalan numbers both in Haskell and Clojure,
which I did for a job application. 

The "simple" implementations are simple but relatively slow, 
the "fast" implementations on the other hand reorder multiplications 
to turn `O(n^2)` performance into something closer to `O(n^1.5)`,
which is a significant difference for large `n`. 

It does this by a variety of optimisations, in particular to do with ensuring
that mulitplications have roughly equal sized operands, which allows one
to take advantage of fast multiplication.

This short project was actually the inspiration for the package 
[fast-mult on hackage](https://hackage.haskell.org/package/fast-mult),
which allows one to increase the efficiency of any Haskell algorithm
with significant large multiplication, by only changing the numeric type,
not the code. 
