#lang racket

;; Да се напише функция (max-unique ll), която по списък от списъци от цели числа
;; намира най-голямото от тези от тях,
;; които са уникални в рамките на списъка, в който се срещат.
;; Ако в никой списък няма уникални числа, функцията да връща #f.

(define (get-uniques list)
  (define (unique? number)
    (=
        1
        (length
            (filter
                (lambda (x) (= x number))
                list))))
  (filter unique? list))

(define (maximum list)
  (foldr
      (lambda (curr accum)
          (if (> curr accum)
              curr
              accum))
      (car list)
      (cdr list)))

(define (max-unique ll)
  ;; TODO: is it ok to flatten the unique lists?
  (let ((unique-numbers (flatten (map get-uniques ll))))
    (if (null? unique-numbers)
        #f
        (maximum unique-numbers))))

(max-unique '((1 2 3 2) (5 5) (0)))     ;; връща 3
(max-unique '((1 2 1 2) (5 5) ()))      ;; връща #f
