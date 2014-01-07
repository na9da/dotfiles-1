;;; general

(add-hook 'prog-mode-hook 'whitespace-mode)
(add-hook 'prog-mode-hook 'idle-highlight-mode)
(add-hook 'prog-mode-hook 'hl-line-mode)
(add-hook 'prog-mode-hook 'page-break-lines-mode)
(add-hook 'prog-mode-hook (defun pnh-add-watchwords ()
                            (font-lock-add-keywords
                             nil `(("\\<\\(FIX\\(ME\\)?\\|TODO\\)"
                                    1 font-lock-warning-face t)))))

(setq page-break-lines-char ?-)

(defun pnh-paredit-no-space ()
  (set (make-local-variable 'paredit-space-for-delimiter-predicates)
       '((lambda (endp delimiter) nil))))

;; disable this in low-color environments
(when (<= (display-color-cells) 8)
  (defun hl-line-mode () (interactive)))

;; unfortunately some codebases use tabs. =(
;; http://www.emacswiki.org/pics/static/TabsSpacesBoth.png

(set-default 'tab-width 4)
(set-default 'c-basic-offset 2)

(defalias 'tdoe 'toggle-debug-on-error)

;; (add-hook 'prog-mode-hook (lambda ()
;;                             (add-to-list 'after-change-functions 'size-limit)))

(defvar size-limit-lines 25)

(defun size-limit (beginning end length)
  ;; (let* ((bod (save-excursion (beginning-of-defun) (line-number-at-pos)))
  ;;        (eod (save-excursion (end-of-defun) (line-number-at-pos))))
  ;;   (when (and (= 0 length) (> (- eod bod) size-limit-lines))
  ;;     (message "Function is too big!")
  ;;     (delete-region beginning end)))
  )


;;; ruby

(add-hook 'ruby-mode-hook 'pnh-paredit-no-space)
(add-hook 'ruby-mode-hook 'paredit-mode)
(add-hook 'ruby-mode-hook 'inf-ruby-keys)

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

(add-to-list 'load-path "~/src/cider")
(autoload 'cider-jack-in "cider.el" nil t)

(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

(setq inferior-lisp-command "lein repl"
      cider-repl-popup-stacktraces t)

(add-hook 'clojure-mode-hook 'paredit-mode)

;;; elisp

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 'elisp-slime-nav-mode)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

(define-key emacs-lisp-mode-map (kbd "C-c v") 'eval-buffer)

(define-key read-expression-map (kbd "TAB") 'lisp-complete-symbol)
(define-key lisp-mode-shared-map (kbd "RET") 'reindent-then-newline-and-indent)

;;; racket

(add-hook 'scheme-mode-hook 'paredit-mode)
(setq geiser-active-implementations '(racket))

(eval-after-load 'scheme-mode
  '(define-key scheme-mode-map (kbd "C-c C-s") 'run-scheme))

(defun chicken-doc (&optional obtain-function)
  (interactive)
  (let ((func (funcall (or obtain-function 'current-word))))
    (when func
      (process-send-string (scheme-proc)
                           (format "(require-library chicken-doc) ,doc %S\n" func))
      (save-selected-window
        (select-window (display-buffer (get-buffer scheme-buffer) t))
        (goto-char (point-max))))))

(eval-after-load 'scheme-mode
 '(define-key scheme-mode-map (kbd "C-c C-d") 'chicken-doc))

;;; ocaml

(add-to-list 'ido-ignore-files ".byte")
(add-to-list 'ido-ignore-files ".native")

(add-hook 'tuareg-mode-hook 'paredit-mode)
(add-hook 'tuareg-mode-hook 'pnh-paredit-no-space)
(add-hook 'tuareg-mode-hook (lambda () (run-hooks 'prog-mode-hook)))

(add-to-list 'load-path "~/.opam/system/build/utop.1.5/src/top/")
(autoload 'utop "utop" "Toplevel for OCaml" t)
(setq utop-command "opam config exec \"utop -emacs\"")
(setq tuareg-interactive-program "opam config exec ocaml")
(autoload 'utop-setup-ocaml-buffer "utop" "Toplevel for OCaml" t)
(add-hook 'tuareg-mode-hook 'utop-setup-ocaml-buffer)

(eval-after-load 'tuareg-mode
  '(progn
     (define-key tuareg-mode-map (kbd "C-M-h") 'backward-kill-word)
     (define-key tuareg-mode-map (kbd "[") 'paredit-open-square)
     (define-key tuareg-mode-map (kbd "]") 'paredit-close-square)
     (define-key tuareg-mode-map (kbd "{") 'paredit-open-curly)
     (define-key tuareg-mode-map (kbd "}") 'paredit-close-curly)
     (define-key tuareg-mode-map (kbd "}") 'paredit-close-curly)
     (define-key tuareg-mode-map (kbd "<backspace>") 'paredit-backward-delete)
     (define-key tuareg-mode-map (kbd "RET") 'reindent-then-newline-and-indent)
     (define-key tuareg-mode-map (kbd "C-c C-k") 'tuareg-eval-buffer)
     (define-key tuareg-mode-map (kbd "C-c C-s") 'utop)
     ;; workaround for tuareg bug: https://forge.ocamlcore.org/tracker/index.php?func=detail&aid=1345&group_id=43&atid=255
     (setq tuareg-find-phrase-beginning-and-regexp
           "\\<\\(and\\)\\>\\|\\<\\(class\\|e\\(?:nd\\|xception\\)\\|let\\|module\\|s\\(?:ig\\|truct\\)\\|type\\)\\>\\|^#[ 	]*[a-z][_a-z]*\\>\\|;;")))

;;; er lang

(add-to-list 'ido-ignore-files ".beam")

(add-to-list 'load-path "/home/phil/src/erlmode/")
(autoload 'erlang-mode "erlmode-start" nil t)

(add-to-list 'auto-mode-alist '("\\.erl$" . erlang-mode))
(add-to-list 'auto-mode-alist '("^rebar.config$" . erlang-mode))

(add-hook 'erlang-mode-hook (lambda () (run-hooks 'prog-mode-hook)))
(add-hook 'erlang-mode-hook 'pnh-paredit-no-space)
(add-hook 'erlang-mode-hook 'paredit-mode)
(add-hook 'erlang-mode-hook (lambda ()
                              (idle-highlight-mode -1)))

(eval-after-load 'erlmode
  '(setq erlang-indent-level 4))

(eval-after-load 'erlang-mode
  '(progn
     (define-key erlang-mode-map "{" 'paredit-open-curly)
     (define-key erlang-mode-map "}" 'paredit-close-curly)
     (define-key erlang-mode-map "[" 'paredit-open-bracket)
     (define-key erlang-mode-map "]" 'paredit-close-bracket)
     (define-key erlang-mode-map (kbd "C-M-h") 'backward-kill-word)))

;; needs a lot of work
;; (add-hook 'erlang-mode-hook 'edts-mode)
;; (add-to-list 'load-path "/home/phil/src/edts")
;; (autoload 'edts-shell "edts-start" "erlang" t)
