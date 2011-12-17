import XMonad
import XMonad.Config.Gnome

-- TODO: fix erythrina to act as a panel
main = xmonad gnomeConfig
         { modMask = mod4Mask
         , terminal = "gnome-terminal"
         , focusFollowsMouse = False
         }
