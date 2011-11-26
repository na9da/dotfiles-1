import XMonad
import XMonad.Config.Gnome
import XMonad.Actions.CycleWindows
import qualified Data.Map as M

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList
         [ ((mod1Mask, xK_Tab), cycleRecentWindows [xK_Alt_L] xK_Tab xK_Tab)
         ]

newKeys x  = myKeys x `M.union` keys defaultConfig x

-- TODO: fix erythrina to act as a panel
main = xmonad gnomeConfig
         { modMask = mod4Mask
         , terminal = "gnome-terminal"
         , keys = newKeys
         }
