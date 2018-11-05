#lang racket

;; Да се напише функция (average f g), която по две числови функции
;; f : R → R и g : R → R  намира средно-аритметичната функция
;; (f⊕g)(x)= (f(x) + g(x)) / 2

(define (average f g)
  (lambda (x)
    (/
      (+ (f x) (g x))
      2)))

;; ((average (lambda (x) (+ x 2)) (lambda (x) (* x x))) 3) ;; returns 7

;; С помощта на average да се напише функция от по-висок ред (calcprod f n),
;; която намира произведението ∏(f⊕gi)(i), където gi(x) = ix.   ;; TODO: fix this
;; Използването на accumulate е позволено, но не е задължително.

(define (accumulate op null-value start end term next)
  (if (> start end)
      null-value
      (op
          (term start)
          (accumulate op null-value (next start) end term next))))

(define (calcprod f n)
  (accumulate
      *
      1
      1
      n
      (lambda (i) ((average f (lambda (x) (expt i x))) i))
      (lambda (i) (+ i 1))))

(calcprod (lambda (x) (+ x 2)) 3)
