#lang racket

(provide empty-stream
         empty-stream?
         cons-stream
         head
         tail)

(define empty-stream '())
(define empty-stream? null?)

(define-syntax cons-stream        ;; дефинираме специална форма
  (syntax-rules ()
    ((cons-stream head tail) (cons head (delay tail)))))

(define head car)
(define (tail stream) (force (cdr stream)))
