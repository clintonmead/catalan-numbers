(defn bisect [f g n] 
  (letfn 
    [
      (go [x y] 
        (if (== (+ x 1) y) 
          (g x) 
          (let [midpoint (+ x (quot (- y x) 2))] (f (go x midpoint) (go midpoint y)))
        )
      )
    ]
    (go 0 n)
  )
)

(defn productStep [step x y] 
  (if (> x y) 1 (bisect * (fn [i] (bigint (+ x (* i step)))) (+ (quot (- y x) step) 1)))
)

(defn productRange [x y] (productStep 1 x y))

(defn fact [x] (productRange 1 x))

(defn catalan [n] 
  (let 
    [
      numEvens (quot n 2)
      numOdds (- n numEvens)
      firstOdd (- (+ n 3) (mod n 2))
    ]
    (quot (bigint (.shiftLeft (biginteger (productStep 2 firstOdd (* 2 n))) numEvens)) (fact numOdds))
  )
)

(print (catalan (bigint (read-line))))
