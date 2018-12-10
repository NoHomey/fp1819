#lang racket

(require "../trees.rkt")

;; Да се напише функция `transformSum`, която преобразува
;; дърво с елементи цели числа в
;; ново дърво със същата структура, в което
;; всеки елемент е заменен със сумата на елементите в поддървото с този корен в началното дърво.

(define (sum tree)
  (if (empty-tree? tree)
      0
      (+
          (root tree)
          (sum (left-tree tree))
          (sum (right-tree tree)))))

(define (transformSum tree)
  (if (empty-tree? tree)
      empty-tree
      (let ((left-tree (left-tree tree))
            (right-tree (right-tree tree)))
            (make-tree
                (+
                    (sum left-tree)
                    (sum right-tree))
                (transformSum left-tree)
                (transformSum right-tree)))))
