# Week 1

## DrRacket

- [Racket (PLT Scheme)](https://docs.racket-lang.org/guide/intro.html) vs [R5RS](https://docs.racket-lang.org/r5rs/r5rs-std/r5rs-Z-H-2.html#%_toc_start) vs R6RS
- REPL (read-eval-print loop)
- [DrRacket](https://racket-lang.org/) - за Windows, Linux and Mac OS
    + definitions panel (за дефиниране на програми) + interactions panel (за интерактивно оценяване на изрази) + run бутон (прави дефинираните в definitions panel програми достъпни в interactions panel)
    + `#lang racket` or `#lang r5rs`
- Алтернативи
    + [repl.it](https://repl.it/)
    + текстов редактор по избор + зареждане на програмата чрез racket, mzscheme, друго
    + emacs

## Синтаксис

- TODO: шега за скоби

- [индентация](http://community.schemewiki.org/?scheme-style)

- коментари
    + single-line коментари - чрез ;
    + multiline коментари - чрез #| |#

- прости типове данни
    + boolean - #t, #f
        * всички стойности, различни от #f, се приемат за истина
        * разни функции - `boolean?`,  `and`, `or`, `not`

    + number - integer, rational (eg 22/7), real (eg 3.14), complex (eg 2+3i)
        * разни функции - `integer?`, `rational?`, `real?`, `complex?`, `=`, `>`, `>=`, `<`, `<=`, `+`, `-`, `*`, `/`, `remainder` (`mod` в REPL.it), `quotient` (`div` в REPL.it), `abs`, `expt`, `sqrt`, `min`, `max`, `round`

    + character - префиксва се с #\
        * разни функции - `char?`

    + string - между двойни кавички
        * разни функции - `string?`, `substring`, `string-append`

- прилагане на функции - `(function arg1 arg2 … argN)`
    + инфиксен запис
    + първо се оценяват стойностите на аргументите (отляво надясно) и тогава се прилага функцията
    + някои функции приемат фикциран брой аргументи (пр. substring, remainder), друго - приемат произволен брой аргументи (пр. string-append, +)

- дефиниции
    + дефиниране на израз

        `(define symbol expression)`
    + дефиниране на функция  

        `(define (function-name parameters) body)`

- условни изрази
    + if израз

        ```scheme
        (if predicate
            consequent
            alternative)
        ```
    + cond израз

      ```scheme
      (cond
          (pred1 expr1)
          (pred2 expr2)
          (else expr3))
      ```

- рекурсия

## Примери

```scheme
(define name "bepce")
(define (greeting name)
  (string-append "zdr kp " name))
```

```scheme
(define (square x) (* x x))
(define (sum-of-squares x y)
  (+ (square x) (square y)))
```

```scheme
(define (fibonacci number)
  (if (<= number 2)
      1
      (+ (fibonacci (- number 1)) (fibonacci (- number 2)))))
```

## Задачи

1. Дефинирайте предикат `(even? number)`, който проверява дали дадено число е четно
2. Дефинирайте предикат `(triangle-sides? a b c)`, който проверява дали а, b, c могат да бъдат страни на триъгълник
3. Дефинирайте функция `(factorial number)`, която връща number!
4. Дефинирайте функция `(power base exp)`, която връща base на степен exp
5. Дефинирайте функция `(gcd a b)`, която връща най-големия общ делител на a и b
6. Дефинирайте функция `(sum start end)`, която намира сумата да всички целочислени числа в интервала [sum, end]
7. Дефинирайте функция `(fibonacci n)`, която връща n-тото число на Фибоначи
8. Дефинирайте предикат `(prime? number)`, който проверява дали дадено число е просто
9. Дефинирайте функция `(decimal-to-binary number)`, която по дадено число в десетична бройна система, връща същото число в двоична бройна система
10. Дефинирайте функция `(reverse number)`, която "обръща" дадено число
