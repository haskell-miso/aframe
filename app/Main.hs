-----------------------------------------------------------------------------
{-# LANGUAGE CPP               #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE OverloadedLabels  #-}
-----------------------------------------------------------------------------
module Main where
-----------------------------------------------------------------------------
import Miso
import Miso.Html.Property
import Miso.CSS
-----------------------------------------------------------------------------
#ifdef WASM
foreign export javascript "hs_start" main :: IO ()
#endif
-----------------------------------------------------------------------------
main :: IO ()
main = startApp Miso.pointerEvents app
-----------------------------------------------------------------------------
app :: App () ()
app = (component () noop view_)
#ifndef WASM
  { scripts = [ Src "https://aframe.io/releases/1.7.0/aframe.min.js" False ]
  }
#endif  
-----------------------------------------------------------------------------
view_ :: () -> View () () () ()
view_ () =
  ascene_ []
    [ abox_
      [ position_ "-1 0.5 -3"
      , rotation_ "0 45 0"
      , color_ #4CC3D9
      ]
      []
    , asphere_
      [ position_ "0 1.25 -5"
      , radius_ 1.25
      , color_ #EF2D5E
      ]
      []
    , acylinder_
      [ position_ "1 0.75 -3"
      , radius_ 0.5
      , height_ "1.5"
      , color_ #FFC65D
      ]
      []
    , aplane_
      [ position_ "0 0 -4"
      , rotation_ "-90 0 0"
      , width_ "4"
      , height_ "4"
      , color_ #7BC8A4
      ]
      []
    , asky_
      [ color_ #ECECEC
      ]
      []
    ]
-----------------------------------------------------------------------------
ascene_ :: [Attribute model action] -> [View context props model action] -> View context props model action
ascene_ = node HTML "a-scene"
-----------------------------------------------------------------------------
abox_ :: [Attribute model action] -> [View context props model action] -> View context props model action
abox_ = node HTML "a-box"
-----------------------------------------------------------------------------
asphere_ :: [Attribute model action] -> [View context props model action] -> View context props model action
asphere_ = node HTML "a-sphere"
-----------------------------------------------------------------------------
acylinder_ :: [Attribute model action] -> [View context props model action] -> View context props model action
acylinder_ = node HTML "a-cylinder"
-----------------------------------------------------------------------------
aplane_ :: [Attribute model action] -> [View context props model action] -> View context props model action
aplane_ = node HTML "a-plane"
-----------------------------------------------------------------------------
asky_ :: [Attribute model action] -> [View context props model action] -> View context props model action
asky_ = node HTML "a-sky"
-----------------------------------------------------------------------------
position_ :: MisoString -> Attribute model action
position_ = textProp "position"
-----------------------------------------------------------------------------
color_ :: Color -> Attribute model action
color_ = textProp "color" . renderColor
-----------------------------------------------------------------------------
rotation_ :: MisoString -> Attribute model action
rotation_ = textProp "rotation"
-----------------------------------------------------------------------------
radius_ :: Double -> Attribute model action
radius_ = doubleProp "radius"
-----------------------------------------------------------------------------
