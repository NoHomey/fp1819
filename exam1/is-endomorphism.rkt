#lang racket

;; Нека е даден списък l от числа и двуместна операция над числа ⊕.
;; Функцията f наричаме “ендоморфизъм над l”, ако f трансформира l в себе си, запазвайки операцията ⊕, т.е.
;; ∀x∈l f(x)∈l и
;; ∀x,y∈l f(x) ⊕ f(y) = f(x ⊕ y).
;; Да се реализира функция is-em?, която проверява дали f е ендоморфизъм.

;; ∀x∈l f(x)∈l
(define (maps-into-itself list function)
  (foldl
      (lambda (curr accum)
          (and
              (member (function curr) list)
              accum))
      #t
      list))

;; helper function
;; (cartesian-product '(1 2) '(3 4)) returns
;; '((1 . 3) (1 . 4) (2 . 3) (2 . 4))
(define (cartesian-product list1 list2)
  (if (null? list1)
      '()
      (append
          (map
              (lambda (element)
                  (cons (car list1) element))
              list2)
          (cartesian-product (cdr list1) list2))))

;; ∀x,y∈l f(x) ⊕ f(y) = f(x ⊕ y)
(define (closed-under-operation list operation function)
  (foldl
      (lambda (curr accum)
          (and
              (equal?
                  (operation (function (car curr)) (function (cdr curr)))
                  (function (operation (car curr) (cdr curr))))
              accum))
      #t
      (cartesian-product list list)))

(define (is-endomorphism? list operation function)
  (and
      (maps-into-itself list function)
      (closed-under-operation list operation function)))

(is-endomorphism? '(0 1 4 6) + (lambda (x) (remainder x 3)))
