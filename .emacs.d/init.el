;;; My general personalizations

;; Random stuff

(require 'cl)

(setq custom-file (expand-file-name "~/.emacs.d/custom.el")
      ispell-extra-args '("--keyboard=dvorak")
      ido-use-virtual-buffers t
      ido-handle-duplicate-virtual-buffers 2
      org-default-notes-file "~/.dotfiles/.notes.org"
      org-remember-default-headline 'bottom
      org-completion-use-ido t
      epa-armor t
      visible-bell t
      tls-checktrust 'ask
      el-get-allow-insecure nil
      inhibit-startup-message t
      uniquify-buffer-name-style 'post-forward)

(when window-system
  (setq scroll-conservatively 1))

(load custom-file t)

;; Packages

(add-to-list 'load-path "~/.emacs.d/el-get")
(require 'el-get)
(el-get 'sync '(;; lispy stuff
                clojure-mode elisp-slime-nav paredit
                             ;; useful applications
                             magit htmlize
                             ;; general fanciness
                             smex ido-hacks
                             idle-highlight-mode page-break-lines
                             ;; deps
                             pkg-info htmlize
                             ;; misc major modes
                             markdown-mode yaml-mode))

;; TODO: insecure packages
;; - parenface
;; - diminish

;;; from source

(add-to-list 'load-path "~/src/better-defaults")
(require 'better-defaults)

(add-to-list 'load-path "~/src/find-file-in-project")
(require 'find-file-in-project)

(add-to-list 'load-path "~/src/scpaste")
(require 'scpaste)

(mapc 'load (directory-files (concat user-emacs-directory user-login-name)
                             t "^[^#].*el$"))

;; activation

(setq smex-save-file (concat user-emacs-directory ".smex-items"))
(smex-initialize)

(require 'ido-hacks)
(ido-hacks-mode)

(global-set-key (kbd "M-x") 'smex) ; has to happen after ido-hacks-mode

(defalias 'yes-or-no-p 'y-or-n-p)

(column-number-mode t)

(winner-mode)

;; why not?
(eshell)
;; graaaaaaah! eshell doesn't respect eval-after-load for some reason:
(with-current-buffer "*eshell*" (setq pcomplete-cycle-completions nil))
(set-face-foreground 'eshell-prompt "turquoise")
