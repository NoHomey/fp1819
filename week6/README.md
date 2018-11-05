# Week 6

## Матрици

Можем да представим матрица като списък от списъци с равен брой елементи.

```scheme
'((1))        ;; матрица 1x1

'((1 2 3)
  (4 5 6))    ;; матрица 2x3
```

Дефинираме няколко базови операции:

```scheme
;; бележка
;; list-ref приема списък и индекс и връща елемента на този индекс
(list-ref '(1 2 3) 0)   ;; връща 1

(define get-row-count length)

(define (get-column-count matrix)
  (length (car matrix)))

(define (get-row matrix index)
  (list-ref matrix index))

(define (get-column matrix index)
  (define (get-nth-element list)
      (list-ref list index))
  (map get-nth-element matrix))
```

```scheme
(define matrix '((1 2 3)
                 (4 5 6)
                 (7 8 9)))

(get-row-count matrix)      ;; връща 3
(get-column-count matrix)   ;; връща 3
(get-row    matrix 1)       ;; връща '(4 5 6)
(get-column matrix 1)       ;; връща '(2 5 8)
```

## Задачи

```scheme
(define matrix '((1 2 3)
                 (4 5 6)
                 (7 8 9)))
```

1. Дефинирайте функция `(sum matrix)`, която намира сумата на всички елементи в матрица

  ```scheme
  (sum matrix)  ;; връща 45
  ```

2. Дефинирайте функция `(diagonal matrix)`, която връщa диагонала на дадена матрица

  ```scheme
  (diagonal matrix)  ;; връща '(1 5 9)
  ```

3. Дефинирайте функция `(min matrix)`, която намира най-малкия елемент в дадена матрица

  ```scheme
  (min matrix)  ;; връща 1
  ```

4. Дефинирайте функция `(transpose matrix)`, която транспонира матрица

  ```scheme
  (transpose matrix)  
  ;; връща '((1 4 7)
  ;;         (2 5 8)
  ;;         (3 6 9))
  ```

5. (Георги) Дефинирайте функция `(set matrix x i j)`, която връща същата матрица, но на позиция `(i, j)` се намира елемента `x`

  ```scheme
  (set matrix 0 1 1)
  ;; връща '((1 2 3)
  ;;         (4 0 6)
  ;;         (7 8 9))
  ```

6. Дефинирайте функции `(skip-row matrix index)` и `(skip-column matrix index)`, които връщат нови матрица, с премахнат съответно ред или колона `index` от `matrix`

  ```scheme
  (skip-row matrix 1)
  ;; връща '((1 2 3)
  ;;         (7 8 9))

  (skip-col matrix 1)
  ;; връща '((1 3)
  ;;         (4 6)
  ;;         (7 9))
  ```

7. Дефинирайте функция `(sum matrix1 matrix2)`, която събира две матрици

  ```scheme
  (sum '((1 2 3)   '((0 1 2)
         (4 5 6)     (3 4 5)
         (7 8 9))    (6 7 8)))

  ;; връща '(( 1  3  5)
  ;;         ( 7  9 11)
  ;;         (13 15 17))
  ```

8. Дефинирайте функция `(product matrix1 matrix2)`, която умножава две матрици

  ```scheme
  (product '((1 2 3)   '((0 1 2)
             (4 5 6)     (3 4 5)
             (7 8 9))    (6 7 8)))

  ;; връща '((24  30  36)
  ;;         (51  66  81)
  ;;         (78 102 126))
  ```

9. (Анди) Дефинирайте функция `(triangular? matrix)`, която проверява дали дадена матрица е горно-триъгълна (всички елементи под главния диагонал са нули).

  ```scheme
  (triangular? '((1 2 3 4)
                 (0 5 6 7)
                 (0 0 8 9)
                 (0 0 0 1)))  ;; връща #t
  ```
