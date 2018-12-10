#lang racket

(require "../streams.rkt")

;; Да се напише функция `sumLast`, която приема
;; две положителни естествени числа k и n и
;; генерира безкрайния поток, в който
;; първото число е k, а всяко следващо число е равно на сумата от предходните n числа в потока.

(define (sumLast k n)
  (define (sumLast i to-subtract next-sum)
    (if (<= i n)
        (cons-stream
            next-sum
            (sumLast
                (+ i 1)
                (append to-subtract (list next-sum))
                (* 2 next-sum)))
        (cons-stream
            (- next-sum (car to-subtract))
            (sumLast
                (+ i 1)
                (append (cdr to-subtract) (list (- (* 2 next-sum) (car to-subtract))))
                (- (* 2 next-sum) (car to-subtract))))))
  (cons-stream k (sumLast 1 '() k)))

;(sumLast 3 5)     ;; (3 3 6 12 24 48 93 183 … )
