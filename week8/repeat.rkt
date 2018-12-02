#lang racket

(require "streams.rkt"
         "take-stream.rkt")

(define (repeat list)
  (define (repeat-helper list original)
    (if (null? list)
        (repeat-helper original original)
        (cons-stream (car list) (repeat-helper (cdr list) original))))
  (repeat-helper list list))

(take-stream (repeat '(1 2 3)) 10)
;; връща '(1 2 3 1 2 3 1 2 3 1)
