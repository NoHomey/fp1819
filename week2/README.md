# Week 2

## Рекурсивен vs Итеративен подход

- Рекурсивен подход

  ```scheme
  (define (factorial number)
      (if (< number 2)
          1
          (* number (factorial (- number 1)))))
  ```

  Ето как изглежда развитието на функцията при извикване с аргумент 4:

  ```scheme
  (factorial 4)
  (* 4 (factorial 3))
  (* 4 (* 3 (factorial 2)))
  (* 4 (* 3 (* 2 (factorial 1))))
  (* 4 (* 3 (* 2 1)))
  (* 4 (* 3 2))
  (* 4 6)
  24
  ```
  По време на "разширението" се създава верига от отложени операции, които след това се изпълняват по време на "свиването".

- Итеративен подход  

  For a function to be tail recursive, there must be nothing to do after the function returns except return its value. That is, the last thing that happens in the recursive step is the call to the function itself. 
  
    ```scheme
    (define (factorial number)
        (define (fact-iter product counter max-count)
            (if (> counter max-count)
                product
                (fact-iter (* counter product)
                           (+ counter 1)
                           max-count)))
        (fact-iter 1 1 number))
    ```

    Така изглежда развитието на новата функция при подаден същия аргумент:

    ```scheme
    (factorial 4)
    (fact-iter  1 1 4)
    (fact-iter  1 2 4)
    (fact-iter  2 3 4)
    (fact-iter  6 4 4)
    (fact-iter 24 5 4)
    24
    ```

    На всяка стъпка пазим само константен брой стойности:
    * продукт/product, в който акумулираме стойността, която функцията ще върне
    * брояч/counter
    * max-count, който заедно с брояча образува крайното условие (това, при което процесът приключва)

    Итеративните процеси пазят състояние/state, което може винаги да бъде определено от краен брой променливи.

## Задачи

1. Дефинирайте функция `(sum-divisors number)`, която намира сумата от делителите да дадено число
2. Дефинирайте предикат `(increasing-digits? number)`, която проверява дали цифрите на дадено число да в нарастващ ред
3. Дефинирайте функция `(binary-to-decimal number)`, която приема число в двоична бройна система и връща същото число в десетична бройна система
4. Дефинирайте предикат `(contains? a b)`, който проверява дали числото b се съдържа в a
5. Дефинирайте предикат `(palindrome? number)`, който проверява дали дадено чило е палиндром
6. Дефинирайте предикат `(contains-palindrome? number)`, който проверява дали дадено число съдържа палиндром в себе си 