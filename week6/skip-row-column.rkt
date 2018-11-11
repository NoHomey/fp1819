#lang racket

(define matrix '((1 2 3)
                 (4 5 6)
                 (7 8 9)))

(define (skip-element list index)
  (if (= index 0)
      (cdr list)
      (cons (car list) (skip-element (cdr list) (- index 1)))))

(define (skip-row matrix index)
  (skip-element matrix index))

(define (skip-column matrix index)
  (map (lambda (list) (skip-element list index)) matrix))

(skip-row matrix 1)
;; връща '((1 2 3)
;;         (7 8 9))

(skip-column matrix 1)
;; връща '((1 3)
;;         (4 6)
;;         (7 9))
