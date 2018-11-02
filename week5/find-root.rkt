#lang racket

;; тотална - дефинирана навсякъде, т.е. за всяко x съществува y, такова че f(x) = y

;; монотонна - намаляваща или нарастваща

;; пресича абсцисата - т.е. ако коренът на уравнението е x0 и той се намира в интервала (x1, x2),
;; знаем че f(x1) * f(x2) < 0
;; пример: представяме си, че е монотонно нарастваща графика
;; в някакъв момент линията на графиката се движи към абсцисната ос отдолу (има отрицателни стойности),
;; пресича я (там е коренът x0), след което продължава нагоре (има положителни стойнсти)

;; точност 10^-6 (или 0.000001), т.е. трябва постоянно да намаляме интервала в който търсим корена x0;
;; ако намалим интервала до (x0 - 0.000001, x0 + 0.000001), приемаме, че сме достатъчно близо
;; и спираме търсенето

(define (contains-the-root? start end function)
  (<= (* (function start) (function end)) 0))


;; TODO: can this be simplified?
(define (find-root function)
  (define (helper start end function)
    (let
      ((good-enough? (< (abs (- start end)) 0.000001))
       (function-is-increasing? (< (function start) (function end)))
       (interval-middle (/ (+ start end) 2.0)))
    (cond
      ((= 0 (function start)) start)
      ((= 0 (function   end))   end)
      ((and (contains-the-root? start end function) good-enough?) start)
      ((contains-the-root? start end function) (if (contains-the-root? start interval-middle function)
                                                   (helper start interval-middle function)
                                                   (helper interval-middle end function)))
      ;; следващите две условия не са задължителни
      ;; те хващат случаите, в които интервалът (start, end), подаден в самото начало
      ;; не обхваща корена
      (function-is-increasing? (if (< (function start) 0)
                                   (helper end (+ end 1000) function)
                                   (helper (- start 1000) start function)))
      (else (if (< (function start) 0)
                (helper (- start 1000) start function)
                (helper end (+ end 1000) function))))))
  (helper -1000 1000 function))

(find-root (lambda (x) (- (* 3 x) 6)))       ;; връща 2
