;;; general

(add-hook 'prog-mode-hook 'whitespace-mode)
(add-hook 'prog-mode-hook 'idle-highlight-mode)
(add-hook 'prog-mode-hook 'hl-line-mode)
(add-hook 'prog-mode-hook (defun pnh-add-watchwords ()
                            (font-lock-add-keywords
                             nil `(("\\<\\(FIX\\(ME\\)?\\|TODO\\)"
                                    1 font-lock-warning-face t)))))

;; disable this in low-color environments
(when (<= (display-color-cells) 8)
  (defun hl-line-mode () (interactive)))

;; unfortunately some codebases use tabs. =(
;; http://www.emacswiki.org/pics/static/TabsSpacesBoth.png

(set-default 'tab-width 4)
(set-default 'c-basic-offset 2)

(defalias 'tdoe 'toggle-debug-on-error)

;;; ruby

(eval-after-load 'ruby-mode
  '(ignore-errors
     (set (make-local-variable 'paredit-space-for-delimiter-predicates)
       '((lambda (endp delimiter) nil)))
     (paredit-mode 1)
     (inf-ruby-keys)))

(eval-after-load 'inf-ruby
  '(add-to-list 'inf-ruby-implementations '("bundler" . "bundle console")))

(eval-after-load 'ruby-mode
  '(define-key ruby-mode-map (kbd "#") (defun senny-ruby-interpolate ()
                                         "In a \"string\", interpolate."
                                         (interactive)
                                         (insert "#")
                                         (when (and
                                                (looking-back "\".*")
                                                (looking-at ".*\""))
                                           (insert "{}")
                                           (backward-char 1)))))

;;; clojure

(add-hook 'nrepl-connected-hook
          (defun pnh-clojure-mode-eldoc-hook ()
            (add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)))

(setq clojure-swank-command "lein jack-in %s"
      inferior-lisp-command "lein repl"
      whitespace-style '(face trailing lines-tail tabs))

(defun heroku-repl (app)
  (interactive "MApp: ")
  (inferior-lisp (format "heroku run lein repl -a %s" app)))

(add-hook 'clojure-mode-hook 'paredit-mode)

;;; elisp

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 'elisp-slime-nav-mode)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

(define-key emacs-lisp-mode-map (kbd "C-c v") 'eval-buffer)

(define-key read-expression-map (kbd "TAB") 'lisp-complete-symbol)
(define-key lisp-mode-shared-map (kbd "RET") 'reindent-then-newline-and-indent)
