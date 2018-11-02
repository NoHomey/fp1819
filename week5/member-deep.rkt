#lang racket

(define (member-deep? element list)
  (cond
    ((null? list) #f)
    ((list? (car list)) (or
                            (member-deep? element (car list))
                            (member-deep? element (cdr list))))
    (else (or
              (equal? element (car list))
              (member-deep? element (cdr list))))))
