import FPPrac.Trees

-- 1 a
data Tree1a = Leaf1a Int
            | Node1a Int Tree1a Tree1a

pp1a :: Tree1a -> RoseTree
pp1a (Leaf1a n) = RoseNode (show n) []
pp1a (Node1a n l r) = RoseNode (show n) ([(pp1a l)] ++ [(pp1a r)])

exampleTree1a = Node1a 1 (Node1a 2 (Node1a 4 (Leaf1a 8) (Leaf1a 9)) (Node1a 5 (Leaf1a 10) (Leaf1a 11))) (Node1a 3 (Node1a 6 (Leaf1a 12) (Leaf1a 13)) (Node1a 7 (Leaf1a 14) (Leaf1a 15)))

-- 1 b
data Tree1b = Leaf1b (Int, Int)
            | Node1b (Int, Int) Tree1b Tree1b

pp1b :: Tree1b -> RoseTree
pp1b (Leaf1b n) = RoseNode (show n) []
pp1b (Node1b n l r) = RoseNode (show n) ([(pp1b l)] ++ [(pp1b r)])

exampleTree1b = Node1b (1,2) (Node1b (3,4) (Leaf1b (7,8)) (Leaf1b (9,10))) (Node1b (5,6) (Leaf1b (11,12)) (Leaf1b (13,14)))

-- 1 c
data Tree1c = Leaf1c Int
            | Node1c Tree1c Tree1c

pp1c :: Tree1c -> RoseTree
pp1c (Leaf1c n) = RoseNode (show n) []
pp1c (Node1c l r) = RoseNode [] ([(pp1c l)] ++ [(pp1c r)])

exampleTree1c = Node1c (Node1c (Leaf1c 1) (Leaf1c 2)) (Node1c (Leaf1c 3) (Leaf1c 4))

-- 1 d
data Tree1d = Leaf1d (Int, Int)
            | Node1d [Tree1d]

pp1d :: Tree1d -> RoseTree
pp1d (Leaf1d n) = RoseNode (show n) []
pp1d (Node1d t) = RoseNode [] (map pp1d t)

exampleTree1d = Node1d [Node1d [Leaf1d (1,2)], Node1d [Leaf1d (3,4), Leaf1d (5,6)], Node1d [Leaf1d (7,8), Leaf1d (9,10), Leaf1d(11,12)]]

-- 2 a
treeAdd :: Int -> Tree1a -> Tree1a
treeAdd x (Leaf1a n) = Leaf1a (n+x)
treeAdd x (Node1a n l r) = Node1a (n+x) (treeAdd x l) (treeAdd x r)

-- 2 b
treeSquare :: Tree1a -> Tree1a
treeSquare (Leaf1a n) = Leaf1a (n^2)
treeSquare (Node1a n l r) = Node1a (n^2) (treeSquare l) (treeSquare r)

-- 2 c
mapTree :: (Int -> Int) -> Tree1a -> Tree1a
mapTree f (Leaf1a n) = Leaf1a (f n)
mapTree f (Node1a n l r) = Node1a (f n) (mapTree f l) (mapTree f r)

mapTreeAdd :: Int -> Tree1a -> Tree1a
mapTreeAdd x t = mapTree (+x) t

mapTreeSquare :: Tree1a -> Tree1a
mapTreeSquare t = mapTree (^2) t

-- 2 d
addNode :: Tree1b -> Tree1a
addNode (Leaf1b n) = Leaf1a (fst n + snd n)
addNode (Node1b n l r) = Node1a (fst n + snd n) (addNode l) (addNode r)

-- 2 e
mapTreeb :: ((Int, Int) -> Int) -> Tree1b -> Tree1a
mapTreeb f (Leaf1b n) = Leaf1a (f n)
mapTreeb f (Node1b n l r) = Node1a (f n) (mapTreeb f l) (mapTreeb f r)

--showRoseTreeList [(pp1b exampleTree1b), (pp1a (mapTreeb (\(a,b) -> (a+b)) exampleTree1b))]
--showRoseTreeList [(pp1b exampleTree1b), (pp1a (mapTreeb (\(a,b) -> (a*b)) exampleTree1b))]
--showRoseTreeList [(pp1b exampleTree1b), (pp1a (mapTreeb (\(a,b) -> (a*b)) exampleTree1b)), (pp1a (mapTreeb (\(a,b) -> (a+b)) exampleTree1b))]


-- 3 a
binMirror :: Tree1a -> Tree1a
binMirror (Leaf1a n) = Leaf1a n
binMirror (Node1a n l r) = Node1a n (binMirror r) (binMirror l)
--showRoseTreeList [(pp1a exampleTree1a), (pp1a (binMirror exampleTree1a)), (pp1a (binMirror (binMirror exampleTree1a)))]

binMirrord :: Tree1d -> Tree1d
binMirrord (Leaf1d t) = Leaf1d (snd t, fst t)
binMirrord (Node1d t) = Node1d 
