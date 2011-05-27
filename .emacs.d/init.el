;;; My general personalizations outside the starter kit

;; Random stuff

(setq-default save-place t)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "conkeror")

(global-set-key (kbd "C-c q") 'join-line)

(ignore-errors (load "~/src/safe/.elisp/sonian.el"))

;; Packages

(when (not (require 'package nil t))
  (load-file "/home/phil/.emacs.d/package-23.el"))

(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)

(package-initialize)

;; why not?

(eshell)
;; graaaaaaah! eshell doesn't respect eval-after-load for some reason:
(with-current-buffer "*eshell*" (setq pcomplete-cycle-completions nil))
