;; ruby
(eval-after-load 'ruby-mode
  '(ignore-errors
     (add-hook 'ruby-mode-hook 'esk-paredit-nonlisp)
     (inf-ruby-keys)))

(defun esk-turn-on-whitespace ()
  (when (eq major-mode 'ruby-mode)
    ;; can't fight it any longer
    (set (make-local-variable 'whitespace-line-column) 120))
  (whitespace-mode t))

;; unfortunately some codebases use tabs. =(
;; http://www.emacswiki.org/pics/static/TabsSpacesBoth.png

(set-default 'tab-width 4)
(set-default 'c-basic-offset 2)

(put 'clojure-test-ns-segment-position 'safe-local-variable 'integerp)
(put 'clojure-mode-load-command 'safe-local-variable 'stringp)
(put 'clojure-swank-command 'safe-local-variable 'stringp)

(add-hook 'prog-mode-hook 'esk-turn-on-whitespace)

(add-hook 'tuareg-mode-hook 'esk-prog-mode-hook)

(add-hook 'haskell-mode-hook 'esk-prog-mode-hook)

(add-hook 'slime-repl-mode-hook
          (defun clojure-mode-slime-font-lock ()
            (let (font-lock-mode)
              (clojure-mode-font-lock-setup))))

(add-hook 'nrepl-connected-hook
          (defun add-clojure-mode-eldoc-hook ()
            (add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)))

(setq slime-kill-without-query-p t
      slime-compile-presave? t
      clojure-swank-command "lein jack-in %s"
      inferior-lisp-command "lein repl")

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

(defun eshell/export-env (&optional env-file)
  (interactive)
  (let ((original-buffer (current-buffer)))
    (with-temp-buffer
      (insert-file (or env-file ".env"))
      (goto-char (point-min))
      (while (< (point) (point-max))
        (let ((line (substring (thing-at-point 'line) 0 -1)))
          (with-current-buffer original-buffer
            (eshell/export line)))
        (next-line)))))

(defalias 'eshell/ee 'eshell/export-env)

(eval-after-load 'inf-ruby
  '(add-to-list 'inf-ruby-implementations '("bundler" . "bundle console")))

(defun heroku-repl (app)
  (interactive "MApp: ")
  (inferior-lisp (format "heroku run lein repl -a %s" app)))

(defun senny-ruby-interpolate ()
  "In a double quoted string, interpolate."
  (interactive)
  (insert "#")
  (when (and
         (looking-back "\".*")
         (looking-at ".*\""))
    (insert "{}")
    (backward-char 1)))

(eval-after-load 'ruby-mode
  '(define-key ruby-mode-map (kbd "#") 'senny-ruby-interpolate))

(add-to-list 'auto-mode-alist '("\\.elm\\'" . haskell-mode))

(defun nrepl-inspect (target)
  ;; TODO: completion
  (interactive "MTarget: ")
  (nrepl-send-string "(require 'clojure.pprint 'clojure.reflect)" 'identity)
  (let ((form (format "(clojure.pprint/pprint (clojure.reflect/reflect %s))"
                      target))
        (inspect-buffer (nrepl-popup-buffer "*nREPL inspect*" t)))
    (nrepl-send-string form (nrepl-popup-eval-out-handler inspect-buffer))))
