#lang racket

(require "tree.rkt")
;; (require "order.rkt")

(define (insert binary-search-tree element)
    (if (empty-tree? binary-search-tree)
        (make-tree element empty-tree empty-tree)
        (let
            ((ltree (left-tree binary-search-tree))
             (rtree (right-tree binary-search-tree))
             (root-element (root binary-search-tree)))
        (if (> element root-element)
            (make-tree root-element ltree (insert rtree element))
            (make-tree root-element (insert ltree element) rtree)))))

;; (inorder (insert example-binary-search-tree 0))

(define (construct-binary-search-tree sorted-list)
  (if (null? sorted-list)
      empty-tree
      (let*
          ((llength (length sorted-list))
           (middle (if (even? llength)
                       (- (quotient llength 2) 1)
                       (quotient llength 2)))
           (middle-element (list-ref sorted-list middle))
           (first-half (take sorted-list middle))
           (second-half (drop sorted-list (+ middle 1))))
      (make-tree
          middle-element
          (construct-binary-search-tree first-half)
          (construct-binary-search-tree second-half)))))

(construct-binary-search-tree '(1 2 3 4 5 6))
