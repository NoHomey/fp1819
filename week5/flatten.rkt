#lang racket

(define (my-flatten lst)
  (cond
    ((null? lst) '())
    ((not (list? (car lst))) (cons
                                  (car lst)
                                  (my-flatten (cdr lst))))
    (else (append
        (my-flatten (car lst))
        (my-flatten (cdr lst))))))
