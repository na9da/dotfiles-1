(setq compilation-scroll-output t ; byte-compilation fails w/o this
      ido-enable-tramp-completion nil
      vc-follow-symlinks t
      tags-revert-without-query t ; why would you ever not want this?
      ruby-insert-encoding-magic-comment nil)

;; plz not to refresh log buffer when I cherry-pick, mkay?
(eval-after-load 'magit
  '(ignore-errors
     (setq magit-diff-refine-hunk t)
     (define-key magit-log-mode-map (kbd "A")
       (lambda ()
         (interactive)
         (flet ((magit-need-refresh (f)))
           (magit-cherry-pick-item))))))

;; come on guys; autoloads are not rocket science
(autoload 'marmalade-upload-buffer "marmalade" nil t)

(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(require 'parenface-plus)

(autoload 'yaml-mode "yaml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(add-hook 'oddmuse-mode-hook
          (lambda ()
            (unless (string-match "question" oddmuse-post)
              (setq oddmuse-post (concat "uihnscuskc=1;" oddmuse-post)))))

(setq-default ispell-program-name "aspell")

;; doesn't have a way to store credentials safely yet
(eval-after-load 'gh-auth
  '(when (not (featurep 'chorts))
     (load-file "~/.chorts/chorts.el.gpg")))

(defun leathekd-suck-it (suckee)
  "Insert a comment of appropriate length about what can suck it."
  (interactive "MWhat can suck it? ")
  (let ((prefix (concat ";; " suckee " can s"))
        (postfix "ck it!")
        (col (current-column)))
    (insert prefix)
    (dotimes (_ (- 80 col (length prefix) (length postfix))) (insert "u"))
    (insert postfix)))

;; starter kit version has stupid formatting
(defun pnh-insert-date ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d %H:%M:%S" (current-time))))

;; cl.el byte compiler warnings can suuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuck it!
(defalias 'byte-compile-cl-warn 'identity)

(setenv "GHI_NO_COLOR" "y")
