#lang racket

(define (zip list1 list2)
  (if (or (null? list1) (null? list2))
      '()
      (cons
          (cons
              (car list1)
              (car list2))
          (zip
              (cdr list1)
              (cdr list2)))))
