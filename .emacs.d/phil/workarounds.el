(setq compilation-scroll-output t ; byte-compilation fails w/o this
      ido-enable-tramp-completion nil
      vc-follow-symlinks t
      ruby-insert-encoding-magic-comment nil)

;; plz not to refresh log buffer when I cherry-pick, mkay?
(eval-after-load 'magit
  '(ignore-errors
     (define-key magit-log-mode-map (kbd "A")
       (lambda ()
         (interactive)
         (flet ((magit-need-refresh (f)))
           (magit-cherry-pick-item))))))

;; come on guys; autoloads are not rocket science
(add-to-list 'load-path "~/.emacs.d/elpa/color-theme-twilight-0.1")
(autoload 'color-theme-twilight "color-theme-twilight" nil t)

(autoload 'marmalade-upload-buffer "marmalade" nil t)

(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))

(autoload 'yaml-mode "yaml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(add-hook 'oddmuse-mode-hook
          (lambda ()
            (unless (string-match "question" oddmuse-post)
              (setq oddmuse-post (concat "uihnscuskc=1;" oddmuse-post)))))

(setq-default ispell-program-name "aspell")

;; can't figure out how to disable this on a per-document basis
(setq org-export-with-toc nil)
