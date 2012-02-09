;;; trying out rcirc

(ignore-errors
  (load (expand-file-name "~/.chorts.el")))

(setq rcirc-server-alist `(("route.heroku.com" :port 10688
                            :encryption tls :nick "technomancy"
                            :password ,znc-password
                            :channels ("#emacs" "#clojure" "#leiningen"
                                       "#xmonad" "#84115" "#seajure")))
      rcirc-ignore-list '("pjb" "e1f" "Lajla")
      rcirc-fill-column 75
      rcirc-buffer-maximum-lines 2000
      rcirc-authinfo `(("freenode" nickserv "technomancy" ,freenode-password)
                       ("heroku" nickserv "technomancy" ,freenode-password)
                       ("freenode" nickserv "TeXnomancy" ,freenode-password)))

(add-hook 'rcirc-mode-hook 'turn-on-flyspell)
(add-hook 'rcirc-mode-hook 'rcirc-omit-mode)
(add-hook 'rcirc-mode-hook (defun rcirc-trim-modeline ()
                             (setq mode-line-format '("  %b %p" " "
                                                      global-mode-string))))

(eval-after-load 'rcirc
  '(dolist (p '(rcirc-notify rcirc-color rcirc-ucomplete))
     (when (not (package-installed-p p))
       (package-install p))))

(eval-after-load 'rcirc
  '(progn
     (defvar rcirc-color-is-deterministic nil
       "Normally rcirc just assigns random colors to nicks.
These colors are based on the list in `rcirc-colors'.
If you set this variable to a non-nil value, an md5 hash is
computed based on the nickname and the first twelve bytes are
used to determine the color: #rrrrggggbbbb.")

     (defadvice rcirc-facify (before rcirc-facify-colors activate)
       "Add colors to other nicks based on `rcirc-colors'."
       (when (and (eq face 'rcirc-other-nick)
                  (not (string= string "")))
         (let ((cell (gethash string rcirc-color-mapping)))
           (unless cell
             (setq cell (cons 'foreground-color
                              (if rcirc-color-is-deterministic
                                  (concat "#" (substring (md5 string) 0 12))
                                (elt rcirc-colors (random (length rcirc-colors))))))
             (puthash (substring-no-properties string) cell rcirc-color-mapping))
           (setq face (list cell)))))
     (rcirc-track-minor-mode t)))

(defun window-register-bottom (r &optional x)
  (interactive "cJump to register: \nP")
  (jump-to-register r)
  (walk-windows (lambda (w) (end-of-buffer))))

(global-set-key (kbd "C-x w") 'window-register-bottom)

;;; Still need ERC for campervan:

(setq erc-prompt ">"
      erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))

(eval-after-load 'erc
  '(progn
     (when (not (package-installed-p 'erc-hl-nicks))
       (package-install 'erc-hl-nicks))
     (when (not (package-installed-p 'erc-nick-notify))
       (package-install 'erc-nick-notify))
     (require 'erc-spelling)
     (require 'erc-truncate)
     (require 'erc-hl-nicks)
     (require 'erc-nick-notify)
     (add-to-list 'erc-modules 'hl-nicks 'spelling)
     (set-face-foreground 'erc-input-face "dim gray")
     (set-face-foreground 'erc-my-nick-face "blue")))
