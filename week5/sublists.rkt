#lang racket

;; returns all sublists with size of n
;; (sublists-n 0 '(1 2 3)) returns '()
;; (sublists-n 1 '(1 2 3)) returns '((1) (2) (3))
(define (sublists-n size list)
  (if (or (= size 0) (> size (length list)))
      '()
      (cons
          (take list size)
          (sublists-n size (cdr list)))))

(define (sublists list)
  (define (helper counter list)
    (if (> counter (length list))
        '(())
        (append (sublists-n counter list) (helper (+ counter 1) list))))
  (helper 0 list))


;; another solution
;; reusing generate-interval as a helper function
(define (generate-interval start end)
  (if (> start end)
      '()
      (cons start (generate-interval (+ start 1) end))))

(define (sublists2 list)
  (foldr
      (lambda (size accum) (append
                                  (sublists-n size list)
                                  accum))
      '(())
      (generate-interval 1 (length list))))
