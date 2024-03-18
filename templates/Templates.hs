module Templates (module X, Page) where

import Control.Applicative        ((<$>)) as X
import Control.Monad.Identity     (Identity(runIdentity)) as X
import Data.String                (IsString(fromString)) as X
import Data.Text                  (Text) as X
import HSPT                       as X
import HSP.Monad                  (HSPT(..)) as X
import Happstack.Server.HSP.HTML  as X
import Happstack.Server.XMLGenT   as X
import Happstack.Server           ( Request(rqMethod), ServerPartT
                                  , askRq, nullConf, simpleHTTP
                                  ) as X
import Language.Haskell.HSX.QQ    (hsx) as X

type Fragment = ServerPartT IO XML