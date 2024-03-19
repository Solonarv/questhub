module Templates
  ( module Templates
  , module X
  , (<$>)
  , Identity(runIdentity), IsString(fromString), Text
  , hsx
  ) where

import Control.Applicative        ((<$>))
import Control.Monad.Identity     (Identity(runIdentity))
import Data.String                (IsString(fromString))
import Data.Text                  (Text)
import HSP                        as X
import HSP.Monad                  (HSPT(..))
import Happstack.Server.HSP.HTML  as X
import Happstack.Server.XMLGenT   as X
import Happstack.Server           (ServerPartT)
import Language.Haskell.HSX.QQ    (hsx)

type Fragment = XMLGenT (HSPT XML (ServerPartT IO)) XML