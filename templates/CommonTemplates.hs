{-# OPTIONS_GHC -F -pgmFhsx2hs #-}
module CommonTemplates where

import Templates

pageWithTitleAndContent :: Text -> Fragment -> Fragment
pageWithTitleAndContent title content =
  <html>
    <head>
      <% commonHead %>
      <title><% title %> | QuestHub</title>
    </head><body>
      <h1><% title %></h1>
      <% content %>
    </body>
  </html>

commonHead :: Fragment
commonHead = <meta charset="utf-8" />