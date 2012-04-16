;; lose the stupid pipe chars on the split-screen bar
(set-face-foreground 'vertical-border "white")
(set-face-background 'vertical-border "white")

(setq custom-safe-themes
      '("e94ef3be8297d28df3bd5b381bdc06c12a30fec07bfd3fe98a081688767b9774"
        "71923ce35940ee5f20d9fa19721d7677ce057f08" default))

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
  ;; lame; hasn't been ported to custom-themes yet
  (when (not (require 'color-theme nil t))
    (package-install 'color-theme))
  (color-theme-twilight)
  (set-face-background 'vertical-border "black")
  (set-face-foreground 'vertical-border "black")
  (require 'hl-line)
  (set-face-foreground 'eshell-prompt "turquoise1")
  (eval-after-load 'magit
    '(set-face-background 'magit-item-highlight "black"))
  (set-face-background 'hl-line "black"))

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
