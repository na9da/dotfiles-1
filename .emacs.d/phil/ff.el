;;; -*- lexical-binding: t -*-
(when (and window-system (require 'exwm nil t))

  ;; an ido-make-buffer-list-hook to make C-x b only show browser buffers
  (defun pnh-trim-non-ff ()
    (delete-if-not (lambda (name)
                     (string-match "- Mozilla Firefox$" name))
                   ido-temp-list))

  (add-hook 'exwm-update-title-hook
            (defun pnh-ff-title-hook ()
              (when (string-match "Firefox" exwm-class-name)
                (exwm-workspace-rename-buffer exwm-title))))

  (dolist (s '(("s-i" "https://icosahedron.website")
               ("s-d" "https://duckduckgo.com/html?q=%s" "Search: ")
               ("s-g" "https://google.com/search?q=%s" "Search: ")
               ("s-c" "https://circleci.com/gh/%s/%s" "User: " "Repo: ")
               ("s-w" "https://en.wikipedia.org/w/index.php?search=%s"
                "Wikipedia: ")
               ("s-b" "https://lobste.rs")
               ("s-n" "%s" "URL: ")))
    (exwm-input-set-key (kbd (car s))
                        (lambda () (interactive)
                          (browse-url (apply 'format (cadr s)
                                             (mapcar 'read-string (cddr s)))))))

  (exwm-input-set-key (kbd "s-e") 'eww)

  (setq browse-url-firefox-arguments '("-new-window")))
