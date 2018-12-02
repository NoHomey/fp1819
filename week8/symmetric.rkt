#lang racket

(require "graph.rkt"
         "to-edges.rkt")

(define example-symmetric-graph
  '((1 2 4)
    (2 1 3 4)
    (3 2 3 4)
    (4 1 2 3)
    (5 6)
    (6 5)))

;; проверява дали дадения граф е симетричен (ако съществува ребро от връх u до v, то същвстува и ребро от v до u)
(define (symmetric? graph)
  (foldr
      (lambda (edge accum)
          (and
            (edge? graph (cdr edge) (car edge))
            accum))
      #t
      (to-edges graph)))

;; (symmetric? example-graph)            ;; връща #f
;; (symmetric? example-symmetric-graph)  ;; връща #t
