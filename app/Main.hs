module Main where

import Lib
import System.Random
import Test.QuickCheck
import Test.QuickCheck.Random
import Test.QuickCheck.Gen

main :: IO ()
main = do
  seed <- newQCGen
  putStrLn "Enter the template : "
  template <- getLine
  putStrLn "How many do you need : "
  num <- getLine
  mapM_ putStrLn $ take (read $ num :: Int) $ multiYerdoStream seed template

randomAlphaNum :: Gen Char
randomAlphaNum = elements (['A'..'Z'] ++ ['0'..'9'])

randomNum :: Gen Char
randomNum = elements (['0'..'9'])

randomAlpha :: Gen Char
randomAlpha = elements (['A'..'Z'])

yerdoGen :: QCGen -> [Char] -> ([Char], QCGen)
yerdoGen qcg [] = ([], qcg)
yerdoGen qcg (x:xs) = let (_, nextqcg) = next qcg
                          (str, finalqcg) = yerdoGen nextqcg xs
                       in case x of
                         '*' -> ((unGen randomAlphaNum qcg 9999999) : str, finalqcg)
                         '$' -> ((unGen randomNum qcg 9999999) : str, finalqcg)
                         other ->  (x : str, finalqcg)

multiYerdoStream :: QCGen -> [Char] -> [String]
multiYerdoStream qcg template = let (str, nextqcg) = yerdoGen qcg template
                                in str : multiYerdoStream nextqcg template
