#lang racket

(require "../trees.rkt")
(require "../streams.rkt")

;; a. Да се напише функция `grow t x`, която по дадено
;; двоично дърво от числа t конструира
;; ново, в което към всяко листо на t добавя по две нови листа със зададена стойност x.

(define (grow tree x)
  (cond
      ((empty-tree? tree) empty-tree)
      ((leaf? tree) (make-tree
                        (root tree)
                        (make-tree x '() '())
                        (make-tree x '() '())))
      (else (make-tree
                (root tree)
                (grow (left-tree  tree) x)
                (grow (right-tree tree) x)))))

;; b. Двоично дърво наричаме “пълно”, ако има 2^n елемента на ниво n.
;; Да се напише функция `growingTrees`, която генерира
;; безкраен поток от пълни дървета с височини съответно 1, 2, 3,...,
;; като всички елементи на ниво n са със стойност n.

(define (growing-trees)
  (define (growing-trees-helper prev-tree n)
    (let ((new-tree (grow prev-tree n)))
    (cons-stream
        new-tree
        (growing-trees-helper new-tree (+ n 1)))))
  (cons-stream
    (make-tree 0 '() '())
    (growing-trees-helper (make-tree 0 '() '()) 1)))
