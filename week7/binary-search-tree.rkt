#lang racket

(require "tree.rkt")
(require "order.rkt")

(define (binary-search-tree? tree)
  (if (empty-tree? tree)
      #t
      (let
          ((ltree (left-tree tree))
           (rtree (right-tree tree))
           (element (root tree)))
      (and
         (or
             (empty-tree? ltree)
             (> element (root ltree)))
         (or (empty-tree? rtree)
             (< element (root rtree)))
         (binary-search-tree? ltree)
         (binary-search-tree? rtree)))))

;; helper function used in binary-search-tree2
(define (sorted? list)
  (if (null? (cdr list))
      #t
      (and
          (< (car list) (cadr list))
          (sorted? (cdr list)))))

(define (binary-search-tree2? tree)
  (sorted? (inorder tree)))

(binary-search-tree? example-tree)                  ;; връща #f
(binary-search-tree? example-binary-search-tree)    ;; връща #t
