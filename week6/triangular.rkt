#lang racket

(define (starts-with-n-zeroes n)
  (lambda (list)
    (if (< n 1)
        #t
        (and
          (= 0 (car list))
          ((starts-with-n-zeroes (- n 1)) (cdr list))))))

(define (triangular? matrix)
  (define (triangular-helper matrix counter)
    (if (null? matrix)
        #t
        (and
            ((starts-with-n-zeroes counter) (car matrix))
            (triangular-helper (cdr matrix) (+ counter 1)))))
  (triangular-helper matrix 0))

(triangular? '((1 2 3 4)
               (0 5 6 7)
               (0 0 8 9)
               (0 0 0 1)))  ;; връща #t
