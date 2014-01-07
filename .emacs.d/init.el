;;; My general personalizations

;; Random stuff

(require 'cl)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "conkeror"
      custom-file (expand-file-name "~/.emacs.d/custom.el")
      ispell-extra-args '("--keyboard=dvorak")
      ido-use-virtual-buffers t
      ido-handle-duplicate-virtual-buffers 2
      org-default-notes-file "~/.dotfiles/.notes.org"
      org-remember-default-headline 'bottom
      org-completion-use-ido t
      twittering-username "technomancy"
      epa-armor t
      visible-bell t
      inhibit-startup-message t)

(when window-system
  (setq scroll-conservatively 1))

(load custom-file t)

;; Packages

(when (not (require 'package nil t))
  (require 'package "package-23.el"))

(package-initialize)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(when (null package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(better-defaults clojure-mode paredit
                                      idle-highlight-mode ;; ido-ubiquitous
                                      find-file-in-project magit
                                      elisp-slime-nav parenface-plus
                                      markdown-mode yaml-mode page-break-lines
                                      scpaste diminish smex))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(mapc 'load (directory-files (concat user-emacs-directory user-login-name)
                             t "^[^#].*el$"))

;; activation

(setq smex-save-file (concat user-emacs-directory ".smex-items"))
(smex-initialize)

(require 'ido-hacks) ; still not on marmalade uuuugh
(ido-hacks-mode)

(global-set-key (kbd "M-x") 'smex) ; has to happen after ido-hacks-mode

(defalias 'yes-or-no-p 'y-or-n-p)

(column-number-mode t)

(when (file-exists-p "~/src/floobits/floobits.el")
  (autoload 'floobits-join-workspace "~/src/floobits/floobits.el" nil t))

;; why not?
(eshell)
;; graaaaaaah! eshell doesn't respect eval-after-load for some reason:
(with-current-buffer "*eshell*" (setq pcomplete-cycle-completions nil))
(set-face-foreground 'eshell-prompt "turquoise")
