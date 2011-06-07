(eval-after-load 'ruby-mode
  '(ignore-errors
     (add-hook 'ruby-mode-hook 'esk-paredit-nonlisp)
     (require 'inf-ruby)
     (inf-ruby-keys)))

(add-hook 'clojure-mode-hook 'esk-turn-on-whitespace)

;; devilspie config
(add-to-list 'auto-mode-alist '("\\.ds$" . lisp-mode))

;; unfortunately some codebases use tabs. =(
(set-default 'tab-width 4)
(set-default 'c-basic-offset 2)

(add-hook 'xml-mode-hook 'esk-run-coding-hook)
(add-hook 'java-mode-hook 'esk-run-coding-hook)

(eval-after-load 'java-mode
  '(define-key java-mode-map (kbd "C-M-h") 'backward-kill-word))

(add-to-list 'auto-mode-alist '("\\.mirah$" . ruby-mode))

(eval-after-load 'slime
  '(durendal-enable))

(global-set-key (kbd "C-c C-j") 'durendal-jack-in)
(global-set-key (kbd "C-c g") 'magit-status)

(add-hook 'slime-repl-mode-hook 'clojure-mode-font-lock-setup)

(setq slime-kill-without-query-p t
      slime-net-coding-system 'utf-8-unix)

;; move to slime
(put 'slime-lisp-host 'safe-local-variable 'stringp)
(put 'slime-port 'safe-local-variable 'integerp)
