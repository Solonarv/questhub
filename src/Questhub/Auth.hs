module Questhub.Auth where

import Data.Text (Text)
import Happstack.Server

import Questhub.AppM
import Questhub.Db.Accounts

data Session = MkSession
  { sessionUser :: UserId
  , sessionExpiry :: Int
  }



myPolicy :: BodyPolicy
myPolicy = defaultBodyPolicy "./tmp/" 0 1000 1000

login :: AppM (Maybe Session)
login = nullDir do
  method POST
  decodeBody myPolicy
  (user, pw) <- body do
    look "user"
    look "password"
  mkSession user pw

mkSession :: Text -> Text -> AppM (Maybe Session)
mkSession user pw = fail "TODO"