#lang racket

(define (subsets list)
  (if (null? list)
      '(())
      (append
          (map (lambda (subset) (cons
                                    (car list) subset))
                                    (subsets (cdr list)))
          (subsets (cdr list)))))
