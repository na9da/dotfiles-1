(setenv "TERM" "dumb")

(eval-after-load 'em-term
  '(add-to-list 'eshell-visual-commands "ssh"))

(setq eshell-cmpl-cycle-completions nil)

(when (not (functionp 'eshell/rgrep))
  (defun eshell/rgrep (&rest args)
    "Use Emacs grep facility instead of calling external grep."
    (eshell-grep "rgrep" args t)))

(defun eshell/cdg ()
  "Change directory to the project's root."
  (eshell/cd (locate-dominating-file default-directory ".git")))

(defun eshell/browse (file)
  "Open file in browser"
  (browse-url-of-file file))

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

(defun eshell/dired-git (dir)
  (interactive "DUntracked in directory: ")
  (cd dir)
  (switch-to-buffer (get-buffer-create (format "*dired: %s*" dir)))
  (shell-command "git ls-files | xargs ls -l" (current-buffer))
  (dired-mode dir)
  (set (make-local-variable 'dired-subdir-alist)
       (list (cons default-directory (point-min-marker)))))
