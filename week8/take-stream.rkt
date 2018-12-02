#lang racket

(require "streams.rkt"
         "from-to.rkt")

(provide take-stream)

(define (take-stream stream n)
  (if (< n 1)
      empty-stream
      (cons
          (head stream)
          (take-stream (tail stream) (- n 1)))))

;; (take-stream numbers 5)      ;; връща '(1 2 3 4 5)
