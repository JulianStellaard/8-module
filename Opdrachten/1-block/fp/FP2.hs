import Data.Char
import Data.List

-- exercise 1
myfilter :: (t -> Bool) -> [t] -> [t]
myfilter cond [] = []
myfilter cond (x:xs) | cond x = [x] ++ myfilter cond xs
                     | otherwise = myfilter cond xs

myfoldl :: (t1 -> t -> t1) -> t1 -> [t] -> t1
myfoldl f z [] = z
myfoldl f z (x:xs) = myfoldl f (f z x) xs

myfoldr :: (t1 -> t -> t) -> t -> [t1] -> t
myfoldr f z [] = z
myfoldr f z (x:xs) = f x (myfoldr f z xs) 

myzipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myzipWith _ _ [] = []
myzipWith _ [] _ = []
myzipWith f (x:xs) (y:ys) = (f x y) : myzipWith f xs ys

-- exercise 2
database :: [([Char], Int, [Char], [Char])]
database = [("Henk", 54, "Male", "Enschede"),
            ("Jaap", 38, "Male", "Hengelo"),
            ("Bertha", 44, "Female", "Almelo"),
            ("Geraldine", 37, "Female", "Scheveningen")]

name :: (t3, t2, t1, t) -> t3
-- the same for age,gender,residence
name (name, age, gender, residence) = name
age (name, age, gender, residence) = age
gender (name, age, gender, residence) = gender
residence (name, age, gender, residence) = residence

-- 2b
getName :: [Char] -> [([Char], Int, [Char], [Char])] -> [([Char], Int, [Char], [Char])]
getName x [] = []
getName x db | name (head db) == x = head db : getName x (tail db)
             | otherwise = getName x (tail db)

getAge :: Int -> [([Char], Int, [Char], [Char])] -> [([Char], Int, [Char], [Char])]
getAge x [] = []
getAge x db | age (head db) == x = head db : getAge x (tail db)
            | otherwise = getAge x (tail db)


getGender :: [Char] -> [([Char], Int, [Char], [Char])] -> [([Char], Int, [Char], [Char])]
getGender x [] = []
getGender x db | gender (head db) == x = head db : getGender x (tail db)
               | otherwise = getGender x (tail db)

getResidence :: [Char] -> [([Char], Int, [Char], [Char])] -> [([Char], Int, [Char], [Char])]
getResidence x [] = []
getResidence x db | residence (head db) == x = head db : getResidence x (tail db)
                  | otherwise = getResidence x (tail db)

-- increase age (2c)
getOlderR :: (Num a) => a -> [(String, a, String, String)] -> [(String, a, String, String)]
getOlderR n [] = []
getOlderR n ((name, a, g, r):xs) = (name, a+n, g, r) : getOlderR n xs

getOlderL :: Int -> [(String, Int, String, String)] -> [(String, Int, String, String)]
getOlderL n db = [(name, a+n, g, r) | (name, a, g, r) <- db]

increaseAge :: Int -> (String, Int, String, String) -> (String, Int, String, String)
increaseAge n (name, a, g, r) = (name, a+n, g, r)
getOlderHO :: Int -> [(String, Int, String, String)] -> [(String, Int, String, String)]
getOlderHO n db = map (increaseAge n) db

-- get all the middle aged women in the database
-- recursively
recursiveMiddleAgedWomen :: [(String, Int, String, String)] -> [String]
recursiveMiddleAgedWomen [] = []
recursiveMiddleAgedWomen (d:db) | age d > 30 && age d < 40 && gender d == "Female" = name d : recursiveMiddleAgedWomen db
                          | otherwise = recursiveMiddleAgedWomen db

-- with list comprehension
listMiddleAgedWomen :: [String]
listMiddleAgedWomen = [name (n, age, gender, residence) | (n, age, gender, residence) <- database, gender=="Female", age>30, age<40]

