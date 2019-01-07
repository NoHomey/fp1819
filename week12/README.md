# Week 12

## [Point-free style](https://wiki.haskell.org/Pointfree#But_pointfree_has_more_points.21)

Прилагане на функции с `$`
 - докато нормалното прилагане на функции е с най-висок приоритет и е лявоасоциативно, `$` е с най-нисък и е дясноасоциативно
 - помага ни да не пишем толкова много скоби (можем да заменим отварящите скоби с `$`)

  ```haskell
  ghci> sum (filter (> 10) (map (*2) [2..10]))  -- е еквивалентно на
  ghci> sum $ filter (> 10) $ map (*2) [2..10]
  ```

Композиране на фунцкции с `.`
  - изразът `f (g x)`, където `f` и `g` са функции, а `x` - аргумент, може да бъде заменен с `(f . g) x`

  ```haskell
  ghci> ceiling (negate (tan (cos (max 50 15))))  -- е еквивалентно на
  ghci> ceiling . negate . tan . cos . max 50 $ 15  
  ```

## [Класове от типове](http://learnyouahaskell.com/types-and-typeclasses#typeclasses-101)

Класовете от типове са интерфейс, който дефинира някакво поведение. Някой тип може да бъде направен инстанция на даден клас ако поддържа това поведение.

Някои основни класове от типове:
- `Eq` - включва типовете, чиито стойности могат да се сравняват, използвайки `==` и `/=`
- `Ord` - включва типовете, чиито стойности имат наредба и могат да се сравняват използвайки `>`, `<`, `>=`, `<=` и `compare`
- `Integral` - включва типовете `Int` и `Integer`
- `Floating` - включва типовечт `Float` и `Double`
- `Num` - включва числените типове
- `Show` - включва типовете, чиито стойности могат да бъдат представени като низове (досега всичко без функциите)
- `Read` - включва типовете, чиито стойности могат да бъдат прочетени от низове

Пример:  
По-рано бяхме дефинирали функция `remdups'`, която премахва повтарящите се срещания на елементи в списък.  
Ако искаме сами да напишем типовата дефиниция да `remdups'` и държим тя да е възможно най-обща (да работи с всички сравними за еднаквост типове (а не само някой конкретен)), бихме написали:

```haskell
remdups' :: (Eq a) => [a] -> [a]
-- remdups' тяло на функцията
```

## Синоним на тип

Типовите синоними ни позволяват да задаваме нови имена на вече съществуващи типове. С тях не създаваме нови типове, използваме ги най-вече за по-добра четимост на кода.

```haskell
type String = [Char]  -- типовете `[Char]` и `String` са
                      -- еквивалентни и взаимнозаменяеми.
```

Типовите синоними могат да бъдат и параметризирани.

```haskell
type AssocList k v = [(k,v)]  -- асоциативен списък с ключове от тио k
                              -- и стойности от тип v
```

## [Потребителски дефинирани типове](http://learnyouahaskell.com/making-our-own-types-and-typeclasses#algebraic-data-types)

Типът `Bool` e дефиниран по следния начин:

```haskell
data Bool = False | True  
-- четем: Bool може да има стойност False или True
-- Bool е името на типа, а False и True са value constructors (конструктори на стойности)
```

Можем да дефинираме собсвен тип `Shape`:
```haskell
data Shape = Circle Float Float Float | Rectangle Float Float Float Float
-- четем: Shape може да бъде Circle или Rectangle
-- Shape е името на типа, а Cirlce и Rectangle - конструкторите на стойностите на типа (констукторите на стойности са просто фунцкии, които приемат аргументи и връщат стойност от съотвения тип)
-- Circle конструкторът приема точка в равнината и радиус
-- Rectangle конструкторът приема две точки в равнината
```

При дефинирането на собсвени типове, можем да използваме record синтаксис.

```haskell
data Shape =
  Circle { x :: Float, y :: Float, radius :: Float } |
  Rectangle { x :: Float, y :: Float, upperRightX :: Float, upperRightY :: Float}
```

Предимствата на този синтаксис са:
- прави кода по-четим
- автоматично създава getter-функции, с които да достъпваме съотвените полета
```haskell
ghci> radius (Circle 0.0 0.0 5)   -- връща 5
```

Как използваме дефинираните от нас типове?

```haskell
surface :: Shape -> Float  
surface (Circle _ _ r) = pi * r ^ 2  
surface (Rectangle x1 y1 x2 y2) = (abs $ x2 - x1) * (abs $ y2 - y1)  
```
```haskell
ghci> surface $ Circle 10 20 10  
314.15927  
ghci> surface $ Rectangle 0 0 100 100  
10000.0  
```

Важни моменти тук:
 - типовата декларация - функцията `surface` приема аргумент от тип `Shape`; не бихме могли да напишем, че `surface` приема аргумент от тип `Circle`, защото `Circle` не е тип, а конструктор (когато дефинираме даден тип, частта преди = е типовият констуктор, а частта след него - констукторите на стойности (разделени с `|`)
 - pattern matching-a - можем да pattern match-ваме по конструкторите на типа - `Circle` и `Rectange`

## Maybe

Типът `Maybe` е дефиниран по следния начин:

```haskell
data Maybe a = Nothing | Just a  deriving (Eq, Ord, Read, Show)
-- тук 'а' е типов параметър
-- понеже 'а' е типов параметър, то
-- Maybe е типов конструктор (Maybe не е тип)
-- сам по себе си, но Maybe Int примерно е
```

`Maybe` се държи като кутия - обгражда елемента в него и добавя нов слой абстракция, като не се интересува от типа на самия елемента.

## Either

Типът `Either` е дефиниран по следния начин:
```haskell
data Either a b = Left a | Right b deriving (Eq, Ord, Read, Show)  
```

Можем да използваме `Maybe`, за да представим резултата от изчисления, които могат да бъдат успешни или не.  
Ако искаме да върнем повече информация защо изчислението не е било успешно, можем да използваме `Either`.

## Задачи

1. Дефинирайте познаните безкрайни списъци `fibonacci` и `facts`

2. Дефинирайте безкраен списък `rollerCoasterStream n`, такъв че:

  ```haskell
  ghci> take 12 (rollerCoasterStream 5)  -- връща [1,2,3,4,5,4,3,2,1,2,3,4]
  ```

3. Дефинирайте безкраен списък `primes`, който съдържа всички просто числа.

  ```haskell
  ghci> take 5 primes  -- връща [2,3,5,7,9]
  ```

4. Петък е и Крис решава да обиколи баровете в София.  
   Всеки бар има `име` и `координати` (дефинирайте типове `Coordinates` и `Bar`).

   Дефинирайте функция `alcoholismPath :: Coordinates -> [Bar] -> [String]`, която приема `координатите на дома на Крис` и `списък с барове` в София, и намира най-краткия път, такъв че Крис обикаля всички барове и накрая се прибира вкъщи.  

   Понеже в пиянството си Крис минава направо през къщи и блокове, приемаме разстоянието между две точки като правата линия между тях.

5. Петък е и Шуши решава да обиколи баровете в София.  
   Всеки бар има `име`, `брой необвързани момичета` и `цена на бутилка бира` (дефинирайте типа `Bar`).

   Дефинирайте функция `girlsPath :: Double -> [Bar] -> [String]`, която приема
   `бюджета на Шуши за вечерта` и `списък с барове` в София, и намира помножество от баровете, такова че Шуши се запознава с въжможно най-много момичета.

   Приемаме, че Шуши си купува по бира във всеки бар, в който влезе, и заговаря всяко необвързано момиче в него.

6. TODO: lockers with AssocList