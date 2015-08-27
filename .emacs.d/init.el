;;; My general personalizations

;; Random stuff

(require 'cl)

(setq custom-file (expand-file-name "~/.emacs.d/custom.el")
      ispell-extra-args '("--keyboard=dvorak")
      ido-use-virtual-buffers t
      org-default-notes-file "~/.dotfiles/.notes.org"
      org-remember-default-headline 'bottom
      org-completion-use-ido t
      epa-armor t
      visible-bell t
      tls-checktrust 'ask
      el-get-allow-insecure nil
      inhibit-startup-message t
      uniquify-buffer-name-style 'post-forward
      browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox")

(when window-system
  (setq scroll-conservatively 1))

(load custom-file t)

;; Packages

(require 'package)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(package-initialize)
(dolist (p '(better-defaults paredit find-file-in-project scpaste
							 zenburn-theme diminish
							 magit htmlize smex ido-ubiquitous
							 idle-highlight-mode page-break-lines
							 lua-mode elisp-slime-nav
							 markdown-mode))
  (when (not (package-installed-p p)) (package-install p)))

(mapc 'load (directory-files (concat user-emacs-directory user-login-name)
                             t "^[^#].*el$"))

;; activation

(setq smex-save-file (concat user-emacs-directory ".smex-items"))
;; (smex-initialize)

;; (global-set-key (kbd "M-x") 'smex) ; has to happen after ido-hacks-mode

(defalias 'yes-or-no-p 'y-or-n-p)

(column-number-mode t)

(winner-mode)

(eval-after-load 'markdown-mode
  (progn (add-hook 'markdown-mode 'flyspell-mode)
         (add-hook 'markdown-mode 'auto-fill-mode)))

;; why not?
(eshell)
;; graaaaaaah! eshell doesn't respect eval-after-load for some reason:
(with-current-buffer "*eshell*" (setq pcomplete-cycle-completions nil))
(set-face-foreground 'eshell-prompt "turquoise")
