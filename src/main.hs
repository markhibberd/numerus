{-# LANGUAGE ScopedTypeVariables #-}
import Numerus
import System.Environment
import Data.List
import Data.Maybe
import Control.Applicative

main :: IO ()
main =
  do env <- getEnvironment
     let port = fromIntegral . (read :: String -> Int) . snd <$> (find (((==) "PORT") . fst) env)
     defaultMain $ fromMaybe 3000 port
