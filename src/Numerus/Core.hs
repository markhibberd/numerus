{-# LANGUAGE OverloadedStrings #-}
module Numerus.Core where

import Web.Scotty

import Data.Monoid (mconcat)

defaultMain :: Int -> IO ()
defaultMain port = scotty port $ do
  get "/:word" $ do
    beam <- param "word"
    html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]
