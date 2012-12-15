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
      ido-handle-duplicate-virtual-buffers 2
      org-default-notes-file "~/.dotfiles/.notes.org"
      org-remember-default-headline 'bottom
      org-completion-use-ido t
      twittering-username "technomancy"
      epa-armor t)

(load custom-file t)
(org-remember-insinuate)
(global-set-key (kbd "C-c m") 'org-remember)

;; ad-hoc installations

(ignore-errors (load "~/src/leiningen/pcmpl-lein.el"))

(add-to-list 'load-path "~/src/elim/elisp")
(autoload 'garak "garak" nil t)
(setq garak-alert-methods '(:notify)
      garak-alert-when '(:new :hidden :chat))

;; Packages

(when (not (require 'package nil t))
  (require 'package "package-23.el"))

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(when (null package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(starter-kit starter-kit-lisp starter-kit-bindings
                                  starter-kit-eshell
                                  monokai-theme zenburn-theme
                                  clojure-mode clojure-test-mode
                                  markdown-mode yaml-mode
                                  gist marmalade oddmuse scpaste))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(defalias 'guns 'gnus)

;; why not?
(eshell)
;; graaaaaaah! eshell doesn't respect eval-after-load for some reason:
(with-current-buffer "*eshell*" (setq pcomplete-cycle-completions nil))
(set-face-foreground 'eshell-prompt "turquoise")
