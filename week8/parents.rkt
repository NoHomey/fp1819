#lang racket

(require "graph.rkt")

(provide parents)

(define (parents graph child)
  (vertices (filter
    (lambda (row)
      (member child (cdr row)))
    graph)))

;; (parents example-graph 3)   ;; връща '(2 3 4)
