# Week 13

## [Рекурсивни типове](http://learnyouahaskell.com/making-our-own-types-and-typeclasses#recursive-data-structures)

```haskell
data List a = Empty | Cons a (List a) deriving (Show, Read, Eq, Ord)  
{-
  или
  data List a = Empty | Cons { listHead :: a, listTail :: List a}
    deriving (Show, Read, Eq, Ord)  
-}
```

```haskell
ghci> Empty  
Empty

ghci> 5 `Cons` Empty  
Cons 5 Empty  

ghci> 4 `Cons` (5 `Cons` Empty)  
Cons 4 (Cons 5 Empty)  
```

#### Двоични дървета

```haskell
data BinaryTree a = EmptyTree | Node a (BinaryTree a) (BinaryTree a) deriving (Show, Read, Eq)  
```

## [main функция & IO](http://learnyouahaskell.com/input-and-output#hello-world)

```haskell
main = putStrLn "hello, world"  
```

```haskell
$ ghc --make helloworld  
[1 of 1] Compiling Main             ( helloworld.hs, helloworld.o )  
Linking helloworld ...  

$ ./helloworld  
hello, world  
```

`putStrLn` е функция от тип
```haskell
putStrLn :: String -> IO ()
-- приема низ и връща I/O action, който има резултат от тип ()
-- не разглеждаме putStrLn като функция, която приема низ и го изписва на екрана,
-- а като функция, която прима низ и връща IO action, който при изпълнението си изписва низ на екрана
```

При изпълнението си, `I/O action` има странични ефекти (примерно, четене и писане в конзолата). Изпъляваме `I/O action` като му дадем име `main` и run-нем програмата.

Може да искаме да извършим повече от един `I/O actions`.  
Тогава използваме `do`.

```haskell
main = do  
  putStrLn "Hello, what's your name?"  
  name <- getLine     -- прочита ред от козолата и свързва прочетения ред с name
  putStrLn ("Hey " ++ name ++ ", you rock!")  

-- всяка стъпка е I/0 action, които сме обединили в един
```

`getLine` е функция от тип
```haskell
getLine :: String -> IO String
-- приема низ и връща I/O action, който съдържа резултат от тип String
```

За да вземем съдържанието на `I/O action`, използваме `<-`. Понеже `getLine` е от тип `IO String`, `name` съдържа стойност от тип `String`.

```haskell
main = do
    line <- getLine
    if null line            -- if condition  
        then return ()      -- then I/O action
        else do             -- else I/O action
            putStrLn $ line
            main            -- рекурсивно извикване на main

-- програмата безкрайно чете ред от конзолата и го изписва обратно
-- приключва когато прочете празен ред
```

Използваме `return`, за да създадем `I/O action` от обикновена (чиста) стойност. `return` не слага край на изпълнението на програмата, просто опакова дадена стойност в `I/O action`, обратното на `<-`.

Още няколко функции:
- `putStr`, `putStrLn`, `putChar`, `print`

  `print` приема стойност от всякакъв тип, стига да е инстанция на класа от типове `Show`, изпълнява `show` над стойността, за да я превърне в низ, и връща `I/O action`, който принтира получения низ в конзолата.

  ```haskell
  main = do   print True  
              print 2  
              print "haha"  
              print 3.2  
              print [3,4,3]  
  ```

- `getChar`, `getLine`

## [Модули](http://learnyouahaskell.com/modules#loading-modules)

Haskell програмите представляват съвкупност от модули, в които главният зарежда останалите.

Модулите експортват функции, като не е нужно да експортват всичи дефинирани функции. Част от тях можем да запазим `private`, т.е. ако някой зареди модула ни, той може да използва само функциите, които изрично сме предоставили.

```haskell
module Geometry (     -- задаваме име на модула и на файла
  rectangleArea,  
  rectangleVolume
) where  

-- дефинираме функциите rectangleArea, rectangleVolume
-- и може би други
```

```haskell
import Geometry
```

Стандартната Haskell библиотека е разделена на модули. Всички функции, които сме използвали досега, бяха част от модула `Prelude`. Има още `Data.List`, `Data.Char`, `Data.Map`, `Data.Set` и [други]((https://downloads.haskell.org/~ghc/latest/docs/html/libraries/)).

```haskell
import Data.List  
-- import Data.List (sort)        -- зарежда само функцията sort
-- import Data.List hiding (sort) -- зарежда всички функции, освен сорт  
-- import qualified Data.Map      -- зарежда всички предоставени функции в Data.Map,
                                  -- но за да ги извикаме, трябва да изпозлваме цялото им име (примерно Data.Map.filter)
-- import qualified Data.Map as M
```

## Задачи

```haskell
exampleTree :: BinaryTree Int
exampleTree =
  Node 1
    (Node 2
      (Node 3
        EmptyTree
        EmptyTree)
      EmptyTree)
    (Node 4
      EmptyTree
      EmptyTree)
```

1. [Задачи за дървета на Scheme](https://github.com/ekaranasuf/fp1819/tree/master/week7)

2. (Анди) Дефинирайте функция `maxSumPath`, която приема за аргумент двоично дърво с числа във възлите и намира максималната сума на числата по някой път от корен до листо

3. (Анди) Дефинирайте функция `prune`, която премахва листата на дадено дърво

4. (Анди) Дефинирайте функция `bloom`, която приема елемент и двоично дърво и на всяко негово листо добавя по два наследника - нови листа, с корен подадения елемент.

5. Прочетете от конзолата елемента, който бива подаден на функцията `bloom` в задача 4.

6. (Анди) Дефинирайте тип `Map` (асоциативен списък), реализиран с двоично наредено дърво. Дeфинирайте още:
  - `insert :: Ord k => k -> v -> Map k v -> Map k v` - вмъкване на ключ със стойност в дървото. Ако стойност за този ключ съществува, нека тя да бъде заместена с новата
  - `search :: Ord k => k -> Map k v -> Maybe v` - търсене на стойност по ключ в дървото

7. Прочетете от конзолата списък от наредени двойки от ключове и стойности. Изведете в конзолата двоичното дърво, получено при последователното им вмъкване в `Map`.
