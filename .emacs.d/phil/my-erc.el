(setq erc-prompt ">"
      erc-fill-column 75
      ;; rcirc's omit-mode is way better than this =\
      erc-hide-list '("JOIN" "PART" "QUIT" "NICK")
      erc-track-exclude-types (append '("324" "329" "332" "333"
                                        "353" "477" "MODE")
                                      erc-hide-list)
      erc-track-priority-faces-only t
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
     (add-to-list 'erc-modules 'hl-nicks)
     (add-to-list 'erc-modules 'spelling)
     (set-face-foreground 'erc-input-face "dim gray")
     (set-face-foreground 'erc-my-nick-face "blue")))


;; thanks to leathekd
(defvar twitter-url-pattern
  (concat "\\(https?://\\)\\(?:.*\\)?\\(twitter.com/\\)"
          "\\(?:#!\\)?\\([[:alnum:][:punct:]]+\\)")
  "Matches regular twitter urls, including those with hashbangs,
but not mobile urls.")

(defun browse-mobile-twitter (url)
  "When given a twitter url, browse to the mobile version instead"
  (string-match twitter-url-pattern url)
  (let ((protocol (match-string 1 url))
        (u (match-string 2 url))
        (path (match-string 3 url)))
    (browse-url (format "%smobile.%s%s" protocol u path) t)))

;; Need to append otherwise the urls will be picked up by
;; erc-button-url-regexp. Not sure why that is the case.
(eval-after-load 'erc-button
  '(add-to-list 'erc-button-alist
                '(twitter-url-pattern 0 t browse-mobile-twitter 0) t))

(defun znc ()
  (interactive)
  (load-file "~/.chorts/chorts.el.gpg")
  (erc-tls :server "route.heroku.com" :port 10688
           :nick "technomancy" :password znc-password))

(defun grove-erc ()
  (interactive)
  (load-file "~/.chorts/chorts.el.gpg")
  (add-to-list 'erc-networks-alist '(grove "irc.grove.io"))
  (add-to-list 'erc-nickserv-alist
               '(grove "NickServ!NickServ@services."
                       "This nickname is registered."
                       "NickServ" "IDENTIFY" nil))
  (erc-tls :server "heroku.irc.grove.io" :port 6697
           :nick "technomancy" :password grove-connect-password))
