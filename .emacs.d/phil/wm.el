;; -*- lexical-binding: t -*-
(when (and window-system (require 'exwm nil t))
  (require 'exwm-config)
  (exwm-config-default)

  (setq exwm-workspace-number 9
        exwm-workspace-show-all-buffers t
        exwm-layout-show-all-buffers t
        exwm-manage-force-tiling t)

  (require 'exwm-systemtray)
  (exwm-systemtray-enable)
  (display-time-mode 1)
  (display-battery-mode 1)
  (setq display-time-string-forms '((format-time-string "%H:%M " now)))

  ;; removed in newer versions
  (when (functionp 'exwm-enable-ido-workaround)
    (exwm-enable-ido-workaround))

  (dolist (k '(("s-l" "gnome-screensaver-command -l")
               ("s-v" "killall evrouter; evrouter /dev/input/*")
               ("s-s" "scrot")
               ("s-S-s" "scrot -s")
               ("s-<return>" "urxvt")
               ("S-<f7>" "music-random")
               ("<f7>" "music-choose")
               ("<f8>" "mpc toggle")
               ("<f10>" "mpc next")
               ("s-c" "urxvt -title home -e ssh -t code.technomancy.us tmux a")
               ("<XF86AudioLowerVolume>"
                "amixer sset Master 5%-")
               ("<XF86AudioRaiseVolume>"
                "amixer set Master unmute; amixer sset Master 5%+")))
    (let ((f (lambda () (interactive)
               (save-window-excursion
                 (start-process-shell-command (cadr k) nil (cadr k))))))
      (exwm-input-set-key (kbd (car k)) f)))
  ;; I'd rather switch with C-number instead of s-number, but char-mode buffers
  ;; don't let that thru =\
  (dotimes (i 10)
    (exwm-input-set-key (kbd (format "C-%s" i))
                        (lambda () (interactive)
                          (exwm-workspace-switch-create i))))

  (exwm-input-set-key (kbd "s-b") 'ido-switch-buffer)

  (defun pnh-run (command)
    (interactive (list (read-shell-command "$ ")))
    (start-process-shell-command command nil command))
  (define-key exwm-mode-map (kbd "C-x s-m") 'pnh-run)
  (global-set-key (kbd "C-x s-m") 'pnh-run)

  (exwm-input-set-simulation-keys
   (mapcar (lambda (c) (cons (kbd (car c)) (cdr c)))
           `(("C-b" . left)
             ("C-f" . right)
             ("C-p" . up)
             ("C-n" . down)
             ("C-a" . home)
             ("C-e" . end)
             ("M-v" . prior)
             ("C-v" . next)
             ("C-d" . delete)
             ("C-m" . return)
             ("C-RET" . return)
             ("C-i" . tab)
             ("C-g" . escape)
             ("C-s" . ?\C-f)
             ("C-M-s" . ?\C-g)
             ("C-y" . ?\C-v)
             ("M-w" . ?\C-c)
             ("M-<" . C-home)
             ("M->" . C-end)
             ("C-M-h" . C-backspace))))

  ;; xrandr --output HDMI-1 --same-as LVDS-1
  (require 'exwm-randr)
  ;; (exwm-randr--init)
  ;; (exwm-randr--refresh)
  ;; (setq exwm-randr-workspace-output-plist '(0 "HDMI-1"))
  (if (string= system-name "alto")
      (setq exwm-randr-workspace-output-plist '(1 "eDP-1" 2 "eDP-1" 3 "eDP-1"
                                                  4 "eDP-1" 5 "eDP-1" 6 "eDP-1"
                                                  7 "eDP-1" 8 "eDP-1" 9 "eDP-1"
                                                  0 "DP-1"))
    (let ((a "LVDS-1")
          (sec "HDMI-1"))
      (setq exwm-randr-workspace-output-plist `(1 ,sec 2 ,a 3 ,a
                                                  4 ,a 5 ,a
                                                  6 ,a 7 ,a
                                                  8 ,sec
                                                  9 ,a 0 ,a))))
  (exwm-randr-enable)

  (global-set-key (kbd "C-x m")
                  (defun pnh-eshell-per-workspace (n)
                    (interactive "p")
                    (eshell (+ (case n (4 10) (16 20) (64 30) (t 0))
                               exwm-workspace-current-index))))

  (server-start))
