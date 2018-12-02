#lang racket

(require "streams.rkt"
         "take-stream.rkt")

(define (from number)
  (cons-stream number (from (+ number 1))))

;; (take-stream (from 1) 5)    ;; връща '(1 2 3 4 5)
