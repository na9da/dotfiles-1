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
