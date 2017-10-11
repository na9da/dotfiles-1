;;; Music functions

(map (lambda (binding) (xbindkey (car binding) (cdr binding)))
     (list '((Shift F5) . "~/bin/music-show")
           '((Shift F7) . "~/bin/music-random")
           '(F7 . "~/bin/music-choose")
           '(F8 . "mpc toggle")
           '(F9 . "mpc prev")
           '(F10 . "mpc next")))

(xbindkey 'XF86AudioRaiseVolume "amixer sset Master 5%+")
(xbindkey 'XF86AudioLowerVolume "amixer sset Master 5%-")

;;; layouts

(xbindkey 'F12 "setxkbmap -layout dvorak; ctrl-fix")
(xbindkey '(mod1 F12) "setxkbmap -layout disabled")
(xbindkey '(mod4 F12) "setxkbmap -layout us; ctrl-fix")

;;; utilities

(xbindkey '(mod4 s) "scrot")
(xbindkey '(mod4 shift s) "scrot -s")
(xbindkey '(mod4 shift d) "dmenu_run")
(xbindkey '(mod4 p) "thunar ~/docs/images/p")
(xbindkey '(mod4 v) "killall evrouter; evrouter /dev/input/event*")
(xbindkey '(mod4 z) "killall zoom; sleep 1; killall zoom")

;; urxvt -fn xft:terminus-10:encoding=combined -letsp 0

(xbindkey '(mod4 l) "gnome-screensaver-command -l")

;;; applications

(xbindkey '(mod4 e) "emacs")
(xbindkey '(mod4 f) "firefox")
(xbindkey '(mod4 Return) "urxvt")
(xbindkey '(mod4 c) "chromium")
