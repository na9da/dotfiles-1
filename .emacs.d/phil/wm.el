;; -*- lexical-binding: t -*-
(when (require 'exwm nil t)
  (require 'exwm-config)
  (exwm-config-default)

  (setq exwm-workspace-number 9)

  (require 'exwm-systemtray)
  (exwm-systemtray-enable)

  (add-hook 'exwm-manage-finish-hook
            (defun pnh-exwm-manage-hook ()
              (when (or (string= exwm-class-name "URxvt")
                        (string= exwm-class-name "love"))
                (exwm-input-release-keyboard))
              (when (string-match "Firefox" exwm-class-name)
                (exwm-layout-hide-mode-line))))

  (exwm-enable-ido-workaround)

  (dolist (k '(("s-l" "gnome-screensaver-command -l")
               ("s-v" "killall evrouter; evrouter /dev/input/*")
               ("s-s" "scrot")
               ("s-S-s" "scrot -s")
               ("<f7>" "music-choose")
               ("S-<f7>" "music-random")
               ("<f8>" "mpc toggle")
               ("<f10>" "mpc next")
               ("<XF86AudioLowerVolume>" "amixer sset Master 5%-")
               ("<XF86AudioRaiseVolume>" "amixer sset Master 5%+")))
    (global-set-key (kbd (car k)) (lambda () (interactive)
                                    (save-window-excursion
                                      (shell-command (concat (cadr k) " &"))))))

  (when window-system
    (global-set-key (kbd "C-x m")
                    (defun pnh-eshell-per-workspace (n)
                      (interactive "p")
                      (eshell (+ (case n (4 10) (16 20) (64 30) (t 0))
                                 exwm-workspace-current-index))))
    (server-start))

  ;; todo:

  ;; * switch to char-mode in urxvt

  ;; (require 'exwm-randr)
  ;; (setq exwm-randr-workspace-output-plist '(0 "VGA1"))
  ;; (add-hook 'exwm-randr-screen-change-hook
  ;;           (lambda ()
  ;;             (start-process-shell-command
  ;;              "xrandr" nil "xrandr --output VGA1 --left-of LVDS1 --auto")))
  ;; (exwm-randr-enable)

  ;; cheat sheet:
  ;; * C-c C-k: switch to char-mode
  ;; * C-c C-q: send next key literally
  ;; * C-c C-t C-f: toggle floating
  ;; * C-c C-t C-m: toggle modeline

  ;; * C-x ^: enlarge window vertically
  ;; * C-x }: enlarge window horizontally

  ;; * s-r: reset all
  )
