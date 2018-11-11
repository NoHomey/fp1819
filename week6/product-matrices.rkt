#lang racket

(define (get-column matrix index)
   (map
      (lambda (list) (list-ref list index))
      matrix))

(define (combine list1 list2)
  (if (or (null? list1) (null? list2))
      0
      (+
          (* (car list1) (car list2))
          (combine (cdr list1) (cdr list2)))))

(define (product-matrices matrix1 matrix2)

  (define (product-row row matrix)
    (define (product-row-helper row matrix index row-length)
      (if (> index row-length)
          '()
          (cons
              (combine row (get-column matrix index))
              (product-row-helper row matrix (+ index 1) row-length))))
    (product-row-helper row matrix 0 (- (length row) 1)))

  (map (lambda (row) (product-row row matrix2)) matrix1))

(product-matrices
  '((1 2 3) (4 5 6) (7 8 9))
  '((0 1 2) (3 4 5) (6 7 8)))
;; връща '((24  30  36)
;;         (51  66  81)
;;         (78 102 126))
