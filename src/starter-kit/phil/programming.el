(eval-after-load 'ruby-mode
  '(add-hook 'ruby-mode-hook 'esk-paredit-nonlisp))

;; (eval-after-load 'swank-clojure
;;   '(add-to-list 'swank-clojure-extra-vm-args
;;                 "-agentlib:jdwp=transport=dt_socket,address=8021,server=y,suspend=n"))

(add-hook 'clojure-mode-hook 'turn-on-whitespace)

(setq inferior-lisp-program
      "java -cp /home/phil/src/clojure/clojure.jar clojure.main")

;; unfortunately some codebases use tabs. =(
(set-default 'tab-width 4)
(set-default 'c-basic-offset 2)

(eval-after-load 'java-mode
  '(progn
     (define-key java-mode-map (kbd "C-M-h") 'backward-kill-word)))

(add-to-list 'auto-mode-alist '("\\.duby$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.mirah$" . ruby-mode))

(setq slime-net-coding-system 'utf-8-unix)

(add-to-list 'load-path "/home/phil/src/durendal")
(require 'durendal)

(durendal-enable)
(global-set-key (kbd "C-c C-j") 'durendal-jack-in)

(add-hook 'slime-repl-mode-hook 'clojure-mode-font-lock-setup)

(setq slime-kill-without-query-p t)
;; move to slime
(put 'slime-lisp-host 'safe-local-variable 'stringp)
(put 'slime-port 'safe-local-variable 'integerp)

(eval-after-load 'clojure-mode
  (font-lock-add-keywords 'clojure-mode
                          '(("\\<comp\\>"
                             (0
                              (progn (compose-region
                                      (match-beginning 0) (match-end 0)
                                      "∘")
                                     nil))))))
