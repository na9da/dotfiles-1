;; -*- lexical-binding: t -*-
(when (require 'exwm nil t)
  (require 'exwm-config)
  (exwm-config-default)

  (setq exwm-workspace-number 9)

  (require 'exwm-systemtray)
  (exwm-systemtray-enable)

  (add-hook 'exwm-manage-finish-hook
            (defun pnh-exwm-manage-hook ()
              (when (string= exwm-class-name "URxvt")
                ;; doesn't work
                (exwm-input-release-keyboard))
              (when (string-match "Firefox" exwm-class-name)
                (exwm-layout-hide-mode-line))))

  (exwm-enable-ido-workaround)

  (when window-system
    (global-set-key (kbd "C-x m")
                    (defun pnh-eshell-per-workspace ()
                      (interactive)
                      (let ((name (format "*eshell %s*"
                                          exwm-workspace-current-index)))
                        (if (get-buffer name)
                            (switch-to-buffer name)
                          (eshell t)
                          (rename-buffer name))))))

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
