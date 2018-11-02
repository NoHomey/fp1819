#lang racket

(define (generate-interval start end)
  (if (> start end)
      '()
      (cons start (generate-interval (+ start 1) end))))
