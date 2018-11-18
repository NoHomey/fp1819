#lang racket

(require "tree.rkt")

(define (paths tree)
  (if (leaf? tree)
      (list (list (root tree)))
      (map
          (lambda (path) (cons (root tree) path))
          (append
              (paths (left-tree tree))
              (paths (right-tree tree))))))

(paths example-tree)    ;; връща '((1 2) (1 3 4) (1 3 5))
