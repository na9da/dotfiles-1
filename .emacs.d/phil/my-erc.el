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
      erc-server-send-ping-interval 45
      erc-server-send-ping-timeout 180
      erc-server-reconnect-timeout 60
      erc-autojoin-channels-alist
      '(("freenode.net" "#emacs" "#clojure" "#leiningen" "#seajure"
         "#raxacoricofallapatorius" "#clojuredocs"))
      erc-prompt-for-nickserv-password nil)

(delete 'erc-fool-face 'erc-track-faces-priority-list)
(delete '(erc-nick-default-face erc-fool-face) 'erc-track-faces-priority-list)

(eval-after-load 'erc
  '(progn
     (when (not (package-installed-p 'erc-hl-nicks))
       (package-install 'erc-hl-nicks))
     (when (not (package-installed-p 'ercn))
       (package-install 'ercn))
     (require 'erc-spelling)
     (require 'erc-services)
     (require 'erc-truncate)
     (require 'erc-hl-nicks)
     (require 'notifications)
     (erc-services-mode 1)
     (erc-truncate-mode 1)
     (setq erc-complete-functions '(erc-pcomplete erc-button-next))
     (setq-default erc-ignore-list '("Lajla" "hal" "wingy"))
     (add-to-list 'erc-modules 'hl-nicks)
     (add-to-list 'erc-modules 'spelling)
     (set-face-foreground 'erc-input-face "dim gray")
     (set-face-foreground 'erc-my-nick-face "blue")
     (define-key erc-mode-map (kbd "C-u RET") 'browse-last-url-in-brower)
     (add-hook 'ercn-notify 'ercn-send-notification)))

(defun ercn-send-notification (nick message)
  (notifications-notify :title (concat nick " said:") :body message))

(defvar erc-hack-applied nil)

;; for jlf's local lurker patch
(add-hook 'erc-connect-pre-hook
          (lambda (&rest _)
            (when (and (file-readable-p "/home/phil/src/emacs/lisp/erc/erc.el")
                       (not erc-hack-applied))
              (load-file "/home/phil/src/emacs/lisp/erc/erc.el")
              (setq erc-message-english-s004 "%s" ; work around erc bug
                    erc-hack-applied t)
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
  (erc-tls :server "route.heroku.com" :port 45331
           :nick "hagelberg" :password camper-password)
  (erc-join-channel "#herokai_lounge")
  (erc-join-channel "#runtime_room"))

(defun erc-all () (interactive) (znc) (camper))

(defun erc-track-clear ()
  (interactive)
  (setq erc-modified-channels-alist nil))

;; (define-key erc-mode-map (kbd "C-c C-M-SPC") 'erc-track-clear)

(defun browse-last-url-in-brower ()
  (interactive)
  (require 'ffap)
  (save-excursion
    (let ((ffap-url-regexp
           (concat
            "\\("
            "news\\(post\\)?:\\|mailto:\\|file:"
            "\\|"
            "\\(ftp\\|https?\\|telnet\\|gopher\\|www\\|wais\\)://"
            "\\).")))
      (ffap-next-url t t))))

