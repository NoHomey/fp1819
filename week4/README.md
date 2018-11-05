# Week 4

## Припомняме Lambda функции

- синтаксис

    ```scheme
    (lambda (arg1 arg2 ... argn)
        body)
    ```

- lambda функциите могат да бъдат извикани с аргументи веднага след дефиницията си

    ```scheme
    ((lambda (a) (+ a 1)) 1)    ;; връща 2
    ```

## Функции от по-висок ред, които връщат функция като резултат (генератори на функции)

Да разгледаме функцията `flip`

```scheme
(define (flip f)
  (lambda (x y)
    (f y x)))
```

`flip` приема като аргуемент друга функция - `f` над два аргумента.  
Като резултат връща нова функция над два аргумента.  
Единствената разлика между входната и изходната функция е наредбата на аргументите им.

```scheme
;; - is a function which takes 2 arguments
;; and subtracts the second argument from the first one
(- 2 1)           ;; returns 1

;; (flip -) is a function which also takes 2 arguments
;; however it subtracts the first argument from the second one
((flip -) 2 1)    ;; returns -1
```

Друг пример е функцията `negate`

```scheme
(define (negate predicate)
  (lambda (argument)
    (if (predicate argument) #f #t)))
```
Функциите `predicate` и `(negate predicate)` винаги връщат противоположни отговори при подаден един и същ аргумент.

```scheme
(even? 5)                 ;; връща #f
((negate even?) 5)        ;; връща #t

(define (odd? number)
  ((negate even?) number))
```

## Наредени двойки

Наредена двойка наричаме `(A . B)`, съставена от две произволни стойности.  
Първия елемент можем да вземем, използвайки функцията `car`, втория - `cdr`.  
Функцията, която ги комбинира в наредена двойка, наричаме `cons`.

![dotted-pair](https://berkeley-cs61as.github.io/static/lab9-1.png)

```scheme
(cons 1      #t)     ;; наредена двойка от оценките на 1 и #t      - (1 . #t)
(cons 1 (+ 2 3))     ;; наредена двойка от оценките на 1 и (+ 2 3) - (1 .  5)

(car (cons a b))     ;; връща а
(cdr (cons a b))     ;; връща b
```

Може някоя от стойностите на наредената двойка да е друга наредена двойка (да ги влагаме).

![nested-pairs](http://www.sicpdistilled.com/images/fig2.3-bcc40365.png)

## quote

```scheme
(+ 2 3)           ;; оценява се до 5
(quote (+ 2 3))   ;; оценява се до списъка (+ 2 3)
'(+ 2 3)          ;; оценява се до списъка (+ 2 3)
```

## Списъци

Рекурсивна дефиниция:

- празният списък '() е списък
- (a . b) е списък, ако b е списък

```scheme
(cons 1 (cons 2 (cons 3 '())))      ;; е eквивалентно на
'(1 . (2 . (3 . ())))               ;; е еквивалентно на
'(1 2 3)

(car '(1 2 3))      ;; връща 1
(cdr '(1 2 3))      ;; връща '(2 3)
```

## Вградени функции за списъци

- null? - проверява дали списъкът е празен
- list?
- list - построява списък с оценките на подадените му аргументи

  ```scheme
  (list 1 (+ 2 3) 4)      ;; връща списъка (1 5 4)
  '(1 (+ 2 3) 4)          ;; връща списъка (1 (+ 2 3) 4)
  ```

- length
- append - конкатенира аргументите си в нов списък

  ```scheme
  (append '(1 2 3) '(4) '(5 6))  ;; връща списъка (1 2 3 4 5 6)
  ```

- reverse
- member?

  ```scheme
  (member 2 '(1 2 3 4))     ;; връща списъка (2 3 4)
  (member 5 '(1 2 3 4))     ;; връща #f
  ```

## Линейно обхождане на списъци

```scheme
(define (sum list)
  (if (null? list)
      0
      (+
        (car list)
        (sum (cdr list)))))
```

Нищо ново тук! Oтново имаме:
- дъно - празен ли е списъкът
- рекурсивно извикване с "опашката" на списъка (списъка без първия си елемент)

## Задачи

1. Дефинирайте функция `(compose f g)`

  ```scheme
  (define (f x) (+ x 1))
  (define (g x) (* x 5))

  ((compose f f) 1)   ;; връща  3
  ((compose g g) 1)   ;; връща 25
  ((compose f g) 1)   ;; връща  6
  ((compose g f) 1)   ;; връща 10
  ```

2. (Георги) Дефинирайте функция `(add-n number)`, коятo връща функция, която при подаден аргумент връща сумата му с number.

  ```scheme
  ((add-n 10) 5)  ;; връща 15
  ```

3. Дефинирайте функция `(derive f h)`, която връща производната на функцията `f`.  
![derivative](https://cdn-images-1.medium.com/max/1600/1*1wUD_t4Ufp8Ef9NQzcydWQ.png)

  ```scheme
  (define (f x)
    (+ (* x x) 1))                ;; f(x) = x^2 + 1

  ((derive f 0.00001) 5)          ;; f'(x) = 2*x
                                  ;; returns something around 10
  ```

4. Дефинирайте функция `(my-length list)`

5. Дефинирайте функция `(my-member? element list)`

6. Дефинирайте функция `(take n list)`, която връща списъка от първите `n` елемента на `list`

7. Дефинирайте функция `(my-append list1 list2)`

8. Дефинирайте функция `(my-reverse list)`

9. Дефинирайте функции `(all? list predicate)` и `(any? list predicate)`, които проверяват дали всички (съответно, поне един) от елементите изпълняват подаденото условие
