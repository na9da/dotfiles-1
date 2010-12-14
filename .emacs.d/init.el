;;; My general personalizations outside the starter kit

;; Clojure confluence

(setq confluence-url "http://dev.clojure.org/confluence/rpc/xmlrpc")
(global-set-key "\C-xwf" 'confluence-get-page)

;; Random stuff

(setq-default save-place t)
(setq whitespace-line-column 80)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "conkeror")

(org-remember-insinuate)

(global-set-key (kbd "C-c C-r") 'remember)
(global-set-key (kbd "C-c q") 'join-line)

(ignore-errors
  (load "~/src/safe/.elisp/sonian-navigation.el"))

(eshell)
