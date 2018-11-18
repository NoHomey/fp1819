#lang racket

(require "tree.rkt")

(define symmetric-tree
  '(1
      (2
          ()
          (4 () ()))
      (3
          (5 () ())
          ())))

(define (mirror? tree1 tree2)
  (cond
      ((and
        (empty-tree? tree1)
        (empty-tree? tree2)) #t)
      ((or
        (empty-tree? tree1)
        (empty-tree? tree2)) #f)
      (else (and
          (mirror?
              (left-tree tree1)
              (right-tree tree2))
          (mirror?
              (right-tree tree1)
              (left-tree tree2))))))

(define (symmetric? tree)
  (mirror?
      (left-tree tree)
      (right-tree tree)))

(symmetric? example-tree)
(symmetric? symmetric-tree)
