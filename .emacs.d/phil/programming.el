(eval-after-load 'ruby-mode
  '(ignore-errors
     '(add-hook 'ruby-mode-hook 'esk-paredit-nonlisp)
    (require 'inf-ruby)
    (inf-ruby-keys)))

;; (eval-after-load 'swank-clojure
;;   '(add-to-list 'swank-clojure-extra-vm-args
;;                 "-agentlib:jdwp=transport=dt_socket,address=8021,server=y,suspend=n"))

(add-hook 'clojure-mode-hook 'esk-turn-on-whitespace)

(setq inferior-lisp-program
      "java -cp /home/phil/src/clojure/clojure.jar clojure.main")

(add-to-list 'auto-mode-alist '("\\.ds$" . lisp-mode))

;; unfortunately some codebases use tabs. =(
(set-default 'tab-width 4)
(set-default 'c-basic-offset 2)

(add-hook 'xml-mode-hook 'esk-run-coding-hook)
(add-hook 'java-mode-hook 'esk-run-coding-hook)

(eval-after-load 'java-mode
  '(progn
     (define-key java-mode-map (kbd "C-M-h") 'backward-kill-word)))

(add-to-list 'auto-mode-alist '("\\.duby$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.mirah$" . ruby-mode))

(setq slime-net-coding-system 'utf-8-unix)

(eval-after-load 'slime
  '(durendal-enable))

(global-set-key (kbd "C-c C-j") 'durendal-jack-in)
(global-set-key (kbd "C-c C-g") 'magit-status)
(global-set-key (kbd "C-c g") 'magit-status)

(add-hook 'slime-repl-mode-hook 'clojure-mode-font-lock-setup)

(setq slime-kill-without-query-p t)
;; move to slime
(put 'slime-lisp-host 'safe-local-variable 'stringp)
(put 'slime-port 'safe-local-variable 'integerp)

(defun safe ()
  (interactive)
  (setq frame-title-format "emacs-safe") ; for devilspie
  (color-theme-zenburn)
  (find-file "~/src/safe/log.org")
  (switch-to-buffer "*eshell*")
  (eshell/cd "~/src/safe")
  (delete-other-windows)
  (split-window-horizontally)
  (magit-status "~/src/safe/")
  (durendal-jack-in))
