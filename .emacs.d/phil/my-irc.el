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

(eval-after-load 'rcirc
  '(dolist (p '(rcirc-notify rcirc-color rcirc-ucomplete))
     (when (not (package-installed-p p))
       (package-install p))))

(eval-after-load 'rcirc
  '(rcirc-track-minor-mode t))

(defun window-register-bottom (r &optional x)
  (interactive "cJump to register: \nP")
  (jump-to-register r)
  (walk-windows (lambda (w) (end-of-buffer))))

(global-set-key (kbd "C-x w") 'window-register-bottom)
