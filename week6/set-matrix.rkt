#lang racket

(define matrix '((1 2 3)
                 (4 5 6)
                 (7 8 9)))

(define (set-list list index element)
  (if (= 0 index)
      (cons element (cdr list))
      (cons (car list) (set-list (cdr list) (- index 1) element))))

(define (set-matrix matrix i j element)
  (set-list
      matrix
      i
      (set-list
          (list-ref matrix i)
          j
          element)))

(set-matrix matrix 1 1 0)
;; връща '((1 2 3)
;;         (4 0 6)
;;         (7 8 9))
