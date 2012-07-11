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
      '(("freenode.net" "#emacs" "#clojure" "#leiningen"
         "#seajure" "#seafreemob"))
      erc-prompt-for-nickserv-password nil)

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
     (erc-truncate-mode 1)
     (setq erc-complete-functions '(erc-pcomplete erc-button-next))
     (setq-default erc-ignore-list '("Lajla" "pjb" "e1f"))
     (add-to-list 'erc-modules 'hl-nicks)
     (add-to-list 'erc-modules 'spelling)
     (set-face-foreground 'erc-input-face "dim gray")
     (set-face-foreground 'erc-my-nick-face "blue")))

;; for jlf's local lurker patch
(add-hook 'erc-connect-pre-hook
          (lambda (&rest _)
            (when (file-readable-p "/home/phil/src/emacs/lisp/erc/erc.el")
              (load-file "/home/phil/src/emacs/lisp/erc/erc.el")
              (erc-pcomplete-enable))))

(defun znc ()
  (interactive)
  (when (not (boundp 'znc-password))
    (load-file "~/.chorts/chorts.el.gpg"))
  (erc-tls :server "route.heroku.com" :port 10688
           :nick "technomancy" :password znc-password))

(defun camper ()
  (interactive)
  (when (not (boundp 'camper-password))
    (load-file "~/.chorts/chorts.el.gpg"))
  (erc-tls :server "route.heroku.com" :port 48484
           :nick "technomancy" :password camper-password))
