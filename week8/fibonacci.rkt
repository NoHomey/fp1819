#lang racket

(require "streams.rkt")
(require "take-stream.rkt")
(require "add.rkt")

(define fibonacci-rec
  (cons-stream 0 (cons-stream 1 (add fibonacci-rec (tail fibonacci-rec)))))

(define (fibonacci-iter-helper curr next)
  (cons-stream curr (fibonacci-iter-helper next (+ curr next))))

(define fibonacci-iter
  (fibonacci-iter-helper 0 1))

;; (take-stream fibonacci-rec  8)   ;; връща '(0 1 1 2 3 5 8 13)
;; (take-stream fibonacci-iter 8)   ;; връща '(0 1 1 2 3 5 8 13)
