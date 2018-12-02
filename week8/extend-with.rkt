#lang racket

(define assoc-list1 '((a . 10) (b . 12) (c . 18)))
(define assoc-list2 '((d . 22) (b . 32)))

(define (extend-with assoc-list1 assoc-list2)
  (append
    (filter
      (lambda (element)
        (not (assoc
                (car element)
                assoc-list2)))
      assoc-list1)
    assoc-list2))

;; (extend-with assoc-list1 assoc-list2)
;; връща '((a . 10) (b . 32) (c . 18) (d . 22)))
;; (не задължително в този ред)
