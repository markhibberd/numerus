module Main where

import qualified Numerus.Tests
import Test.Framework

main ::
  IO ()
main = 
  defaultMain tests 

tests ::
  [Test]
tests =
  [
    testGroup "Tests"
      [
        Numerus.Tests.test
      ]
  ]

