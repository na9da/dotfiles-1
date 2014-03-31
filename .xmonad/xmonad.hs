import XMonad
import XMonad.Config.Gnome
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig (additionalKeys, removeKeysP)

main = xmonad $ gnomeConfig
       {
       -- seriously? you want to steal meta?
       modMask = mod4Mask
       -- red border is useless on full-screened windows
       , layoutHook = smartBorders (layoutHook defaultConfig)
       -- trackpoint jitter makes this unusable
       , focusFollowsMouse = False
       -- launching this from xsession doesn't set env correctly
       , startupHook = spawn "killall xbindkeys; xbindkeys"
       , terminal = "urxvt"
       }
       -- gnome's launcher is crappy compared to dmenu
       `additionalKeys` [ ((mod4Mask, xK_r), spawn "dmenu_run") ]
       -- let this fall through to xbindkeys
       `removeKeysP` ["M-m", "M-Tab"]
