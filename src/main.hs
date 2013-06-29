{-# LANGUAGE ScopedTypeVariables #-}
import Numerus
import System.Environment

main :: IO ()
main =
  do args <- getArgs
     case args of
       port : db : [] -> go (read port) db
       _ -> error "usage: numerus PORT DATABASE_URL"
