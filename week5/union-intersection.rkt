#lang racket

(define (union list1 list2)
  (cond
      ((null? list1) list2)
      ((member (car list1) list2) (union (cdr list1) list2))
      (else (cons
                  (car list1)
                  (union (cdr list1) list2)))))

(define (union2 list1 list2)
  (append
      list1
      (filter
          (lambda (x) (not (member x list1)))
          list2)))

(define (intersection list1 list2)
  (cond
      ((null? list1) '())
      ((member (car list1) list2) (cons
                                        (car list1)
                                        (intersection (cdr list1) list2)))
      (else (intersection (cdr list1) list2))))

(define (intersection2 list1 list2)
  (filter
      (lambda (x) (member x list2))
      list1))
