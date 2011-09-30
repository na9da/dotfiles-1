;;; My general personalizations outside the starter kit

;; Random stuff

(require 'cl)

(setq-default save-place t)

(global-set-key (kbd "C-c f") 'find-file-in-project)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "conkeror"
      marmalade-server "http://marmalade-repo.org/"
      custom-file (expand-file-name "~/.emacs.d/custom.el")
      ispell-extra-args '("--keyboard=dvorak")
      ido-handle-duplicate-virtual-buffers 2)

;; ad-hoc installations

(ignore-errors (load "~/src/lein/pcmpl-lein.el"))
(ignore-errors (load "~/src/safe/.elisp/sonian.el")) ; for work

(add-hook 'tuareg-mode-hook (lambda ()
                              (define-key tuareg-mode-map (kbd "C-M-h")
                                'backward-kill-word)
                              (run-hooks 'prog-mode-hook)))

(add-to-list 'load-path "~/src/elim/elisp")
(autoload 'garak "garak" nil t)
(setq garak-alert-methods '(:notify)
      garak-alert-when '(:new :hidden :chat))

;; Packages

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(when (null package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(starter-kit starter-kit-lisp starter-kit-bindings
                                  starter-kit-eshell scpaste
                                  clojure-mode clojure-test-mode
                                  markdown-mode yaml-mode tuareg
                                  marmalade oddmuse scpaste))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(defalias 'guns 'gnus)

;; why not?
(eshell)
;; graaaaaaah! eshell doesn't respect eval-after-load for some reason:
(with-current-buffer "*eshell*" (setq pcomplete-cycle-completions nil))
(set-face-foreground 'eshell-prompt "turquoise")
