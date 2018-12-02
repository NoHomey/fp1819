#lang racket

(require "graph.rkt")

(define example-graph
   '((1 2)
     (2 1 3 4 5)
     (3 3 4 5)
     (4 1 3)
     (5 6)
     (6)))

(define (next-vertices graph path)
  (filter
      (lambda (child)
          (not (member child path)))
      (children graph (last path))))

;; връща пътя path в дадения граф, разширен "веднъж" (търсим прости пътища, т.е. без повторения на върхове)
(define (extend-path-once graph path)
  (let
    ((next-vertices (next-vertices graph path)))
  (if (null? next-vertices)
      path
      (map
        (lambda (vertex)
          (append path (list vertex)))
        next-vertices))))

;; връща всички възможни "разширения" на пътя path в дадения граф (търсим прости пътища, т.е. без повторения на върхове)
(define (extend-path graph path)
  (let
    ((next-vertices (next-vertices graph path)))
  (if (null? next-vertices)
      path
      (remove-nested-once (append (list path) (map
          (lambda (child)
              (extend-path graph (append path (list child))))
          next-vertices))))))

;; helper function
;; TODO: most probably this is redundant and can/should be remove
;; (remove-nested-once '((1 2) ((1 2)))) returns '((1 2) (1 2)))
(define (remove-nested-once ll)
  (cond
      ((null? ll) '())
      ((list? (caar ll)) (append (car ll) (remove-nested-once (cdr ll))))
      (else (cons (car ll) (remove-nested-once (cdr ll))))))

(extend-path-once example-graph '(1 2))   ;; връща '((1 2 3) (1 2 4))
(extend-path example-graph '(1 2))        ;; връща '((1 2 3) (1 2 4))
