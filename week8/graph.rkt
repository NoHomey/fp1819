#lang racket

(provide example-graph
         vertices
         children
         edge?)

(define example-graph
   '((1 2)
     (2 1 3 4)
     (3 3)
     (4 1 3)
     (5 6)
     (6)))

(define (vertices graph)
  (map car graph))

;; (vertices example-graph)      ;; връща '(1 2 3 4 5 6)

(define (children graph parent)
  (cond
      ((null? graph) '())
      ((equal? (car (car graph)) parent) (cdr (car graph)))
      (else (children (cdr graph) parent))))

;; (children example-graph 4)    ;; връща '(1 3)

(define (edge? graph parent child)
  (member child (children graph parent)))

;; (edge? example-graph 1 5)   ;; връща #f
;; (edge? example-graph 5 6)   ;; връща '(6)
