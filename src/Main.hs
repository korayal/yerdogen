module Main where

import System.Random
import System.Environment (getArgs)
import Test.QuickCheck
import Test.QuickCheck.Random
import Test.QuickCheck.Gen
import Control.Monad

main :: IO ()
main = do
  seed <- newQCGen
  args <- getArgs
  let result = sequence $ take (read $ args !! 0) $ multiYerdoStream' (args !! 1)
  mapM_ putStrLn $ unGen result seed 9999999

randomAlphaNum :: Gen Char
randomAlphaNum = elements (['A'..'Z'] ++ ['0'..'9'])

randomNum :: Gen Char
randomNum = elements ['0'..'9']

randomAlpha :: Gen Char
randomAlpha = elements ['A'..'Z']

randomSame :: a -> Gen a
randomSame a = elements [a]

templateToGenSeq :: [Char] -> Gen [Char]
templateToGenSeq = sequence . go
  where go [] = []
        go (x:xs) = case x of
          '*' -> randomAlphaNum : (go xs)
          '#' -> randomNum : (go xs)
          '~' -> randomAlpha : (go xs)
          _ -> (randomSame x) : (go xs)

multiYerdoStream' :: [Char] -> [Gen [Char]]
multiYerdoStream' = repeat . templateToGenSeq
