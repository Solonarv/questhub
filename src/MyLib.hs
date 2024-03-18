module MyLib (main) where

import Happstack.Server (nullConf, simpleHTTP, toResponse, ok, ServerPartT)

main :: IO ()
main = simpleHTTP nullConf handlers

handlers :: ServerPartT IO String
handlers = ok "Hello, World!"