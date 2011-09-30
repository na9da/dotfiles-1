;;; -*- lexical-binding: t -*-

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

(add-hook 'clojure-mode-hook 'esk-turn-on-whitespace)

(setq slime-kill-without-query-p t
      confluence-url "http://dev.clojure.org/")

(global-set-key (kbd "C-x f") 'find-file-in-project)

;; move to slime
(put 'slime-lisp-host 'safe-local-variable 'stringp)
(put 'slime-port 'safe-local-variable 'integerp)

(defalias 'tdoe 'toggle-debug-on-error)

;; thanks johnw: https://gist.github.com/1198329
(defun find-grep-in-project (command-args)
  (interactive
   (progn
     (list (read-shell-command "Run find (like this): "
                               '("git ls-files -z | xargs -0 egrep -nH -e " . 41)
                               'grep-find-history))))
  (when command-args
    (let ((null-device nil)) ; see grep
      (grep command-args))))
