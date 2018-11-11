#lang racket

(define (zip-with operation list1 list2)
  (if (or (null? list1) (null? list2))
      '()
      (cons
          (operation (car list1) (car list2))
          (zip-with operation (cdr list1) (cdr list2)))))

(define (sum-lists list1 list2)
  (zip-with + list1 list2))

(define (sum-matrices matrix1 matrix2)
  (zip-with sum-lists matrix1 matrix2))

(sum-matrices
    '((1 2 3) (4 5 6) (7 8 9))
    '((0 1 2) (3 4 5) (6 7 8)))
;; връща '(( 1  3  5)
;;         ( 7  9 11)
;;         (13 15 17))
