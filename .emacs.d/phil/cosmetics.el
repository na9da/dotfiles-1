;; lose the stupid pipe chars on the split-screen bar
(set-face-foreground 'vertical-border "white")
(set-face-background 'vertical-border "white")

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
  (load-theme 'twilight)
  (set-face-background 'vertical-border "black")
  (set-face-foreground 'vertical-border "black")
  (require 'hl-line)
  (set-face-foreground 'eshell-prompt "turquoise1")
  (eval-after-load 'magit
    '(set-face-background 'magit-item-highlight "black"))
  (set-face-background 'hl-line "black"))

(defun mk ()
  (interactive)
  (load-theme 'monokai)
  (set-face-background 'vertical-border "black")
  (set-face-foreground 'vertical-border "black")
  (require 'hl-line)
  (set-face-foreground 'eshell-prompt "turquoise1")
  (eval-after-load 'magit
    '(set-face-background 'magit-item-highlight "black")))

(defun bb ()
  "Black for use with glasstty in -nw"
  (interactive)
  (set-face-background 'vertical-border "bright green")
  (set-face-foreground 'vertical-border "bright green")
  (set-face-background 'hl-line "black")
  (eval-after-load 'magit
    '(set-face-background 'magit-item-highlight "black")))

(eval-after-load 'hl-line
  '(set-face-background 'hl-line "darkseagreen2"))

;; TODO: port to dabbrevs
(defun disapproval () (interactive) (insert "ಠ_ಠ"))
(defun eyeroll () (interactive) (insert "◔_◔"))
(defun tables () (interactive) (insert "（╯°□°）╯︵ ┻━┻"))
(defun mu () (interactive) (insert "無"))
