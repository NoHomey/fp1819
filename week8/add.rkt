#lang racket

(require "streams.rkt"
         "take-stream.rkt"
         "from-to.rkt")       ;; where "numbers" is defined

(provide add)

;; връща нов поток, всеки елемент на който е сумата от елементите на stream1 и stream2 на съответната позиция
(define (add stream1 stream2)
  (if (or (empty-stream? stream1) (empty-stream? stream2))
      empty-stream
      (cons-stream
          (+
              (head stream1)
              (head stream2))
          (add
              (tail stream1)
              (tail stream2)))))

;; (take-stream (add numbers numbers) 5)   ;; връща '(2 4 6 8 10)
