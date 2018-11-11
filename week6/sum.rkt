#lang racket

(define matrix '((1 2 3)
                 (4 5 6)
                 (7 8 9)))

(define (sum-list list)
  (foldr + 0 list))

(define (sum matrix)
  (sum-list (map sum-list matrix)))

(sum matrix)  ;; връща 45
