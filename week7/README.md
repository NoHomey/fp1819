# Week 7

## Функции с произволен брой аргументи

Можем да дефинираме функция, която приема произволен брой аргументи, използвайки `.`. Така казваме на scheme, че искаме конкретните аргументи, с които викаме функцията, да бъдат пакетирани в списък, който подаваме на функцията като един единствен аргумент.

```scheme

;; функция, която приема произволен брой аргументи,
;; и изписва списъка от подадените и параметри
(define (display-all . args)
   (display args))

(display-all 1 2 "hi")    ;; изписва (1 2 "hi")

;; функция, която приема поне един аргумент (и произволен брой
;; допълнителни аргументи), и ги изписва
(define (display-all2 first . rest)
  (display first)
  (display rest))

(display-all2 1 2 "hi")   ;; изписва 1(2 "hi")
;; 1 се свързва с променливата first,
;; a останалите аргументи се пакетират в списъка rest
```

Едно от приложенията на функциите с произволен брой аргументи е да позволяваме подаването на "optional" аргументи със стойности по подразбиране.

```scheme
(define (example first second . rest)
  (let
    ((third (if (null? rest)
                10
                (car rest))))
  (+ first second third)))

(еxample 1 2)       ;; връща 13
(example 1 2 3)     ;; връща 6
(example 1 2 3 4)   ;; връща 6
```

## `map` с произволен брой аргументи

`(map function list1 list2 ...)`

Функцията `map` приема като аргументи функция и един или повече списъка.
- `function` трябва да е функция над толкова аргумента, колкото са списъците `list`
- ако повече от един списък `list` е подаден, трябва всичките да са с еднаква дължина
- `function` бива извикана по веднъж за всяка позиция в списъците, като използва за аргументи списъка от елементи на тази позиция
- `map` връща списък от резултатите

```scheme
(map - '(2 3 4))    ;; връща '(-2 -3 -4)

(map + '( 1  2  3)
       '(10 20 30)) ;; връща '(11 22 33)
;; еквивалентно на
;; (list (+ 1 10) (+ 2 20) (+ 3 30))
```

## `аpply`

`(apply function argument-list)`

Функцията `apply` приема 2 аргумента - функция и списък от аргументи, над които да бъде извикана функцията.

```scheme
(apply - '(1 2 3))  ;; връща -4
```

## `eval`

`(eval expression environment)`

Функцията `eval` приема 2 аргумента - израз, който искаме да оценим, и средата, в която той да бъде оценен.  

- `eval` прави обратното на `quote`
- можем динамично да конструираме изразите, които подаваме на `eval`
- [пример за използване на `eval`](https://courses.cs.washington.edu/courses/cse341/02sp/scheme/apply-eval.html)

```scheme
(eval '(* 5 (+ 10 0)))  ;; връща 50
;; понеже сме използвали ', оценката на израза '(* 5 (+ 10 0))
;; е списък от символи, а не резултата от събирането и умножението;
;; eval оценява списъка от символи, третирайки го като код на scheme
```

## Двоични дървета

Представяме двоичните дървета като вложени списъци със следната конструкция:  

`(root left-tree right-tree)`

```scheme
(define example-tree
  '(1
      (2 () ())
      (3
          (4 () ())
          (5 () ()))))
```

Базови операции (от лекции):
```scheme
(define (tree? t)
  (or (null? t)
      (and (list? t)
           (= (length t) 3))
           (tree? (cadr t))
           (tree? (caddr t))))

(define empty-tree '())
(define empty-tree? null?)

(define (make-tree root left right) (list root left right))

(define left-tree cadr)
(define right-tree caddr)

```

## Задачи

```scheme
(define example-tree
  '(1
       (2 () ())
       (3
           (4 () ())
           (5 () ()))))

(define example-binary-search-tree
  '(3
      (1
          ()
          (2 () ()))
      (4
          ()
          (5 () ()))))
```

1. Дефинирайте функция `plus`, която приема произволен брой аргументи и ги сумира

1. (Анди) Дефинирайте функция `(sum tree)`, която намира сумата на всички елементи на дървото `tree`

  ```scheme
  (sum example-tree)    ;; връща 15
  ```

2. Дефинирайте функция `(map-tree function tree)`

  ```scheme
  (map (lambda (x) (+ x 1)) example-tree)    
  ;; връща '(2
  ;;           (3 () ())
  ;;           (4
  ;;               (5 () ())
  ;;               (6 () ())))
  ```

3. Дефинирайте функция `(level tree i)`, която връща списък от стойностите на възлите, намиращи се на дълбочина i от корена

4. Дефинирайте функции `(inorder tree)`, `(preorder tree)` и `(postorder tree)`, които връщат списък от всички елементи на `tree`, получени при съответното обхождане  

  ```scheme
  ;; inorder - left, root, right  
  (inorder example-tree)    ;; връща '(2 1 4 3 5)

  ;; preorder - root, left, right
  (preorder example-tree)   ;; връща '(1 2 3 4 5)

  ;; postorder - left, right, root
  (postorder example-tree)  ;; връща '(2 4 5 3 1)
  ```

5. (Анди) Дефинирайте функция `(binary-search-tree? tree)`, която проверява дали дървото tree е наредено

  ```scheme
  (binary-search-tree? example-tree)                  ;; връща #f
  (binary-search-tree? example-binary-search-tree)    ;; връща #t
  ```

6. Дефинирайте функция `(construct-binary-search-tree sorted-list)`, която по даден сортиран списък конструира двоично наредено дърво.  
Дефинирайте помощна функция `(insert binary-search-tree element)`,която  вмъква `element` на подходящото място в двоично наредено дърво

7. Дефинирайте фунцкия `(contains? tree path)`, която проверява дали даден път `path` - списък от стойности, се съдържа в `tree`

  ```scheme
  (contains? example-tree '(1 3 5))   ;; връща #t
  (contains? example-tree '(1 2 4))   ;; връща #f
  ```

8. Дефинирайте функция `(symmetric? tree)`, която проверява дали дадено дърво е симетрично (разглеждаме само структурата му, не и стойностите във възлите му)

  ```scheme
  (define example-symmetric-tree
    '(1
        (2
            ())
            (4 () ())
        (3
            (5 () ())
            ())))

  (symmetric? example-tree)             ;; връща #f
  (symmetric? example-symmetric-tree)   ;; връща #t
  ```

9. Дефинирайте функция `(paths tree)`, която намира всички пътища в `tree`

  ```scheme
  (paths example-tree)     ;; връща '((1 2) (1 3 4) (1 3 5))
  ```
