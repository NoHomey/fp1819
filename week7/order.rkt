#lang racket

(require "tree.rkt")

(provide inorder
         preorder
         postorder)

;; inorder - left, root, right
(define (inorder   tree)
  (if (empty-tree? tree)
      empty-tree
      (append
        (inorder (left-tree tree))
        (list (root tree))
        (inorder (right-tree tree)))))

;; preorder - root, left, right
(define (preorder  tree)
  (if (empty-tree? tree)
      empty-tree
      (append
        (list (root tree))
        (preorder (left-tree tree))
        (preorder (right-tree tree)))))

;; postorder - left, right, root
(define (postorder  tree)
  (if (empty-tree? tree)
      empty-tree
      (append
        (postorder (left-tree tree))
        (postorder (right-tree tree))
        (list (root tree)))))


(inorder   example-tree)    ;; връща '(2 1 4 3 5)
(preorder  example-tree)    ;; връща '(1 2 3 4 5)
(postorder example-tree)    ;; връща '(2 4 5 3 1)
