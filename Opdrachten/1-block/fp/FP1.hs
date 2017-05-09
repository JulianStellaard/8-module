import Data.Char

-- exercise 1 
f x = 2*x^2 + 3*x - 5

-- exercise 2
code :: Char -> Int -> Char
code x n | (96<ord x && ord x<(123-y)) || (64<ord x && ord x<(91-y))  = chr ((ord x)+y)
         | ((122-y)<ord x && ord x<123) || ((90-y)<ord x && ord x<91) = chr ((ord x)-(26-y))
         | otherwise = x
         where 
             y = n `mod` 26

-- exercise 3
amount :: Fractional t => t -> t -> Int -> t
amount a r n  | n == 0 = a
              | otherwise = amount (a * (1 + (r)/100))  r (n-1)

-- exercise 4
discr :: Num a => a -> a -> a -> a
root1 :: (Ord a, Floating a) => a -> a -> a -> a
root2 :: (Ord a, Floating a) => a -> a -> a -> a
discr a b c = b^2 - 4*a*c
root1 a b c   | a == 0 = error "a can't be 0"
              | discr a b c < 0 = error "negative discriminant"
              | discr a b c == 0 = -b / 2*a
              | discr a b c > 0 = (-b + sqrt (discr a b c)) / 2*a
root2 a b c   | a == 0 = error "a can't be 0"
              | discr a b c < 0 = error "negative discriminant"
              | discr a b c == 0 = -b / 2*a
              | discr a b c > 0 = (-b - sqrt (discr a b c)) / 2*a


-- exercise 5
extrX :: Fractional a => a -> a -> t -> a
extrY :: Fractional a => a -> a -> a -> a
extrX a b c = -b / 2*a
extrY a b c = a*((extrX a b c) ^ 2) + b*(extrX a b c) + c

-- exercise 6
mylength :: [Int] -> Int
mylength xs  | xs == [] = 0
             | otherwise = 1 + mylength (tail xs)
mysum :: [Int] -> Int
mysum xs  | mylength xs == 1 = head xs
          | otherwise = head xs + mysum (tail xs)

myreverse :: [Int] -> [Int]
myreverse xs  | xs == [] = []
              | otherwise = reverse (tail xs) ++ [head xs]

mytake :: [Int] -> Int -> [Int]
mytake xs n | n == 0 = []
            | n > mylength xs = xs
            | otherwise = [head xs] ++ mytake (tail xs) (n-1)

myelem :: [Int] -> Int -> Bool
myelem xs x | mylength xs == 0 = False
            | x == head xs = True
            | otherwise = myelem (tail xs) x

myconcat :: [[Int]] -> [Int]
myconcat [] = []
myconcat (x:xs) = x ++ myconcat xs

mymaximum :: [Int] -> Int
mymaximum [] = -1
mymaximum [x] = x
mymaximum (x1:x2:xs) | x1 >= x2 = mymaximum (x1:xs)
                     | x1 < x2 = mymaximum (x2:xs)

myzip :: [Int] -> [Int] -> [(Int, Int)]
myzip xs [] = []
myzip [] xy = []
myzip (x:xs) (y:ys) = [(x,y)] ++ myzip xs ys

-- exercise 7
r :: Int -> Int -> [Int]
r a 0 = [a]
r a d = [a] ++ r (a+d) d

r1 a d n = (r a d)!!(n-1)

total a d i j
  | i == j = r 1 a d j
  | otherwise = (r1 a d i) + (total a d (i+1) j)

-- exercise 8
allEqual :: [Int] -> Bool
allEqual [] = True
allEqual [x] = True
allEqual (x1:x2:xs) | x1 == x2 = allEqual(xs)
                    | otherwise = False

isAS :: [Int] -> Int -> Bool
isAS a 0 = allEqual a
isAS [x] d = True
isAS (x1:x2:xs) d | x1 + d == x2 = isAS(x2:xs)
                  | otherwise = False
-- with allEqual
isAS2 :: [Int] -> Bool
isAS2 [] = False
isAS2 [x] = False
isAS2 [x,y] = True
isAS2 (x1:x2:x3:xs) = allEqual [(x2-x1), (x3-x2)] && isAS2 (x2:x3:xs)

-- exercise 9a
matrixEqualSize :: [[Int]] -> Bool
matrixEqualSize [] = True
matrixEqualSize [xs] = True
matrixEqualSize (xs1:xs2:xns) | mylength xs1 == mylength xs2 = matrixEqualSize(xns)
                              | otherwise = False

-- exercise 9b
totalmatrixRows :: [[Int]] -> [Int]
totalmatrixRows [] = [0]
totalmatrixRows [xs] = [mysum xs]
totalmatrixRows (xs:xns) = [mysum xs] ++ totalmatrixRows xns

-- exercise 9c
transposeMatrix :: [[Int]] -> [[Int]]
transposeMatrix [] = []
transposeMatrix xs = [map head xs] ++ transposeMatrix (map tail xs)

--exercise 9d
totalmatrixColumns :: [[Int]] -> [Int]
totalmatrixColumns [[]] = []
totalmatrixColumns = totalmatrixRows . transposeMatrix 
