import XMonad
import XMonad.Config.Gnome
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig (additionalKeys)

main = xmonad $ gnomeConfig
       {
       -- seriously? you want to steal meta?
       modMask = mod4Mask
       -- red border is useless on full-screened windows
       , layoutHook = smartBorders (layoutHook defaultConfig)
       -- trackpoint jitter makes this unusable
       , focusFollowsMouse = False
       }
       -- gnome's launcher is crappy compared to dmenu
       `additionalKeys` [ ((mod4Mask, xK_p), spawn "dmenu_run") ]
