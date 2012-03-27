;;; trying out rcirc

(ignore-errors
  (setq rcirc-server-alist `(("route.heroku.com" :port 10688
                              :encryption tls :nick "technomancy"
                              :password ,znc-password
                              :channels ("#emacs" "#clojure"
                                         "#leiningen" "#seajure"))
                             ("heroku.irc.grove.io" :port 6697
                              :encryption tls
                              :nick "technomancy" :password "heroku"
                              :channels ("#dx" "#clojure")))
        rcirc-dim-nicks '("pjb" "e1f")
        rcirc-ignore-list '("Lajla")
        rcirc-fill-column 75
        rcirc-notify-timeout 2
        rcirc-notify-message "%s: %s"
        rcirc-buffer-maximum-lines 2000
        rcirc-authinfo `(("freenode" nickserv "technomancy" ,freenode-password)
                         ("heroku" nickserv "technomancy" ,freenode-password)
                         ("freenode" nickserv "TeXnomancy" ,freenode-password)
                         ("grove.io" nickserv "technomancy" ,grove-password))))

(add-hook 'rcirc-mode-hook 'turn-on-flyspell)
(add-hook 'rcirc-mode-hook 'rcirc-omit-mode)
(add-hook 'rcirc-mode-hook (defun rcirc-trim-modeline ()
                             (setq mode-line-format '("  %b %p" " "
                                                      global-mode-string))))

(defun eshell/irc () (irc nil))

(eval-after-load 'rcirc
  '(dolist (p '(rcirc-notify rcirc-color rcirc-ucomplete))
     (when (not (package-installed-p p))
       (package-install p))))

(eval-after-load 'rcirc
  '(progn
     (rcirc-notify-add-hooks)

     ;; the one in rcirc-notify.el is messed up
     (defun rcirc-notify-allowed (nick &optional delay)
       "Return non-nil if a notification should be made for NICK.
If DELAY is specified, it will be the minimum time in seconds
that can occur between two notifications.  The default is
`rcirc-notify-timeout'."
       ;; Check current frame buffers
       (let ((rcirc-in-a-frame-p
              (some (lambda (f)
                      (and (equal "rcirc" (cdr f))
                           (car f)))
                    (mapcar (lambda (f)
                              (let ((buffer (car (frame-parameter f 'buffer-list))))
                                (with-current-buffer buffer
                                  (cons buffer mode-name))))
                            (visible-frame-list)))))
         (if (or (not rcirc-notify-check-frame) (not rcirc-in-a-frame-p))
             (progn
               (unless delay (setq delay rcirc-notify-timeout))
               (let ((cur-time (float-time (current-time)))
                     (cur-assoc (assoc nick rcirc-notify--nick-alist))
                     (last-time))
                 (if cur-assoc
                     (progn
                       (setq last-time (cdr cur-assoc))
                       (setcdr cur-assoc cur-time)
                       (> (abs (- cur-time last-time)) delay))
                   (push (cons nick cur-time) rcirc-notify--nick-alist)
                   t))))))

     (defun rcirc-notify-page-me (msg)
       (start-process "page-me" nil
                      ;; 8640000 ms = 1 day
                      "notify-send" "-u" "normal" "-i" "gtk-dialog-info"
                      "-t" "2000" "rcirc"
                      msg))

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
