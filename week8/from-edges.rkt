#lang racket

(define (remove-duplicates lst)
  (foldr
    (lambda (element accum)
      (if (not (member element accum))
          (cons element accum)
          accum))
    '()
    lst))

(define (get-children edges parent)
  (map
      cdr
      (filter
          (lambda (edge)
              (equal? (car edge) parent))
          edges)))

(define (from-edges edges)
  (let
    ((vertices (sort (remove-duplicates (append (map car edges) (map cdr edges))) <)))  ;; не искаме да пропуснем върховете, от които не излиза ребро
    (map
        (lambda (parent)
            (cons parent (get-children edges parent)))
        vertices)))

;; (from-edges
;;     '((1 . 2) (2 . 1) (2 . 3) (2 . 4) (3 . 3) (4 . 1) (4 . 3) (5 . 6)))
;; връща
;; '((1 2)
;;   (2 1 3 4)
;;   (3 3)
;;   (4 1 3)
;;   (5 6)
;;   (6)))
