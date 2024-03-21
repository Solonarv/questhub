module Questhub.Index where

import Text.Blaze.Html5 qualified as H
import Text.Blaze.Html5.Attributes qualified as A

import Templates
import CommonTemplates

index :: Html
index = pageWithTitleAndContent "Index" do
  H.p $ "Lorem ipsum dolor sit amet..."
