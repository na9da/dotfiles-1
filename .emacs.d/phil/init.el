;;; My personalizations

;; elisp libraries I run from source checkouts:

(add-to-list 'load-path "/home/phil/src/emacs-w3m")
(add-to-list 'load-path "/home/phil/src/twittering-mode")
(add-to-list 'load-path "/home/phil/src/clojure-mode")
(add-to-list 'load-path "/home/phil/src/epresent")

(autoload 'twit "twittering-mode" "twitter" t)

(require 'clojure-mode)

(autoload 'clojure-test-mode "clojure-test-mode" "Clojure test mode" t)
(autoload 'clojure-test-maybe-enable "clojure-test-mode" "" t)
(add-hook 'clojure-mode-hook 'clojure-test-maybe-enable)

(autoload 'w3m "w3m" "w3m browser" t)

(autoload 'epresent-run-frame "epresent" "" t)
(global-set-key [f12] 'epresent-run-frame)

(setq epresent-mode-line-format mode-line-format)

(eval-after-load 'epresent
  '(set-face-attribute 'epresent-title-face nil :underline nil))

;; Clojure confluence

(setq confluence-url "http://dev.clojure.org/confluence/rpc/xmlrpc")
(global-set-key "\C-xwf" 'confluence-get-page)

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
