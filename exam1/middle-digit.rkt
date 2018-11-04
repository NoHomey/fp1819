#lang racket

(define (digits-length number)
  (if (< (abs number) 10)
      1
      (+ 1 (digits-length (quotient number 10)))))

;; gets the nth digit counting from right to left
;; the count begins from 1
(define (get-nth-digit n number)
  (if (= n 1)
      (remainder number 10)
      (get-nth-digit (- n 1) (quotient number 10))))

(define (middle-digit number)
  (if (even? (digits-length number))
      -1
      (abs (get-nth-digit
                        (+
                          (quotient (digits-length number) 2)
                          1)
                        number))))
