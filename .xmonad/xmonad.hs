import XMonad
import XMonad.Config.Gnome
import XMonad.Actions.CycleWindows
import qualified Data.Map as M
import XMonad.Util.EZConfig -- emacs-style keys

newKeys x = foldr M.delete (keys defaultConfig x) (keysToRemove x)

keysToRemove :: XConfig Layout -> [(KeyMask, KeySym)]
keysToRemove x =
         [ (mod4Mask              , xK_e )
         ]

-- TODO: fix erythrina to act as a panel
main = xmonad gnomeConfig
         { modMask = mod4Mask
         , terminal = "gnome-terminal"
         , keys = newKeys
         }
