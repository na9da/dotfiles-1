(ignore-errors
  (load "~/src/safe/.elisp/sonian-navigation.el")
  (global-set-key (kbd "C-c C-j") 'sonian-jump)
  (define-key clojure-mode-map (kbd "C-c C-t") 'sonian-swap))
