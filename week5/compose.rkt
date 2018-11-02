#lang racket

(define (compose func-list)
  (lambda (x)
    (foldr (lambda (func arg) (func arg)) x func-list)))
