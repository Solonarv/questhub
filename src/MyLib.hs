module MyLib (main) where

import Control.Monad (msum)
import Control.Monad.IO.Class (liftIO)
import Data.Functor (void)

import Happstack.Server (nullConf, simpleHTTP, toResponse, ok, ServerPartT
  , dir, nullDir, Response)

import qualified Questhub.Index

main :: IO ()
main = do
  putStrLn "starting server..."
  simpleHTTP nullConf handlers

handlers :: ServerPartT IO Response
handlers = msum
  [ nullDir >> do
      liftIO $ putStrLn "GET /"
      pure $ toResponse Questhub.Index.index
  ]