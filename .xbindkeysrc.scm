;;; Music functions

(map (lambda (binding) (xbindkey (car binding) (cdr binding)))
     (list '(F5 . "~/bin/music-show")
           '((Control F5) . "~/bin/music-playlist")
           '(F6 . "~/bin/music-random")
           '(F7 . "~/bin/music-choose")
           '(F8 . "mpc toggle")
           '((shift F8) . "ogg123 ~/documents/ambientShipTNG.ogg")
           '((mod1 F8) . "killall ogg123")
           '(F9 . "mpc prev")
           '(F10 . "mpc next")
           '((mod4 F12) . "vlc -f ~/documents/movies/misc/rick.flv"))) ;; tee hee

;;; notifications

(xbindkey '(F12) "notify-send \"$(date)\"")
(xbindkey '(mod1 F12) "~/bin/notify-battery")
(xbindkey '(shift F12) "notify-send \"$(uptime | cut -f 5 -d :)\"")

;;; network

(xbindkey '(mod4 n) "ery-net")
(xbindkey '(mod4 shift N)
          "notify-send wifi \"$(nmcli -f SSID dev wifi | grep -v SSID | uniq)\"")

;;; main stuff

(xbindkey '(mod4 mod1 e) "emacs")

(xbindkey '(mod4 c) "conkeror")
(xbindkey '(mod4 r) "chromium-browser")

;;; utilities

(xbindkey '(mod4 x) "killall xbindkeys && xbindkeys")
(xbindkey '(mod4 d) "gnome-display-properties")
(xbindkey '(mod1 grave) "gnome-terminal")
(xbindkey '(mod4 grave) "gnome-terminal")
(xbindkey '(mod4 s) "scrot")
(xbindkey '(mod4 shift s) "scrot -s")

(xbindkey '(mod4 mod1 y) "synergys")
(xbindkey '(mod4 shift y) "killall synergys")

(xbindkey '(mod4 F11) "setxkbmap -layout us")
(xbindkey '(mod4 shift F11) "setxkbmap -layout dvorak")

;;; launchers

(xbindkey '(mod1 space) "ery-run")

(xbindkey '(mod4 b) "~/bin/dbook.rb")
(xbindkey '(mod4 m) "nautilus ~/documents/movies")

(xbindkey '(mod4 y) "~/bin/skyyy")
