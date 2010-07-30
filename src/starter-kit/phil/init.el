;;; My personalizations

;; elisp libraries I run from source checkouts:

(add-to-list 'load-path "/home/phil/src/emacs-w3m")
;; (add-to-list 'load-path "/home/phil/src/magit")
(add-to-list 'load-path "/home/phil/src/twittering-mode")
(add-to-list 'load-path "/home/phil/src/clojure-mode")

;; (autoload 'magit-status "magit" "magit" t)
(autoload 'twit "twittering-mode" "twitter" t)

(require 'clojure-mode)

(autoload 'clojure-test-mode "clojure-test-mode" "Clojure test mode" t)
(autoload 'clojure-test-maybe-enable "clojure-test-mode" "" t)
(add-hook 'clojure-mode-hook 'clojure-test-maybe-enable)

(add-to-list 'package-archives
             '("technomancy" . "http://repo.technomancy.us/emacs/") t)

(autoload 'w3m "w3m" "w3m browser" t)

(ignore-errors (load "../../paredit/paredit-beta")
               (load "../../paredit/paredit-delimiter-space")
               (load "../../paredit/paredit-semicolon"))

;; Random stuff

(setq-default save-place t)
(setq whitespace-line-column 80
      twittering-username "technomancy")

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "conkeror")

(org-remember-insinuate)

(global-set-key (kbd "C-c C-r") 'remember)
;; (global-set-key (kbd "S-M-x") 'smex)

(eshell)
