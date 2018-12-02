#lang racket

(require "graph.rkt")

;; ако element се съдържа в list, връща #t, иначе - #f
;; за разлика от member, който в случай, че element се съдържа в list,
;; връща остатъка от list
(define (wrapped-member element list)
  (not (not (member element list))))

(define (contains-path? graph path)
  (cond
      ((null? path) #t)
      ((null? (cdr path)) (wrapped-member (car path) (vertices graph)))
      (else (and
                (edge? graph (car path) (car (cdr path)))
                (contains-path? graph (cdr path))))))

;; (contains-path? example-graph '(2 4 1 2 3))   ;; връща #t
;; (contains-path? example-graph '(2 4 5 2 3))   ;; връща #f
