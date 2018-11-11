#lang racket

(define matrix '((1 2 3)
                 (4 5 6)
                 (7 8 9)))

(define (diagonal matrix)
  (define (diagonal-helper matrix index)
    (if (null? matrix)
        '()
        (cons
            (list-ref (car matrix) index)
            (diagonal-helper (cdr matrix) (+ index 1)))))
  (diagonal-helper matrix 0))

(diagonal matrix)  ;; връща '(1 5 9)
