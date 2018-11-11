#lang racket

(define matrix '((1 2 3)
                 (4 5 6)
                 (7 8 9)))

(define (minimum-list list)
  (foldl min (car list) (cdr list)))

(define (minimum matrix)
  (minimum-list (map minimum-list matrix)))

(minimum matrix)  ;; връща 1
