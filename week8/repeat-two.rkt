#lang racket

(require "streams.rkt"
         "take-stream.rkt")

(define (repeat-two list1 list2)
  (define (repeat-two-helper currl currl-original nextl-original)
      (if (null? currl)
          (repeat-two-helper nextl-original nextl-original currl-original)
          (cons-stream (head currl) (repeat-two-helper (tail currl) currl-original nextl-original))))
  (repeat-two-helper list1 list1 list2))

(take-stream (repeat-two '(1 2) '(3 4 5)) 10)
;; връща '(1 2 3 4 5 1 2 3 4 5)
