;; lose the stupid pipe chars on the split-screen bar
(set-face-foreground 'vertical-border "white")
(set-face-background 'vertical-border "white")

(setq custom-safe-themes '("71923ce35940ee5f20d9fa19721d7677ce057f08" default))

(defun zb ()
  (interactive)
  (load-theme 'zenburn)
  (set-face-background 'vertical-border "black")
  (set-face-foreground 'vertical-border "black")
  (require 'hl-line)
  (set-face-background 'hl-line "gray17")
  (eval-after-load 'magit
    '(set-face-background 'magit-item-highlight "black"))
  (set-face-foreground 'eshell-prompt "turquoise"))

(defun tw ()
  (interactive)
  (color-theme-twilight)
  (set-face-background 'vertical-border "black")
  (set-face-foreground 'vertical-border "black")
  (require 'hl-line)
  (set-face-foreground 'eshell-prompt "turquoise1")
  (eval-after-load 'magit
    '(set-face-background 'magit-item-highlight "black"))
  (set-face-background 'hl-line "black"))

(eval-after-load 'hl-line
  '(set-face-background 'hl-line "darkseagreen2"))

(defun disapproval () (interactive) (insert "ಠ_ಠ"))
