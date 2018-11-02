#lang racket

(define (my-map function list)
  (if (null? list)
      '()
      (cons
          (function (car list))
          (my-map function (cdr list)))))

(define (my-filter predicate? list)
  (cond
      ((null? list) '())
      ((predicate? (car list)) (cons
                                    (car list)
                                    (my-filter predicate? (cdr list))))
      (else (my-filter predicate? (cdr list)))))

(define (my-foldl operation null-value list)
  (if (null? list)
      null-value
      (operation
        (car list)
        (my-foldl operation null-value (cdr list)))))

(define (my-foldr operation null-value list)
  (my-foldl operation null-value (reverse list)))
