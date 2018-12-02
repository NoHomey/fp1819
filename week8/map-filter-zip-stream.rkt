#lang racket

(require "streams.rkt"
         "take-stream.rkt"
         "from-to.rkt")

(define (map-stream function stream)
  (if (empty-stream? stream)
       empty-stream
       (cons-stream
          (function (head stream))
          (map-stream function (tail stream)))))

(define (filter-stream predicate? stream)
  (cond
     ((empty-stream? stream) empty-stream)
     ((predicate? (head stream)) (cons-stream (head stream) (filter-stream predicate? (tail stream))))
     (else (filter-stream predicate? (tail stream)))))

(define (zip-streams stream1 stream2)
  (if (or (empty-stream? stream1) (empty-stream? stream2))
      empty-stream
      (cons-stream
        (cons (head stream1) (head stream2))
        (zip-streams (tail stream1) (tail stream2)))))

;; (take-stream (map-stream (lambda (x) (+ x 1)) numbers) 5)   ;; връща '(2 3 4 5 6)
;; (take-stream (filter-stream even? numbers) 5)               ;; връща '(2 4 6 8 10)
;; (take-stream (zip-streams numbers (tail numbers)) 5)        ;; връща '((1 . 2) (2 . 3) (3 . 4) (4 . 5) (5 . 6))
