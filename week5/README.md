# Week 5

## `=` vs `eq?` vs `eqv?` vs `equal?`

[Отговор в stackoverflow с примери](https://stackoverflow.com/questions/16299246/what-is-the-difference-between-eq-eqv-equal-and-in-scheme)

Обобощение:

- използваме `=` когато работим с числа
- използваме `eqv?` когато работим с прости типове
- използваме `equal?` когато работим и със списъци
- не използваме `eq?`, oсвен ако знаем какво правим (а ние не знаем)

## Функции от по-висок ред за списъци

- `(map function list)`
  - приема функция и списък
  - връща нов списък, съставен от елементите на първия `list`, върху всеки от който е приложена `function`

  ```scheme
  (map (lambda (x) (+ x 1)) '(1 2 3))     ;; връща   '(2 3 4)
  (map car ' ((1 2 3) (4) (5 6) (7)))     ;; връща '(1 4 5 7)
  (map
      (lambda (f) (f 2))
      (list even? (lambda (x) (+ x 1)) list))    ;; връща '(#t 3 (2))
  ```

- `(filter predicate list)`
  - приема функция-предикат и списък
  - връща нов списък, съставен от елементите на първия `list`, които изпълняват условието `predicate`

  ```scheme
  (filter (lambda (x) (> x 4)) '(2 3 4 5))     ;; връъща          '(5)
  (filter pair?          '(1 (2) (3 4 5)))     ;; връща '((2) (3 4 5))
  ```

- `(foldl function null-value list)`
  - приема функция, нулева стойност и списък
  - подобно на `map` прилага `function` над елементите на `list`, но докато `map` комбинира резултатите в нов списък, `foldl` ги комбинира по произволен начин, определен от `function`

  ```scheme
  ;; (foldl function null-value '(a1 a2 a3 .. an)) връща
  ;; (an function (... (a3 function (a2 function (a1 function null-value)))))

  ;; равно на (4 + (3 + (2 + (1 + 0))))
  (foldl    +   0 '(1 2 3 4))    ;; връща 10

  ;; равно на (4 - (3 - (2 - (1 - 0))))
  (foldl    -   0 '(1 2 3 4))                 ;; връща 2
  (foldl
      (lambda (curr accum) (- curr accum))
      0
      '(1 2 3 4))                             ;; връща 2

  ;; равно на (cons 4 (cons 3 (cons 2 (cons 1 '()))))
  (foldl cons '() '(1 2 3 4))    ;; връща '(4 3 2 1)

  ```

- `(foldr function null-value list)`
  - приема функция, нулева стойност и списък (също като foldl)
  - работи също като foldr, но обхожда `list` от ляво надясно
  - `foldl` генерира итеративен процес, докато `foldr` генерира рекурсивен процес и заема памет, пропорционална на дължината на списъка

  ```scheme
  ;; (foldr function null-value '(a1 a2 a3 .. an)) връща
  ;; (a1 function (a2 function (a3 function (... (an function null-value)))))

  ;; "fold-right can be thought of as replacing the pairs in the spine of  
  ;; the list with procedure and replacing the () at the end with initial"

  ;; равно на (1 + (2 + (3 + (4 + 0))))
  (foldr    +   0 '(1 2 3 4))    ;; връща 10

  ;; равно на (1 - (2 - (3 - (4 - 0))))
  (foldr    -   0 '(1 2 3 4))                 ;; връща -2
  (foldr
      (lambda (curr accum) (- curr accum))
      0
      '(1 2 3 4))                             ;; връща - 2

  ;; равно на (cons 1 (cons 2 (cons 3 (cons 4 '()))))
  (foldr cons '() '(1 2 3 4))    ;; връща '(1 2 3 4)
  ```

- `(foldl1 function list)` и `(foldr1 function list)`
  - работят като `foldl` и `foldr`, но за null-value вземат първия/последния елемент на списъка (т.е. `list` трябва да е непразен списък)

## Задачи

1. Дефинирайте функция `(generate-interval start end)`, която по зададени начало и край, връща списък с всички целочислени числа в затворения интервал `[start, end] `

  ```scheme
  (generate-interval 1 5)      ;; връща '(1 2 3 4 5)
  ```

2. (Анди) Дефинирайте функция `(zip list1 list2)`, която връща списък отнаредени двойки от техните съответни елементи:

  ```scheme
  (zip '(1 2 3 4) '(#t #f #f))    ;; връща '((1 . #t) (2 . #f) (3 . #f))
  ```

3. Дефинирайте функция `(member-deep? element list)`, която работи като `member?`, но търси елемента и във вложените списъци, ако има такива

4. Дефинирайте функция `(my-flatten list)`, която разкрива всички вложени списъци
Упътване: използвайте предиката `pair?`

  ```scheme
  (my-flatten '(1 (2 3) (4 (5) 6)))       ;; връща '(1 2 3 4 5 6)
  ```

4. (Анди) Дефинирайте функция `(insertion-sort list)`  
Упътване: дефинирайте преди това функция `(insert element sorted-list)`, която поставя `element` на правилното място в сортирания списък `sorted-list`

  ```scheme
    (insert 3 '(1 2 6 7))              ;; връща '(1 2 3 6 7)
    (insertion-sort '(4 3 6 2 1 8 10)) ;; връща '(1 2 3 4 6 8 10)
  ```

5. Дефинирайте функции `(union list1 list2)` и `(intersection list1 list2)`, които връщат съответно обединението и сечението на `list1` и `list2` (без повторения)

6. Дефинирайте `my-map`, `my-filter` и някой от `fold`-овете

7. Дефинирайте функция `(my-map function list)` - използвайте някой `fold`

8. Дефинирайте функция `(compose function-list)`, която композира няколко функции (подобно на `(compose f g)` oт миналия път, но тук взимаме списък от функции) - използвайте някой `fold`
Внимание: `compose` връща нова функция

  ```scheme
  ((compose (list
      (lambda (x) (+ x 1))
      (lambda (x) (+ x 2))
      (lambda (x) (+ x 3)))) 1)     ;; връща 7
  ```

9. Дефинирайте функция `(sublists list)`, която намира всички подсписъци на `list`

  ```scheme
  ;; връща '(() (1) (2) (3) (1 2) (2 3) (1 2 3)) в произволен ред
  (sublists '(1 2 3))
  ```

10. Дефинирайте функция `(subsets list)`, която намира всички подмножества на `list`

  ```scheme
  ;; връща '(() (1) (2) (3) (1 2) (1 3) (2 3) (1 2 3)) в произволен ред
  (subsets '(1 2 3))
  ```
