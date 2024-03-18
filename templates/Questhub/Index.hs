{-# OPTIONS_GHC -F -pgmFhsx2hs #-}
module Questhub.Index where

import Templates

import CommonTemplates

index :: Fragment
index = pageWithTitleAndContent "Index" $
  <p>Lorem ipsum dolor sit amet...</p>
