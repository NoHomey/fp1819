#lang racket

(define assoc-list '((a . 10) (b . 12) (c . 18)))

(define (map-values function assoc-list)
  (map
    (lambda (element)
      (cons (car element) (function (cdr element))))
    assoc-list))

;; (map-values (lambda (x) (+ x 1)) assoc-list)
;; връща '((a . 11) (b . 13) (c . 19))
