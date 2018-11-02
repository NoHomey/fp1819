#lang racket

(define (insert element sorted-list)
  (cond
    ((null? sorted-list) (list element))
    ((> element (car sorted-list)) (cons
                                      (car sorted-list)
                                      (insert element (cdr sorted-list))))
    (else (cons element sorted-list))))

(define (insertion-sort list)
  (if (null? list)
      '()
      (insert
          (car list)
          (insertion-sort (cdr list)))))
