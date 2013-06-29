{-# LANGUAGE OverloadedStrings #-}
module Numerus.Core where

import Web.Scotty

import Data.Monoid (mconcat)

defaultMain :: IO ()
defaultMain = scotty 3000 $ do
  get "/:word" $ do
    beam <- param "word"
    html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]
