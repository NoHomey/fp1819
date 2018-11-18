#lang racket

(define (plus . args)
  (foldr
      +
      0
      args))

(define (plus2 a b . rest)
  (if (null? rest)
      (+ a b)
      (+ a (apply plus2 b (car rest) (cdr rest)))))