-- with higher order functions
higherMiddleagedWomen' :: (String, Int, String, String) -> Bool
higherMiddleagedWomen' (_, age, gender,_) = (age>30) && (age<40) && gender=="Female"
higherMiddleagedWomen :: [(String, Int, String, String)] -> [String]
higherMiddleagedWomen db = map name(filter higherMiddleagedWomen' db)


-- 2e
--getAgeFromName :: Num t2 => [Char] -> [([Char], t2, t1, t)] -> t2
getAgeFromName :: String -> [(String, Int, String, String)] -> Int
getAgeFromName x [] = error "User doesn't exist"
getAgeFromName x db | [toLower new | new<-(name (head db))] == [toLower new | new<-x] = age (head db)
                    | otherwise = getAgeFromName x (tail db)

-- 2f
sortByAge :: Ord age => [(String, age, String, String)] -> [(String, age, String, String)]
sortByAge [] = []
sortByAge (x:xs) =
    let smallerSorted = sortByAge [a | a <-xs, age a <= age x]
        biggerSorted = sortByAge [a | a <- xs, age a > age x]
    in smallerSorted ++ [x] ++ biggerSorted

-- exercise 3
sieve :: [Int] -> [Int]
sieve [] = []
sieve (p:xs) = p : sieve [x|x<-xs, x `mod` p /= 0]

isPrime :: Int -> Bool
isPrime p = elem p (sieve ([2..p]))

getFirstPrimes :: Int -> [Int]
getFirstPrimes 0 = []
getFirstPrimes n = take n (sieve [2..])

smallerPrimeNumbers :: Int -> [Int]
smallerPrimeNumbers 0 = []
smallerPrimeNumbers n = sieve ([2..(n-1)])


dividers :: Int -> [Int]
dividers 0 = [1..]
dividers m = divide m
  where 
    divide 0 = []
    divide n
      | m `mod` n == 0 = n : divide (n-1)
      | otherwise = divide (n-1)

isPrimeAlt :: Int -> Bool
isPrimeAlt m = length (dividers m) == 2

-- exercise 4
-- pyth checks what a^2+b^2=c^2 combinations exist for a, b and c
pyth :: Double -> [(Double, Double, Double)]
pyth 0 = []
pyth n = [(a,b,c) | c <- [1..], b <- [1..c], a <- [1..b], a^2+b^2==c^2]

-- pyth' ensures a is larger than (or equal to) b, so you don't get (3,4,5) and (4,3,5)
pyth' :: Double -> [(Double, Double, Double)]
pyth' n = pythhelper [(a,b,c) | a <- [1..n], b <- [1..n], c <- [1..n], a^2+b^2 == c^2, a <= b]

pythhelper :: [(Double, Double, Double)] -> [(Double, Double, Double)]
pythhelper [] = []
pythhelper xs  
-- last xs niet toevoegen als er een kleinere variant nog in de lijst zit
    | double (last xs) xs = pythhelper (init xs)
-- last xs wel toevoegen als er geen kleinere variant meer in de lijst zit
    | otherwise = pythhelper (init xs) ++ [last xs]

get1 :: (Double, Double, Double) -> Double
get2 :: (Double, Double, Double) -> Double
get3 :: (Double, Double, Double) -> Double
get1 (x,_,_) = x
get2 (_,x,_) = x
get3 (_,_,x) = x

double :: (Double, Double, Double) -> [(Double, Double, Double)] -> Bool
-- double vergelijkt een element x met een lijst xs om te kijken of er een element in xs zit
-- waar x een veelvoud van is (bijvoorbeeld (6,8,10) als je ook (3,4,5) hebt)
double x [] = False
double x xs
  -- als het hetzelfde element is moet je het negeren (x zit ook in xs)
  | x == (head xs) = double x (tail xs)
  -- als alle elementen van x meervouden zijn van de andere tuple waarmee je het vergelijkt dan zit er dus een 'dubbele' in
  -- het doet dit door te kijken of de verhoudingen gelijk zijn bij allebei de tuples (bij tuples (a,b,c) en (d,e,f) als f/c == e/b == d/a, dan zijn ze 'gelijk'
  | (get1 x / get1 (head xs) == get2 x / get2 (head xs) && get1 x / get1 (head xs) == get3 x / get3 (head xs)) = True
  -- als het geen veelvouden zijn, ga dan verder met het volgende elemenet uit de lijst om te vergelijken
  | otherwise = double x (tail xs)

-- exercise 5
increasing :: [Int] -> Bool
increasing [] = True
increasing [x] = True
increasing (x:xs) | x < (head xs) = increasing xs
                  | otherwise = False

-- ord en fractional want je vergelijkt de waardes (ord) en ze zijn decimaal
average :: (Ord p, Fractional p) => p -> p -> [p] -> Bool
average a n [] = True
average a n (x:xs) | x > a = average (((a*n)+x)/(n+1)) (n+1) xs
                   | otherwise = False

weakIncr :: (Ord p, Fractional p) => [p] -> Bool
weakIncr [] = True
weakIncr (x:xs) = average x 1 xs

-- 6a
sublist' :: [Int] -> [Int] -> Bool
sublist' [] [] = True
sublist' _ [] = False
sublist' [] (x:xs) = True
sublist' (x:xs) (y:ys)  | x == y = sublist' xs ys
                        | otherwise = False

sublist :: [Int] -> [Int] -> Bool
sublist [] _ = False
sublist _ [] = False
sublist (x:xs) (y:ys) = sublist' (x:xs) (y:ys) || sublist (x:xs) ys

--6b
lbid :: [Int] -> [Int] -> Bool
lbid xs [] = False
lbid [] ys = True
lbid (x:xs) (y:ys)  | x == y = lbid xs ys
                    | otherwise = lbid (x:xs) ys


-- exercise 7 (sorting)
bubble :: Ord a => [a] -> [a]
-- ^ is for all sorting
bubble [] = []
bubble [x] = [x]
bubble (x:y:xs)
  | x>y = [y] ++ bubble (x:xs) 
  | otherwise   = [x] ++ bubble (y:xs)


bsort :: Ord a => [a] -> [a]  
bsort [] = [] 
bsort [x] = [x] 
bsort xs = bsort (init onego) ++ [last onego]
         where
            onego = bubble xs

-- 7b
mmsort [] = []
mmsort [x] = [x]
mmsort xs = [minimum xs] ++ mmsort (xs \\ ([minimum xs] ++ [maximum xs])) ++ [maximum xs]

-- 7c
ins [] y = [y]
ins xs y = [x | x<-xs, x<=y] ++ [y] ++ [x | x<-xs, x>y]

isort :: Ord a => [a] -> [a]
isort [] = []
isort [x] = [x]
isort xs = foldl ins [] xs

-- 7d
merge :: Ord a => [a] -> [a] -> [a]
merge [] [] = []
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys) 
  | x<=y  = [x] ++ merge xs (y:ys)
  | otherwise = [y] ++ merge (x:xs) ys
  
fsthalf :: [a] -> [a]
fsthalf xs = take (length xs `div` 2) xs

sndhalf :: [a] -> [a]
sndhalf xs = drop (length xs `div` 2) xs

msort :: Ord a => [a] -> [a]
msort [] = []  
msort [x] = [x]
msort xs = merge (msort (fsthalf xs)) (msort (sndhalf xs))

-- 7e
qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort [x] = [x]
qsort (x:xs) = qsort [a | a<-xs, a<=x] ++ [x] ++ qsort [a| a<-xs, a>x]
