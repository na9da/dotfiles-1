;;; Music functions

(map (lambda (binding) (xbindkey (car binding) (cdr binding)))
     (list '(F5 . "~/bin/music-show")
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

(xbindkey '(F12) "notify-send \"$(date)\"")
(xbindkey '(mod1 F12) "notify-battery")
(xbindkey '(shift F12) "notify-send \"$(uptime | cut -f 5 -d :)\"")

;;; network

(xbindkey '(mod4 mod1 n) "ery-net")
(xbindkey '(mod4 shift N)
          "notify-send wifi \"$(nmcli -f SSID dev wifi | grep -v SSID | uniq)\"")
(xbindkey '(mod4 Control n)
          "notify-send wifi $(nmcli -f STATE nm | tail -n 1)")

;;; utilities

(xbindkey '(mod4 d) "gnome-display-properties")
(xbindkey '(mod4 F11) "setxkbmap -layout us; ctrl-fix")
(xbindkey '(mod4 shift F11) "setxkbmap -layout dvorak; ctrl-fix")
(xbindkey '(mod4 s) "scrot")
(xbindkey '(mod4 shift s) "scrot -s")
(xbindkey '(mod4 f) "toggle-fbpanel")

(xbindkey '(mod4 m) "emacs")
