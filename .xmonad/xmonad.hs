import XMonad
import XMonad.Config.Gnome
import XMonad.Util.EZConfig (additionalKeys)

main = xmonad $ gnomeConfig
       { modMask = mod4Mask
       , focusFollowsMouse = False -- trackpoint jitter makes this unusable
       }
       `additionalKeys` [ ((mod4Mask, xK_p), spawn "dmenu_run") ]
