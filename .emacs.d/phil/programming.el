;; ruby
(autoload 'run-ruby "/home/phil/.emacs.d/inf-ruby.el" nil t)

(eval-after-load 'ruby-mode
  '(ignore-errors
     (add-hook 'ruby-mode-hook 'esk-paredit-nonlisp)
     (require 'inf-ruby "/home/phil/.emacs.d/inf-ruby.el")
     (inf-ruby-keys)))

(add-to-list 'auto-mode-alist '("\\.mirah$" . ruby-mode))

;; devilspie config
(add-to-list 'auto-mode-alist '("\\.ds$" . lisp-mode))

;; unfortunately some codebases use tabs. =(
(set-default 'tab-width 4)
(set-default 'c-basic-offset 2)

(add-hook 'tuareg-mode-hook 'esk-prog-mode-hook)

(add-hook 'slime-repl-mode-hook 'clojure-mode-font-lock-setup)

(setq slime-kill-without-query-p t
      confluence-url "http://dev.clojure.org/")

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
