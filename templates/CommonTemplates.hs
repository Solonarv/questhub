module CommonTemplates where

import Text.Blaze.Html5 qualified as H
import Text.Blaze.Html5.Attributes qualified as A

import Templates

pageWithTitleAndContent :: Text -> Html -> Html
pageWithTitleAndContent title content =
  H.docTypeHtml do
    H.head do
      H.title (toHtml (title <> " | Questhub"))
      commonHead
    H.body do
      H.h1 (toHtml title)
      content

commonHead :: Html
commonHead = H.meta ! A.charset "utf-8"