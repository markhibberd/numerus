{-# LANGUAGE OverloadedStrings, FlexibleContexts  #-}
module Numerus.Core where

import qualified Data.ByteString.Char8 as C8
import Data.Pool
import Data.Maybe
import Data.Monoid (mconcat)

import Database.PostgreSQL.Simple
import Web.Scotty

go :: Int -> String -> IO ()
go port db =
  mkPool db >>= \pool -> migrate pool  >> (scotty port $ route pool)

route :: Pool Connection -> ScottyM ()
route _ = do
  get "/:word" $ do
    beam <- param "word"
    html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]

migrate :: Pool Connection -> IO ()
migrate pool = runDb pool $ \conn -> do
  error "todo"

list :: (ToRow a, FromRow b) => Connection -> Query -> a ->  IO [b]
list c q v = query c q v

fetch :: (ToRow a, FromRow b) => Connection -> Query -> a -> IO (Maybe b)
fetch c q v =
  fmap listToMaybe $ list c q v

fetch' :: (ToRow a, FromRow (Only b)) => Connection -> Query -> a ->  IO (Maybe b)
fetch' c q v =
  fmap (fmap fromOnly) $ fetch c q v

runDb :: Pool Connection -> (Connection -> IO a) -> IO a
runDb pool f =
  withResource pool (\conn -> withTransaction conn (f conn))

mkPool :: String -> IO (Pool Connection)
mkPool cfg =
  createPool (connectPostgreSQL . C8.pack $ cfg) close 1 20 10
