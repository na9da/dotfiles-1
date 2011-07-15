(eval-after-load 'ruby-mode
  '(ignore-errors
     (add-hook 'ruby-mode-hook 'esk-paredit-nonlisp)
     (require 'inf-ruby)
     (inf-ruby-keys)))

;; devilspie config
(add-to-list 'auto-mode-alist '("\\.ds$" . lisp-mode))

;; unfortunately some codebases use tabs. =(
(set-default 'tab-width 4)
(set-default 'c-basic-offset 2)

(eval-after-load 'java-mode
  '(define-key java-mode-map (kbd "C-M-h") 'backward-kill-word))

(add-to-list 'auto-mode-alist '("\\.mirah$" . ruby-mode))

(add-hook 'slime-repl-mode-hook 'clojure-mode-font-lock-setup)

(setq slime-kill-without-query-p t)

;; move to slime
(put 'slime-lisp-host 'safe-local-variable 'stringp)
(put 'slime-port 'safe-local-variable 'integerp)

(defalias 'tdoe 'toggle-debug-on-error)

(setq confluence-url "http://dev.clojure.org/")
