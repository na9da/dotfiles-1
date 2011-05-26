;;; broken ido
(defun ido-directory-too-big-p (arg) nil)

;; awesome sometimes, but right now more trouble than it's worth
(setq tramp-mode nil
      tramp-unload-hook nil
      compilation-scroll-output t ; byte-compilation fails w/o this
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

;; some terminal emulators get confused
;; (define-key paredit-mode-map (kbd "<deletechar>") 'paredit-backward-delete)
;; (define-key paredit-mode-map (kbd "M-<deletechar>") 'backward-kill-word)

;; current lein master isn't giving any output on swank launch
(setq clojure-swank-command "cd %s && lein-1.5.2 jack-in %s &")
