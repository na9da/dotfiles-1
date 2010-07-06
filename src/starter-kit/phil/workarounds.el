;;; broken ido
(defun ido-directory-too-big-p (arg) nil)

;; awesome sometimes, but right now more trouble than it's worth
(setq tramp-mode nil
      tramp-unload-hook nil
      ido-enable-tramp-completion nil)

(add-hook 'eshell-mode-hook
          '(lambda () (fmakunbound 'eshell/sudo)
             (fmakunbound 'eshell/su)))

;; plz not to refresh log buffer when I cherry-pick, mkay?
(eval-after-load 'magit
  '(ignore-errors (define-key magit-log-mode-map (kbd "A")
                    (lambda ()
                      (interactive)
                      (flet ((magit-need-refresh (f)))
                        (magit-cherry-pick-item))))))

;; temp. workaround for lexbind bug
(setq high '())

;; some terminal emulators get confused
;; (define-key paredit-mode-map (kbd "<deletechar>") 'paredit-backward-delete)
;; (define-key paredit-mode-map (kbd "M-<deletechar>") 'backward-kill-word)
