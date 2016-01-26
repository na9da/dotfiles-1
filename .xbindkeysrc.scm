;;; Music functions

(map (lambda (binding) (xbindkey (car binding) (cdr binding)))
     (list '((Shift F5) . "~/bin/music-show")
           '((Control F5) . "~/bin/music-playlist")
           '(F6 . "~/bin/music-random")
           '(F7 . "~/bin/music-choose")
           '(F8 . "mpc toggle")
           '((shift F8) . "ogg123 ~/docs/ambientShipTNG.ogg")
           '((mod1 F8) . "killall ogg123")
           '(F9 . "mpc prev")
           '(F10 . "mpc next")))

;; TODO: broken
(xbindkey '(shift F9) "xdotool key XF86AudioLowerVolume")
(xbindkey '(shift F10) "xdotool key XF86AudioRaiseVolume")

;;; notifications

(xbindkey '(mod1 F12) "notify-battery")
(xbindkey '(shift F12) "internal-keyboard disable")
(xbindkey '(mod1 shift F12) "killall dunst; dunst -nb \"#000000\"")

;;; network

(xbindkey '(mod4 mod1 n) "ery-net")

;;; utilities

(xbindkey '(mod4 F11) "setxkbmap -layout us; ctrl-fix")
(xbindkey '(mod4 shift F11) "setxkbmap -layout dvorak; ctrl-fix")
(xbindkey '(mod4 mod1 F11) "setxkbmap -layout \"th(pat)\"; ctrl-fix")
(xbindkey 'F11 "setxkbmap -layout dvorak; ctrl-fix")
(xbindkey 'Menu "setxkbmap -layout \"th(pat)\"; ctrl-fix")
(xbindkey '(mod4 s) "scrot")
(xbindkey '(mod4 shift s) "scrot -s")
(xbindkey '(mod4 shift d) "dmenu_run")
(xbindkey '(mod4 p) "nautilus ~/docs/images/p")
(xbindkey '(mod4 v) "killall evrouter; evrouter /dev/input/*")
;; urxvt -fn xft:terminus-10:encoding=combined -letsp 0

(xbindkey '(mod1 shift F12) "internal-kbd disable")
(xbindkey '(mod4 shift F12) "internal-kbd enable")

;;; applications

(xbindkey '(mod4 c) "chromium")
(xbindkey '(mod4 m) "emacs")
(xbindkey '(mod4 shift n) "nautilus --no-desktop")
