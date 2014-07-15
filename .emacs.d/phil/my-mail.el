;; for some reason debian screws this up for hand-compiled emacsen
(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")

(autoload 'mu4e "mu4e" "" t)

;; incoming
(setq mu4e-maildir-shortcuts '(("/INBOX"        . ?i)
                               ("/sent"         . ?s)
                               ("/drafts"       . ?d)
                               ("/leiningen"    . ?l)
                               ("/buying"       . ?b)
                               ("/travel"       . ?t)
                               ("/old-messages" . ?a))
      ;; allow for updating mail using 'U' in the main view:
      mu4e-get-mail-command "yes | mbsync -q -q -c <(gpg --batch -q -d ~/.chorts/mbsyncrc.gpg) hagelb"
      mu4e-html2text-command "elinks -dump"
      mu4e-headers-leave-behavior 'apply
      mu4e-show-images t
      mu4e-view-show-addresses t)

;; outgoing
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-stream-type 'starttls
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      user-mail-address "phil@hagelb.org"
      user-full-name  "Phil Hagelberg"
      mu4e-compose-signature-auto-include nil
      message-kill-buffer-on-exit t)

(add-hook 'mu4e-compose-mode-hook 'mml-secure-sign)

(add-hook 'mu4e-compose-mode-hook (lambda ()
                                    (require 'epa)
                                    (when (not (featurep 'chorts))
                                      (load-file "~/.chorts/chorts.el.gpg"))))
