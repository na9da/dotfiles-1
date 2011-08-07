;;; My general personalizations outside the starter kit

;; Random stuff

(require 'cl)

(setq-default save-place t)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "conkeror"
      marmalade-server "http://marmalade-repo.org/"
      custom-file (expand-file-name "~/.emacs.d/custom.el")
      ispell-extra-args '("--keyboard=dvorak"))

;; ad-hoc installations

(ignore-errors (load "~/src/lein/pcmpl-lein.el"))
(ignore-errors (load "~/src/safe/.elisp/sonian.el")) ; for work

(add-to-list 'load-path "/usr/share/emacs/site-lisp/ocaml-mode/")
(autoload 'run-caml "/usr/share/emacs/site-lisp/ocaml-mode/inf-caml.el" nil t)
(autoload 'caml-mode "/usr/share/emacs/site-lisp/ocaml-mode/caml.el" nil t)

(add-to-list 'load-path "~/src/elim/elisp")
(autoload 'garak "garak" nil t)
(setq garak-alert-methods '(:notify)
      garak-alert-when '(:new :hidden :chat))

;; Packages

(when (not (require 'package nil t))
  (load-file "/home/phil/.emacs.d/package-23.el"))

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

(package-initialize)

(when (require 'smex nil t)
  (global-set-key (kbd "M-x") 'smex)
  (smex-initialize))

(dolist (p '(clojure-mode slime slime-repl clojure-test-mode htmlize
                          scpaste paredit starter-kit starter-kit-lisp smex
                          idle-highlight-mode marmalade oddmuse scpaste))
  (when (not (package-installed-p p))
    (package-install p)))

(defvar ido-enable-replace-completing-read t)

;; ido *everywhere*
(defadvice completing-read (around use-ido-when-possible activate)
  (if (or (not ido-enable-replace-completing-read) ; Manual override disable ido
          (and (boundp 'ido-cur-list)
               ido-cur-list)) ; Avoid infinite loop from ido calling this
      ad-do-it
    (let ((allcomp (all-completions "" collection predicate)))
      (if allcomp
          (setq ad-return-value
                (ido-completing-read prompt allcomp
                                     nil require-match initial-input hist def))
        ad-do-it))))

(defalias 'guns 'gnus)

;; why not?
(eshell)
;; graaaaaaah! eshell doesn't respect eval-after-load for some reason:
(with-current-buffer "*eshell*" (setq pcomplete-cycle-completions nil))
