#lang racket

(define (my-map function list)
  (foldr
    (lambda (element accum) (cons (function element) accum))
    '()
    list))
