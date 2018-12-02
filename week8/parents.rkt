#lang racket

(require "graph.rkt")

(provide parents)

(define (parents graph child)
  (vertices (filter
    (lambda (row)
      (member child (children graph (car row))))
    graph)))

;; (parents example-graph 3)   ;; връща '(2 3 4)
