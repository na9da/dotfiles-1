(eval-after-load 'ruby-mode
  '(add-hook 'ruby-mode-hook 'esk-paredit-nonlisp))

;; (eval-after-load 'swank-clojure
;;   '(add-to-list 'swank-clojure-extra-vm-args
;;                 "-agentlib:jdwp=transport=dt_socket,address=8021,server=y,suspend=n"))

(add-hook 'slime-repl-mode-hook 'turn-on-paredit)
(add-hook 'clojure-mode-hook 'turn-on-whitespace)

(setq inferior-lisp-program
      "java -cp /home/phil/src/clojure/clojure.jar clojure.main")

;; unfortunately some codebases use tabs. =(
(set-default 'tab-width 4)
(set-default 'c-basic-offset 2)

(add-hook 'xml-mode-hook 'run-coding-hook)
(add-hook 'java-mode-hook 'run-coding-hook)

(eval-after-load 'java-mode
  '(progn
     (define-key java-mode-map (kbd "C-M-h") 'backward-kill-word)))

(eval-after-load 'slime-repl
  '(progn (define-key slime-repl-mode-map "{" 'paredit-open-curly)
          (define-key slime-repl-mode-map "}" 'paredit-close-curly)))

(add-hook 'slime-repl-mode-hook (lambda ()
                                  (define-key slime-repl-mode-map
                                    (kbd "DEL") 'paredit-backward-delete)
                                  (modify-syntax-entry ?\{ "(}")
                                  (modify-syntax-entry ?\} "){")))

(add-to-list 'auto-mode-alist '("\\.duby$" . ruby-mode))

(setq slime-net-coding-system 'utf-8-unix)

(defun swank-clojure-dim-font-lock ()
  "Dim irrelevant lines in Clojure debugger buffers."
  (if (string-match "clojure" (buffer-name))
      (font-lock-add-keywords
       nil `((,(concat " [0-9]+: " (regexp-opt '("clojure.core"
                                                 "clojure.lang"
                                                 "swank." "java."))
                       ;; TODO: regexes ending in .* are ignored by
                       ;; font-lock; what gives?
                       "[a-zA-Z0-9\\._$]*")
              . font-lock-comment-face)) t)))

(add-hook 'sldb-mode-hook 'swank-clojure-dim-font-lock)

(setq slime-port 4005)

;; swank launchers

(defun slime-go (&optional port)
  (interactive)
  ;; use .dir-locals.el to set slime-port. Must be 4005 for maven.
  (slime-connect "localhost" (or port slime-port)))

(defun slime-start-filter (process output)
  (when (string-match "Connection opened on local port" output)
    (slime-connect "localhost" slime-port)
    (set-process-filter process nil)))

(defun lein-swank ()
  (interactive)
  (let ((root (locate-dominating-file default-directory "project.clj")))
    (when (not root)
      (error "Not in a Leiningen project."))
    ;; you can customize slime-port using .dir-locals.el
    (shell-command (format "cd %s && lein swank %s &" root slime-port)
                   "*lein-swank*")
    (set-process-filter (get-buffer-process "*lein-swank*")
                        (lambda (process output)
                          (when (string-match "Connection opened on" output)
                            (slime-connect "localhost" slime-port)
                            (set-process-filter process nil))))
    (message "Starting swank server...")))

(global-set-key (kbd "C-c C-s") 'slime-it-up)
(global-set-key (kbd "C-c C-l") 'lein-swank)
(global-set-key (kbd "C-c C-m") 'mvn-swank)

(setq slime-kill-without-query-p t)
(put 'slime-lisp-host 'safe-local-variable 'stringp)
(put 'slime-port 'safe-local-variable 'integerp)

(defun slime-auto-compile ()
  (when (and slime-mode (slime-connected-p) (slime-current-package))
    (slime-compile-and-load-file)))

(defun enable-auto-compile ()
  (make-local-variable 'after-save-hook)
  (add-hook 'after-save-hook 'slime-auto-compile))

;; auto-compile!
(add-hook 'clojure-mode-hook 'enable-auto-compile)
