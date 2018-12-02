# Week 8

## Асоциативни списъци

Асоциативните списъци са списъци от наредени `(key . value)` двойки.

```scheme
(define assoc-list '((a . 10) (b . 12) (c . 18)))

;; аssoc приема стойност и асоциативен списък
;; връща първата (key . value) двойка, за която стойността е равна на key
;; ако няма такава, връща #f
(assoc 'a assoc-list)   ;; връща '(a . 10)
(assoc 'd assoc-list)   ;; връща #f
```

## Графи

Можем да представим даден граф чрез списъци на съседство - т.е. да го разглеждаме като асоциативен списък, в който ключовете са върховете, а стойностите им - съседите на съотвения връх.

![graph-adjacency-list](https://www.researchgate.net/profile/Carla_Osthoff/publication/274143903/figure/fig3/AS:613978615058433@1523395317311/A-directed-graph-represented-by-adjacency-lists.png)

Горният граф може да бъде записан като
```scheme
(define example-graph
  '((1 . (2))
    (2 . (1 3 4))
    (3 . (3))
    (4 . (1 3))
    (5 . (6))
    (6 . ())))

;; което е просто
;; '((1 2)
;;   (2 1 3 4)
;;   (3 3)
;;   (4 1 3)
;;   (5 6)
;;   (6))
```

## Потоци

Promise наричаме функция, която изчислява нещо (на заден фон) и връща резултат в бъдещ момент от изпълнението на програмата.

```scheme
(delay (+ 5 1))   ;; връща обещание/promise за оценяването на израза (+ 5 1)

(force (delay (+ 5 1)))   ;; налага изчислението на обещанието (delay (+ 5 1))
                          ;; - връща оценката на израза (+ 5 1)
```

Потокът е списък, чиито елементи се оценяват отложено/`lazily` - чак когато ни се наложи да ги използваме.

Базови операции за работа с потоци (от лекции):
```
;; потокът е по дефиниция или празния поток,
(define empty-stream '())
(define empty-stream? null?)

;; или наредена двойка (head . tail), в която
;; head e конкретен елемент, а tail - обещание за поток
(define-syntax cons-stream        ;; дефинираме специална форма
  (syntax-rules ()
    ((cons-stream head tail) (cons head (delay tail)))))

(define head car)
(define (tail stream) (force (cdr stream)))
```

## Задачи

1. Дефинирайте функция `(map-values function assoc-list)`, която прилага `function` над всяка (свързана с ключ) стойност в `assoc-list`

  ```scheme
  (define assoc-list '((a . 10) (b . 12) (c . 18)))

  (map-values (lambda (x) (+ x 1)) assoc-list)
  ;; връща '((a . 11) (b . 13) (c . 19))
  ```

2. Дефинирайте функция `(extend-with assoc-list1 assoc-list2)`, която връща асоциативен списък, съдържащ всички ключове на `assoc-list1` и `assoc-list2`. Ако някой ключ се повтаря, взема този от `assoc-list2`

  ```scheme
  (define assoc-list1 '((a . 10) (b . 12) (c . 18)))
  (define assoc-list2 '((d . 22) (b . 32))

  (extend-with assoc-list1 assoc-list2)
  ;; връща '((a . 10) (b . 32) (c . 18) (d . 22)))
  ;; (не задължително в този ред)
  ```

3. Дефинирайте базовите функция `(vertices graph)`, `(children graph vertex)` и `(edge? graph u v)`,

  ```scheme
  (define example-graph
     '((1 2)
       (2 1 3 4)
       (3 3)
       (4 1 3)
       (5 6)
       (6)))

  ;; намира всички върхове в даден граф
  (vertices example-graph)      ;; връща '(1 2 3 4 5 6)

  ;; намира децата да даден връх в граф
  (children example-graph 4)    ;; връща '(1 3)

  ;; проверява дали съществува ребро между върховете `u` и `v` в дадения `graph`
  (edge? example-graph 1 5)   ;; връща #f
  (edge? example-graph 5 6)   ;; връща #t
  ```

4. Дефинирайте функция `(parents graph vertex)`, която намира родителите на даден връх в граф

  ```scheme
  (parents example-graph 3)   ;; връща '(2 3 4)
  ```

5. Дефинирайте функция `(to-edges graph)`, която връща списък от всички ребра в дадения граф

  ```scheme
  (to-edges example-graph)
  ;; връща
  ;; '((1 . 2) (2 . 1) (2 . 3) (2 . 4)
  ;;   (3 . 3) (4 . 1) (4 . 3) (5 . 6))
  ```

6. Дефинирайте функция `(from-edges edges)`, която конструира граф (представен чрез списъци на съседство) от подадения списък от ребра

  ```scheme
  (from-edges
      '((1 . 2) (2 . 1) (2 . 3) (2 . 4)
        (3 . 3) (4 . 1) (4 . 3) (5 . 6)))    ;; връща example-graph
  ```

7. Дефинирайте функция `(invert graph)`, която връща нова граф, получен от `graph` като "обърнем" всички ребра в него

  ```scheme
  (invert example-graph)
  ;; връща
  ;; '((1 2 4)
  ;;   (2 1)
  ;;   (3 2 3 4)
  ;;   (4 2)
  ;;   (5)
  ;;   (6 5)))

  ```

8. Дефинирайте функция `(contains-path? graph path)`, която проверява дали пътят `path` се съдържа в подадения граф

  ```scheme
  (contains-path? example-graph '(2 4 1 2 3))   ;; връща #t
  (contains-path? example-graph '(2 4 5 2 3))   ;; връща #f
  ```

9. Дефинирайте функция `(symmetric? graph)`, която проверява дали дадения граф е симетричен (ако съществува ребро от връх `u` до `v`, то същвстува и ребро от `v` до `u`)

  ```scheme
  (define example-symmetric-graph
    '((1 2 4)
      (2 1 3 4)
      (3 2 3 4)
      (4 1 2 3)
      (5 6)
      (6 5)))

  (symmetric? example-graph)            ;; връща #f
  (symmetric? example-symmetric-graph)  ;; връща #t
  ```

10. (Анди) Дефинирайте функция `(extend-path graph path)`, която връща всички възможни "разширения" на пътя `path` в дадения граф (търсим прости пътища, т.е. без повторения на върхове)

  ```scheme
  (extend-path example-graph '(1 2)) ;; връща '((1 2 3) (1 2 4))
  ```

11. Дефинирайте функция `(from-to start end)`, която връща поток от целите числа в интервала [a, b]

  ```scheme
  (define numbers (from-to 1 100))
  (head numbers)          ;; връща 1
  (head (tail numbers))   ;; връща 2
  ```

12. Дефинирайте функция `(take-stream stream n)`, която връща списък, съдържащ пътвите `n` елемента на `stream`

  ```scheme
  (take-stream numbers 5)      ;; връща '(1 2 3 4 5)
  ```

13. Дефинирайте функция `(add stream1 stream2)`, която връща нов поток, всеки елемент на който е сумата от елементите на `stream1` и `stream2` на съответната позиция

  ```scheme
  (take-stream (add numbers numbers) 5)   ;; връща '(2 4 6 8 10)
  ```

14. Дефинирайте функция `(from number)`, която генерира безкраен поток с числата от `number` до +безкрайност

  ```scheme
  (take-stream (from 1) 5)    ;; връща '(1 2 3 4 5)
  ```

15. Дефинирайте безкраен поток `fibonacci`, който съдържа числата на Фибоначи

  ```scheme
  (take-stream fibonacci 8)   ;; връща '(0 1 1 2 3 5 8 13)
  ```

16. Дефинирайте функциите `map-stream`, `filter-stream` и `zip-streams`

  ```scheme
  (take-stream (map-stream (lambda (x) (+ x 1)) numbers) 5)   ;; връща '(2 3 4 5 6)
  (take-stream (filter-stream even? numbers) 5)               ;; връща '(2 4 6 8 10)
  (take-stream (zip-streams numbers (tail numbers)) 5)        ;; връща '((1 . 2) (2 . 3) (3 . 4) (4 . 5) (5 . 6))
  ```

17. Дефинирайте функция `(repeat list)`, която конструира безкраен поток, който повтаря задения му списък

  ```scheme
  (take-stream (repeat '(1 2 3)) 10)
  ;; връща '(1 2 3 1 2 3 1 2 3 1)
  ```

18. Дефинирайте функция `(repeat-two list1 list2)`

  ```scheme
  (take-stream (repeat-two '(1 2) '(3 4 5)) 10)
  ;; връща '(1 2 3 4 5 1 2 3 4 5)
  ```
