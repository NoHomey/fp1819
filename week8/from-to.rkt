#lang racket

(require "streams.rkt")

(provide from-to
         numbers)

(define (from-to start end)
  (if (> start end)
      empty-stream
      (cons-stream
        start
        (from-to (+ start 1) end))))

(define numbers (from-to 1 100))
;; (head numbers)          ;; връща 1
;; (head (tail numbers))   ;; връща 2
