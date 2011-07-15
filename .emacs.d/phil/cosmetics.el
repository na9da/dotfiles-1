(defalias 'zb 'color-theme-zenburn)
(defalias 'tw 'color-theme-twilight)
(defalias 'sl 'color-theme-solarized)

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

(defun fix-zb ()
  (interactive)
  (set-face-background 'vertical-border "black")
  (set-face-foreground 'vertical-border "black")
  (set-face-foreground 'font-lock-keyword-face "#f0dfaf")
  (set-face-foreground 'eshell-prompt "turquoise"))

(eval-after-load 'color-theme-zenburn
  '(fix-zb))

(eval-after-load 'hl-line
  '(set-face-background 'hl-line "darkseagreen2"))
