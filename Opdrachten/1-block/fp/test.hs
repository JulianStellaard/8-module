isSublist :: (Eq a, Num a) => [a] -> [a] -> Bool
isSublist [] _ = False
isSublist _ [] = False
isSublist  sub@(x:xs) list@(y:ys) = prec sub list || isSublist sub ys

prec :: (Eq a, Num a) => [a] -> [a] -> Bool
prec [] [] = True
prec _ [] = False
prec [] (x:xs)  = True
prec sub@(x:xs) list@(y:ys)
    | x == y = prec xs ys
    | otherwise = False
