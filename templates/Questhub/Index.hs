module Questhub.Index where

import Templates

import CommonTemplates

index :: Fragment
index = pageWithTitleAndContent "Index" [hsx|
  <p>Lorem ipsum dolor sit amet...</p>
]