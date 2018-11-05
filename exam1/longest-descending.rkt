#lang racket

;; Да се напише функция (longestDescending­ l), която намира низходящо сортиран подсписък
;; на списъка от числа l с максимална дължина.
;; Ако съществуват няколко такива подсписъка, функцията да върне първия отляво надясно.
;; Упътване: Реализирайте помощна функция, която намира най-дългия низходящо сортиран префикс на даден списък.

(define (longest-descending-prefix lst)
  (cond
      ((or (null? lst) (null? (cdr lst))) lst)
      ((> (car lst) (car (cdr lst))) (cons (car lst) (longest-descending-prefix (cdr lst))))
      (else (list (car lst)))))

(define (generate-suffixes lst)
  (foldr
      (lambda (curr accum)
          (cons (cons curr (car accum)) accum))
      '(())
      lst))

(define (longest-descending lst)
  (foldl
      (lambda (curr acc)
        (if (> (length curr) (length acc))
            curr
            acc))
      '()
      (map longest-descending-prefix (generate-suffixes lst))))

(longest-descending '(5 3 8 6 4 2 6 7 1))       ;; връща '(8 6 4 2)
(longest-descending '(1 2 3 4 5 6))             ;; връща '(1)
(longest-descending '(5 3 8 6 4 2 6 5 4 1))     ;; връща '(8 6 4 2)
(longest-descending '(5 3 8 6 4 2 6 5 4 1 0))   ;; връща '(6 5 4 1 0)
