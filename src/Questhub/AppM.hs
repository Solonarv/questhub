module Questhub.AppM where

import Control.Applicative
import Control.Monad.IO.Class
import Control.Monad.Reader

import Data.Acid
import Happstack.Server (ServerPartT)

newtype AppM d a = AppM { runAppM :: ServerPartT (ReaderT (AcidState d) IO) a }
  deriving newtype (Functor, Applicative, Monad, Alternative, MonadPlus, MonadIO)
  
query_ :: QueryEvent e => e -> AppM (EventState e) (EventResult e)
query_ q = AppM do acid <- ask; liftIO $ query acid q

update_ :: UpdateEvent e => e -> AppM (EventState e) (EventResult e)
update_ q = AppM do acid <- ask; liftIO $ update acid q