;;; My general personalizations outside the starter kit

;; Random stuff

(require 'cl)

(setq-default save-place t)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "conkeror"
      marmalade-server "http://marmalade-repo.org/"
      custom-file (expand-file-name "~/.emacs.d/custom.el"))

(ignore-errors (load "~/src/lein/pcmpl-lein.el"))
(ignore-errors (load "~/src/safe/.elisp/sonian.el")) ; for work

;; Packages

(when (not (require 'package nil t))
  (load-file "/home/phil/.emacs.d/package-23.el"))

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

(package-initialize)

(when (featurep 'smex)
  (global-set-key (kbd "M-x") 'smex)
  (smex-initialize))

(dolist (p '(clojure-mode slime slime-repl clojure-test-mode htmlize
                          scpaste paredit starter-kit starter-kit-lisp smex
                          idle-highlight-mode marmalade oddmuse scpaste))
  (when (not (package-installed-p p))
    (package-install p)))

(defalias 'guns 'gnus)

;; why not?
(eshell)
;; graaaaaaah! eshell doesn't respect eval-after-load for some reason:
(with-current-buffer "*eshell*" (setq pcomplete-cycle-completions nil))
