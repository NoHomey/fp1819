#lang racket

(provide example-tree
         example-binary-search-tree
         tree?
         empty-tree
         empty-tree?
         root
         left-tree
         right-tree
         make-tree
         leaf?)

(define example-tree
  '(1
      (2 () ())
      (3
          (4 () ())
          (5 () ()))))

(define example-binary-search-tree
  '(3
       (1
           ()
           (2 () ()))
       (4
           ()
           (5 () ()))))

(define (tree? t)
 (or (null? t)
     (and (list? t)
          (= (length t) 3))
          (tree? (cadr t))
          (tree? (caddr t))))

(define empty-tree '())
(define empty-tree? null?)

(define root car)
(define left-tree cadr)
(define right-tree caddr)

(define (make-tree root left right) (list root left right))

(define (leaf? tree)
  (and
      (not (empty? tree))
      (and
          (empty? (left-tree tree))
          (empty? (right-tree tree)))))