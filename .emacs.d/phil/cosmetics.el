(defalias 'ff 'find-file)

(defun inconsolata (size)
  (interactive "p")
  (set-default-font
   (concat "-unknown-Inconsolata-normal-normal-normal-*-"
           (if (stringp size) size
             (if (= 1 size) "16"
               (read-from-minibuffer "Size: ")))
           "-*-*-*-m-0-*-*")))

(defun terminus (size)
  (interactive "p")
  (set-default-font
   (concat "-xos4-Terminus-normal-normal-normal-*-"
           (if (stringp size) size
             (if (= 1 size) "14"
               (read-from-minibuffer "Size: ")))
           "-*-*-*-c-80-iso10646-1")))

;; lose the stupid pipe chars on the split-screen bar
(set-face-foreground 'vertical-border "white")

(defun zb ()
  (interactive)
  (color-theme-zenburn)
  (set-face-background 'vertical-border "black")
  (set-face-foreground 'vertical-border "black")
  (set-face-foreground 'font-lock-keyword-face "#f0dfaf")
  (eval-after-load 'hl-line
    '(set-face-background 'hl-line "gray17"))
  (set-face-foreground 'eshell-prompt "turquoise"))

(defun tw ()
  (interactive)
  (color-theme-twilight)
  (set-face-background 'hl-line "black"))

(eval-after-load 'hl-line
  '(set-face-background 'hl-line "darkseagreen2"))
