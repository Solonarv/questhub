module MyLib (main) where

import Control.Monad (msum)
import Data.Functor (void)

import Happstack.Server (nullConf, simpleHTTP, toResponse, ok, ServerPartT
  , dir, nullDir)
import HSP.Monad                  (HSPT(..))
import HSP.XMLGenerator           (unXMLGenT)
import Happstack.Server.HSP.HTML

import qualified Questhub.Index

main :: IO ()
main = simpleHTTP nullConf handlers

handlers :: ServerPartT IO ()
handlers = msum
  [ void $ nullDir >> unHSPT (unXMLGenT Questhub.Index.index)
  , void $ dir "hello" $ ok "Hello, World!"
  ]