(setq gnus-select-method
      '(nnimap "Mail"
               (nnimap-address "localhost")
               (nnimap-stream network)
               (nnimap-authenticator login))
      gnus-home-directory "~/.emacs.d"
      gnus-dribble-directory "~/.emacs.d"
      gnus-always-read-dribble-file t
      user-mail-address "phil@hagelb.org"
      user-full-name "Phil Hagelberg"
      gnus-ignored-from-addresses "Phil Hagelberg")

;; outgoing mail
(setq smtpmail-starttls-credentials '(("mail.technomancy.us" 587 nil nil))
      smtpmail-smtp-server "mail.technomancy.us"
      smtpmail-default-smtp-server "mail.technomancy.us"
      send-mail-function 'smtpmail-send-it
      gnus-gcc-mark-as-read t
      message-send-mail-function 'smtpmail-send-it
      smtpmail-smtp-service 587
      starttls-extra-arguments '("--insecure")
      smtpmail-auth-credentials '(("mail.technomancy.us"
                                   587
                                   "send@technomancy.us" ;; throwaway send-only account
                                   "testyy")))

(setq gnus-score-over-mark ?\u2191)          ; \u2191 \u2600
(setq gnus-score-below-mark ?\u2193)         ; \u2193 \u2602
(setq gnus-ticked-mark ?\u2691)
(setq gnus-dormant-mark ?\u2690)
(setq gnus-expirable-mark ?\u267b)
(setq gnus-read-mark ?\u2713)
(setq gnus-del-mark ?\u2717)
(setq gnus-killed-mark ?\u2620)
(setq gnus-replied-mark ?\u27f2)
(setq gnus-forwarded-mark ?\u2933)
(setq gnus-cached-mark ?\u260d)
(setq gnus-recent-mark ?\u2605)
(setq gnus-unseen-mark ?\u2729)
(setq gnus-unread-mark ?\u2709)

(setq message-kill-buffer-on-exit t
      gnus-treat-display-smileys nil
      gnus-message-archive-group "sent"
      gnus-fetch-old-headers 'some
      ;; nnmail-split-methods 'nnmail-split-fancy
      nnmail-crosspost nil
      mail-source-delete-incoming nil
      gnus-asynchronous t)

;; (setq nnmail-split-fancy
;;       '(|
;;         ;; code
;;         (from "unfuddle" "unfuddle")
;;         (to "phil@sonian" "sonian")
;;         (from "sonian\.net" "sonian")
;;         (to "obby-users@list.0x539.de" "obby-users")
;;         (any "conkeror" "conkeror")
;;         (any "swank-clojure" "swank-clojure")
;;         (any "clojure-dev" "clojure-dev")
;;         (any "clojure" "clojure")
;;         (any "compojure" "compojure")
;;         (any "seafunc" "seafunc")
;;         (any "Nxhtml" "nxhtml")
;;         (any "mozlab" "mozlab")
;;         (any "emacs-rails" "emacs-rails")
;;         (any "gems.*forge" "gems")
;;         (to "rubygems-developers@rubyforge.org" "gems")
;;         (any "emacs-devel" "emacs-devel")
;;         (any "bus-scheme" "bus-scheme")
;;         (any "ruby-core" "ruby-core")
;;         (from "@amazon\.com" "amazon")
;;         (to "magit" "magit")
;;         (to "rudel" "rudel")
;;         (any "ert-devs" "ert")
;;         (any "solr" "solr")
;;         (any "couchapp" "couchapp")
;;         (any "katta" "katta")
;;         (any "tika" "tika")
;;         (any "zenspider\\.com" "seattle.rb")
;;         (to "incanter" "incanter")
;;         (to "clj-processing" "clj-processing")
;;         (from "github" "github")
;;         (from "Phil Hagelberg.*jira@oss.101tec.com" junk)

;;         (to "phil@localhost" "feeds")

;;         ;; personal
;;         (from "agelberg" - "Alisha" "family")
;;         (from "Broach" "family")

;;         (any "David Morton" "xpoint")
;;         (any "Edward Volz" "xpoint")
;;         (any "John Gaitan" "xpoint")
;;         (from ".*crosspoint.*" "xpoint")
;;         (to "cp-parish-group" "xpoint")
;;         (from "hudsonite" "xpoint")
;;         (to "parishgroup2@googlegroups\.com" "parish")
;;         (to "cplparishgroups@googlegroups\.com" "parish")

;;         (any "zacchaeus-bounces" junk)
;;         (any "zacchaeus.*" "friends")
;;         (any ".*hackelford.*" "friends")
;;         (any ".*peckham.*" "friends")
;;         (any ".*carroll.*" "friends")
;;         (any ".*guenther.*" "friends")
;;         (any ".*rowley.*" "friends")
;;         (any ".*malabuyo.*" "friends")
;;         (any ".*holloway.*" "friends")
;;         (any "Arko" "friends")
;;         (any "Joel Watson" "friends")

;;         ;; misc
;;         (from "VMWare" junk)
;;         (any "cron" junk)
;;         (any "Anacron" junk)
;;         (from "Inbox Archiver" junk)
;;         (any "Meridius" junk)
;;         (any "Paris Hilton" junk)
;;         (any "cartographer" junk)
;;         (from "Joanne Neumann" junk)
;;         (any "ocruby" junk)
;;         (any "CNN Alerts" junk)
;;         (any "ALM Expo 2008" junk)
;;         (from "Dianne Des Rochers" junk)
;;         "inbox"))

(setq gnus-agent-expire-days 0)
(setq gnus-agent-enable-expiration 'DISABLE)

(gnus-demon-add-handler 'gnus-group-get-new-news 10 t)
(gnus-demon-init)

;; Unbind this key; it's annoying!
(define-key gnus-summary-mode-map "o" (lambda () (interactive)))

(add-hook 'message-mode-hook 'turn-on-flyspell)

(setq gnus-summary-line-format
      (concat
       "%{|%}"
       "%U%R%z"
       "%{|%}"
       "%(%-18,18f"
       "%{|%}"
       "%*%{%B%} %s%)"
       "\n"))

(setq gnus-parameters '((".*" (banner . iphone)))
      gnus-article-banner-alist '((iphone . "\\(^Sent from my iPhone$\\)"))
      gnus-use-full-window nil)

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

;; (mailcap-add "image/jpeg" "display")

(if (and (boundp 'system-specific-config)
         (file-exists-p system-specific-config))
    (load system-specific-config))

(require 'epa)
(setq epa-file-cache-passphrase-for-symmetric-encryption t)
