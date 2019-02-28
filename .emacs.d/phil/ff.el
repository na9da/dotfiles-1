;;; -*- lexical-binding: t -*-
(when (and window-system (require 'exwm nil t))

  (dolist (s '(("s-i" "https://pinafore.social")
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

  (exwm-input-set-key (kbd "s-e") 'eww))
