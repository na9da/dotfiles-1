(setq erc-prompt ">"
      erc-fill-column 75
      erc-header-line-format nil
      erc-track-exclude-types '("324" "329" "332" "333" "353" "477" "MODE"
                                "JOIN" "PART" "QUIT" "NICK")
      erc-lurker-threshold-time 3600
      erc-track-priority-faces-only t
      erc-join-buffer 'bury
      erc-autojoin-timing :ident
      erc-flood-protect nil
      erc-autojoin-channels-alist
      '(("freenode.net" "#emacs" "#clojure" "#leiningen" "#seajure"))
      erc-prompt-for-nickserv-password nil)

(setq-default erc-ignore-list '("Lajla" "pjb" "e1f"))

(delete 'erc-fool-face 'erc-track-faces-priority-list)
(delete '(erc-nick-default-face erc-fool-face) 'erc-track-faces-priority-list)

(eval-after-load 'erc
  '(progn
     (when (not (package-installed-p 'erc-hl-nicks))
       (package-install 'erc-hl-nicks))
     (require 'erc-spelling)
     (require 'erc-services)
     (require 'erc-truncate)
     (require 'erc-hl-nicks)
     (ignore-errors
       ;; DO NOT use the version from marmalade
       (erc-nick-notify-mode t))
     (erc-services-mode 1)
     (setq erc-complete-functions '(erc-pcomplete erc-button-next))
     (add-to-list 'erc-modules 'hl-nicks)
     (add-to-list 'erc-modules 'spelling)
     (set-face-foreground 'erc-input-face "dim gray")
     (set-face-foreground 'erc-my-nick-face "blue")))

;; for jlf's local lurker patch
(add-hook 'erc-connect-pre-hook
          (lambda () (load-file "/home/phil/src/emacs/lisp/erc/erc.el")))

(defun znc ()
  (interactive)
  (load-file "~/.chorts/chorts.el.gpg")
  (erc-tls :server "route.heroku.com" :port 10688
           :nick "technomancy" :password znc-password))

(defun grove ()
  (interactive)
  (load-file "~/.chorts/chorts.el.gpg")
  (require 'erc)
  (add-to-list 'erc-networks-alist '(grove "irc.grove.io"))
  (add-to-list 'erc-nickserv-alist
               '(grove "NickServ!NickServ@services."
                       "This nickname is registered."
                       "NickServ" "IDENTIFY" nil))
  (erc-tls :server "heroku.irc.grove.io" :port 6697
           :nick "technomancy" :password grove-connect-password))

;; set erc-track-priority-faces-only to ignore stuff in boring channels:
;; https://gist.github.com/481b20e1008106480e4d
