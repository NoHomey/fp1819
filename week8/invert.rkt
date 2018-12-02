#lang racket

(require "graph.rkt"
         "parents.rkt")

(define (invert graph)
  (map
    (lambda (vertex)
      (cons vertex (parents graph vertex)))
    (vertices graph)))

;; (invert example-graph)
;; връща
;; '((1 2 4)
;;   (2 1)
;;   (3 2 3 4)
;;   (4 2)
;;   (5)
;;   (6 5)))
