;;; Music functions

(map (lambda (binding) (xbindkey (car binding) (cdr binding)))
     (list '((Shift F5) . "~/bin/music-show")
           '(F6 . "~/bin/music-random")
           '(F7 . "~/bin/music-choose")
           '(F8 . "mpc toggle")
           '(F9 . "mpc prev")
           '(F10 . "mpc next")))

;;; notifications

(xbindkey '(mod1 F12) "notify-battery")

;;; network

(xbindkey '(mod4 mod1 n) "ery-net")

;;; layouts

(xbindkey '(mod4 F11) "setxkbmap -layout us; ctrl-fix")
(xbindkey '(mod4 shift F11) "setxkbmap -layout dvorak; ctrl-fix")
(xbindkey '(mod4 mod1 F11) "setxkbmap -layout \"th(pat)\"; ctrl-fix")

;;; utilities

(xbindkey '(mod4 s) "scrot")
(xbindkey '(mod4 shift s) "scrot -s")
(xbindkey '(mod4 shift d) "dmenu_run")
(xbindkey '(mod4 v) "killall evrouter; evrouter /dev/input/*")
;; urxvt -fn xft:terminus-10:encoding=combined -letsp 0

(xbindkey '(mod4 l) "gnome-screensaver-command -l")

(xbindkey '(mod1 shift F12) "internal-kbd disable")
(xbindkey '(mod4 shift F12) "internal-kbd enable")

;;; applications

(xbindkey '(mod4 e) "emacs")
