import XMonad
import XMonad.Config.Gnome
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Hooks.ManageDocks

-- TODO: this is a no-op
myManageHook = composeAll
    [ appName =? "erythrina"  --> doFloat ]

main = xmonad $ gnomeConfig
       { modMask = mod4Mask
       , focusFollowsMouse = False -- trackpoint jitter makes this unusable
       , manageHook = myManageHook <+> manageHook gnomeConfig
       }
       `additionalKeys` [ ((mod4Mask, xK_p), spawn "dmenu_run") ]
