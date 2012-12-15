(add-hook 'prog-mode-hook
          (defun my-kill-word-key ()
            (local-set-key (kbd "C-M-h") 'backward-kill-word)))

(global-set-key (kbd "C-c C-j") 'nrepl-jack-in)

(global-set-key (kbd "C-c b")
                (lambda () (interactive)
                  (shell-command (format "rake post POST=%s"
                                         (car (split-string (buffer-name)
                                                            "\\."))))))

