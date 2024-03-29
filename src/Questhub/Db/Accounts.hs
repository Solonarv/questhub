{-# LANGUAGE TemplateHaskell #-}
module Questhub.Db.Accounts where

import Data.Text (Text)
import Data.ByteString (ByteString)

import Data.Acid
import Data.SafeCopy (base, deriveSafeCopy)
import Data.IxSet (IxSet, ((@=)), ((@+)), ((@*)))
import Data.IxSet qualified as IxSet

newtype UserId = UserId { unUserId :: Int64 }
  deriving newtype (Eq, Ord, Show)
newtype Username = Username { unUsername :: Text }
  deriving newtype (Eq, Ord, Show)
newtype PasswordHash = PasswordHash { unPasswordHash :: ByteString }
  deriving newtype (Eq, Ord, Show)

data Account = Account
  { accountUserId :: UserId
  , accountUsername :: Username
  , accountPasswordHash :: PasswordHash
  }
  deriving (Eq, Ord, Show)

instance Indexable Account where
  empty = ixSet
    [ ixFun \a -> [accountUserId a]
    , ixFun \a -> [accountUsername a]
    ]

data Accounts = Accounts { accountsNextId :: Int64, accountsSet :: IxSet Account }

$(mapM_ (deriveSafeCopy 0 'base) [''UserId, ''Username, ''PasswordHash, ''Account, ''Accounts])

newAccount :: Username -> PasswordHash -> Update Accounts (Maybe UserId)
newAccount user pw = do
  accts <- gets accountsSet
  case IxSet.getOne $ accts @= user of
    Just _ -> pure Nothing
    Nothing -> do
      thisId <- gets accountsNextId
      let accts' = IxSet.insert (Account thisId user pw) accts
          nextId = thisId + 1
      put (Accounts nextId accts')
      pure (Just thisId)

updateUser :: Account -> Update Accounts ()
udpateUser new = do
  accts <- gets accountsSet
  let accts' = IxSet.updateIx (accountUserId new) new (accountsSet accts)
  modify \db -> db{ accountsSet = accts' }

changeUsername :: UserId -> Username -> Update Accounts (Maybe UserId)
changeUsername target newName = do
  existing <- gets \db -> IxSet.toList $ accountsSet db @= newName
  case existing of
    [] -> Nothing <$ updateUser target \acct -> acct { accountUsername = newName }
    [other] -> pure $ Just (accountUserId other)
    _ -> error $ "Accounts DB in inconsistent state: multiple users with name " <> show newName

findAccountByName :: Username -> Query Accounts (Maybe Account)
findAccountByName name = reader \db -> case IxSet.toList $ accountsSet db @= name of
    [] -> Nothing
    [found] -> Just found
    dupes -> error (
        "Accounts DB in inconsistent state: multiple users with name "
      <> show name <> ", ids: " <> map (show . accountUserId) dupes)

findAccountById :: UserId -> Query Accounts (Maybe Account)
findAccountById target = reader \db -> IxSet.getOne $ accountsSet db @= target

$(makeAcidic ''Accounts ['newAccount, 'updateUser, 'findAccountByName, 'findAccountById])