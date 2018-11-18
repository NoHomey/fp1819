#lang racket

(require "tree.rkt")

(define (map-tree function tree)
  (if (empty-tree? tree)
      empty-tree
      (make-tree
        (function (root tree))
        (map-tree function (left-tree tree))
        (map-tree function (right-tree tree)))))

(map-tree (lambda (x) (+ x 1)) example-tree)
