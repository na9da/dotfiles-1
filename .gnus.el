(setq gnus-select-method '(nnnil "")
      gnus-directory "~/.emacs.d/news"
      gnus-kill-files-directory "~/.emacs.d/news"
      gnus-home-directory "~/.emacs.d"
      gnus-dribble-directory "~/.emacs.d"
      gnus-always-read-dribble-file t
      user-mail-address "phil@hagelb.org"
      user-full-name "Phil Hagelberg"
      gnus-ignored-from-addresses "Phil Hagelberg"
      gnus-treat-x-pgp-sig t

      mail-source-directory "~/.emacs.d/mail"
      message-directory "~/.emacs.d/mail"

      message-kill-buffer-on-exit t
      gnus-treat-display-smileys nil
      gnus-message-archive-group "sent"
      gnus-fetch-old-headers 'some
      nnmail-crosspost nil
      mail-source-delete-incoming nil
      gnus-gcc-mark-as-read t

      ;; outgoing
      send-mail-function 'smtpmail-send-it
      smtpmail-smtp-server "mail.technomancy.us"
      smtpmail-smtp-service 587
      gnus-message-replysign t
      gnus-posting-styles '(("heroku"
                             (address "phil.hagelberg@heroku.com")))
      ;; agent
      gnus-asynchronous t
      gnus-agent-expire-days 0
      gnus-agent-synchronize-flags t
      gnus-agent-enable-expiration 'DISABLE

      ;; accounts
      gnus-secondary-select-methods
      '((nnimap "gmail"
                (nnimap-address "imap.gmail.com")
                (nnimap-server-port 993)
                (nnimap-stream ssl))
        (nnimap "heroku"
                (nnimap-address "imap.googlemail.com")
                (nnimap-server-port 993)
                (nnimap-stream ssl))
        ))

;; display chars
(setq gnus-score-over-mark ?\u2191          ; \u2191 \u2600
      gnus-score-below-mark ?\u2193         ; \u2193 \u2602
      gnus-ticked-mark ?\u2691
      gnus-dormant-mark ?\u2690
      gnus-expirable-mark ?\u267b
      gnus-read-mark ?\u2713
      gnus-del-mark ?\u2717
      gnus-killed-mark ?\u2620
      gnus-replied-mark ?\u27f2
      gnus-forwarded-mark ?\u2933
      gnus-cached-mark ?\u260d
      gnus-recent-mark ?\u2605
      gnus-unseen-mark ?\u2729
      gnus-unread-mark ?\u2709
      gnus-summary-line-format (concat "%{|%}"
                                       "%U%R%z"
                                       "%{|%}"
                                       "%(%-18,18f"
                                       "%{|%}"
                                       "%*%{%B%} %s%)"
                                       "\n"))

(gnus-demon-add-handler 'gnus-group-get-new-news 10 t)
(gnus-demon-init)

;; Unbind this key; it's annoying!
(define-key gnus-summary-mode-map "o" (lambda () (interactive)))

(add-hook 'message-mode-hook 'turn-on-flyspell)
(add-hook 'message-mode-hook 'epa-mail-mode)

(setq gnus-parameters '((".*" (banner . iphone)))
      gnus-article-banner-alist '((iphone . "\\(^Sent from my iPhone$\\)"))
      gnus-use-full-window nil)

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

(if (and (boundp 'system-specific-config)
         (file-exists-p system-specific-config))
    (load system-specific-config))

(require 'epa)
(setq epa-file-cache-passphrase-for-symmetric-encryption t)

(add-hook 'gnus-article-prepare-hook
          (lambda () (gnus-article-hide-citation 1)))

(defun aar/get-new-news-and-disconnect (&optional arg)
  "Plug in, send, receive, plug out."
  (interactive "P")
  (gnus-group-save-newsrc)
  (gnus-agent-toggle-plugged t)
  (gnus-group-send-queue)
  (gnus-group-get-new-news arg)
  (gnus-agent-fetch-session)
  (gnus-group-save-newsrc)
  (gnus-agent-toggle-plugged nil))

(define-key gnus-group-mode-map (kbd "g") 'aar/get-new-news-and-disconnect)
