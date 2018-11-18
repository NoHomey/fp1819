#lang racket

(require "tree.rkt")

(define (level tree i)
  (cond
    ((empty-tree? tree) empty-tree)
    ((= i 0) (list (root tree)))
    (else (append
              (level (left-tree  tree) (- i 1))
              (level (right-tree tree) (- i 1))))))

(level example-tree 2)
