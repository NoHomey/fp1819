#lang racket

(define matrix '((1 2 3)
                 (4 5 6)
                 (7 8 9)))

(define (get-column matrix index)
   (map
      (lambda (list) (list-ref list index))
      matrix))

(define (transpose matrix)
  (define (transpose-helper matrix start end)
    (if (> start end)
        '()
        (cons
            (get-column matrix start)
            (transpose-helper matrix (+ start 1) end))))
  (transpose-helper matrix 0 (- (length matrix) 1)))

(transpose matrix)
;; връща '((1 4 7)
;;         (2 5 8)
;;         (3 6 9))
