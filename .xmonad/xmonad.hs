import XMonad
import XMonad.Config.Gnome
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig (additionalKeys, removeKeysP)
import qualified XMonad.StackSet as W

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
       `additionalKeys` ([ ((mod4Mask, xK_r), spawn "dmenu_run")
                           ,((mod1Mask, xK_Tab), windows W.focusDown) ] ++
       -- trying to avoid use of super for workspaces
         [((m .|. controlMask, k), windows $ f i)
             | (i, k) <- zip (map show [1..9]) [xK_1 .. xK_9]
             , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]])
       -- let this fall through to xbindkeys
       `removeKeysP` ["M-m", "M-r"]