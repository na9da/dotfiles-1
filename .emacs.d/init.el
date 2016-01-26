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
      load-prefer-newer t
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
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
(dolist (p '(better-defaults paredit scpaste
                             zenburn-theme diminish
                             htmlize smex ido-ubiquitous
                             idle-highlight-mode page-break-lines
                             lua-mode elisp-slime-nav
                             markdown-mode))
  (when (not (package-installed-p p)) (package-install p)))

(mapc 'load (directory-files (concat user-emacs-directory user-login-name)
                             t "^[^#].*el$"))

;; activation

(when (load "~/.emacs.d/smex.el" t)
  (setq smex-save-file (concat user-emacs-directory ".smex-items"))
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex))

(defalias 'yes-or-no-p 'y-or-n-p)

(column-number-mode t)

(winner-mode)

(eval-after-load 'markdown-mode
  (progn (add-hook 'markdown-mode 'flyspell-mode)
         (add-hook 'markdown-mode 'auto-fill-mode)))

(add-hook 'text-mode 'flyspell-mode)
(add-hook 'text-mode 'auto-fill-mode)

(defun uuid ()
  (interactive)
  (insert (shell-command-to-string "uuid -v 4")))

(add-to-list 'load-path "~/src/find-file-in-project")
(require 'find-file-in-project)
(add-to-list 'ffip-patterns "*.lua")
(add-to-list 'ffip-patterns "*.md")
(add-to-list 'ffip-patterns "*.lsp")

(add-to-list 'load-path "~/src/magit")
(autoload 'magit-status "magit" nil t)

;; why not?
(eshell)
;; graaaaaaah! eshell doesn't respect eval-after-load for some reason:
(with-current-buffer "*eshell*" (setq pcomplete-cycle-completions nil))
(set-face-foreground 'eshell-prompt "turquoise")
(put 'upcase-region 'disabled nil)
