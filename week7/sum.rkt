#lang racket

(require "tree.rkt")

(define (sum tree)
  (if (empty-tree? tree)
      0
      (+
        (root tree)
        (sum (left-tree tree))
        (sum (right-tree tree)))))

(sum example-tree)
