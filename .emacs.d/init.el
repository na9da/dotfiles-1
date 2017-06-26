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
      tls-program "gnutls-cli"
      el-get-allow-insecure nil
      inhibit-startup-message t
      uniquify-buffer-name-style 'post-forward
      browse-url-browser-function 'browse-url-firefox)

(when window-system
  (setq scroll-conservatively 1))

;; 3rd-party packages
(dolist (l (directory-files (concat user-emacs-directory "lib") nil "^[^\.]"))
  (add-to-list 'load-path (concat user-emacs-directory "lib/" l)))

;; For some reason, update-directory-autoloads *always* writes its
;; paths as relative to user-emacs-directory, so we have to add
;; this. If we add user-emacs-directory by itself to load-path, Emacs
;; warns us that we shouldn't do that, so we trick it.
(add-to-list 'load-path (concat user-emacs-directory "/phil/../"))
(load (concat user-emacs-directory "my-autoload.el") t)
(load custom-file t)

(dolist (d (directory-files (concat user-emacs-directory "themes") nil "^[^\.]"))
  (add-to-list 'custom-theme-load-path
               (concat user-emacs-directory "themes/" d)))

;; personal stuff
(mapc 'load (directory-files (concat user-emacs-directory user-login-name)
                             t "^[^#].*el$"))

(add-to-list 'load-path "/home/phil/.emacs.d/lib/ido-ubiquitous")
(require 'ido-ubiquitous)
(add-to-list 'load-path "/home/phil/src/s.el")
(add-to-list 'load-path "/home/phil/src/weechat.el")
(autoload 'weechat-connect "weechat.el" nil t)
(eval-after-load 'weechat '(require 'weechat-tracking))

(when (require 'smex nil t)
  (setq smex-save-file (concat user-emacs-directory ".smex-items"))
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex))

(defalias 'yes-or-no-p 'y-or-n-p)

(column-number-mode t)

(winner-mode)

(ido-ubiquitous-mode t)

(eval-after-load 'markdown-mode
  (progn (add-hook 'markdown-mode-hook 'flyspell-mode)
         (add-hook 'markdown-mode-hook 'visual-line-mode)))

(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'text-mode-hook 'auto-fill-mode)

(defun uuid ()
  (interactive)
  (insert (shell-command-to-string "uuid -v 4")))

;; why not?
(eshell)
;; graaaaaaah! eshell doesn't respect eval-after-load for some reason:
(with-current-buffer "*eshell*" (setq pcomplete-cycle-completions nil))
(set-face-foreground 'eshell-prompt "turquoise")
(put 'upcase-region 'disabled nil)
