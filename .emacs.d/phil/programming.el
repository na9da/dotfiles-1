;; ruby
(eval-after-load 'ruby-mode
  '(ignore-errors
     (add-hook 'ruby-mode-hook 'esk-paredit-nonlisp)
     (inf-ruby-keys)))

;; unfortunately some codebases use tabs. =(
(set-default 'tab-width 4)
(set-default 'c-basic-offset 2)

(add-hook 'prog-mode-hook 'esk-turn-on-whitespace)

(add-hook 'tuareg-mode-hook 'esk-prog-mode-hook)

(add-hook 'haskell-mode-hook 'esk-prog-mode-hook)

(add-hook 'slime-repl-mode-hook
          (defun clojure-mode-slime-font-lock ()
            (let (font-lock-mode)
              (clojure-mode-font-lock-setup))))

(setq slime-kill-without-query-p t
      slime-compile-presave? t
      confluence-url "http://dev.clojure.org/")

(defalias 'tdoe 'toggle-debug-on-error)

(eval-after-load 'slime
  '(define-key slime-mode-map (kbd "C-c C-f") 'clojure-refactoring-prompt))

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
