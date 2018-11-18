#lang racket

(require "tree.rkt")

(define (contains? tree path)
  (cond
      ((null? path) #t)
      ((empty-tree? tree) #f)
      (else (and
                (equal? (root tree) (car path))
                (or
                    (contains? (left-tree tree) (cdr path))
                    (contains? (right-tree tree) (cdr path)))))))

(contains? example-tree '(1 3 5))   ;; връща #t
(contains? example-tree '(1 2 4))   ;; връща #f
