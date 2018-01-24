(defn catalan [n] (/ (reduce * (range (+ n 2N) (+ (* 2N n) 1N))) (reduce * (range 2N (+ n 1)))))

(print (catalan (bigint (read-line))))
