
(use-package octave
  :mode ("\\.m\\'" . octave-mode)
  :custom ((octave-auto-indent t)
           (octave-auto-newline t)
           (octave-blink-matching-block t)
           (octave-block-offset 2)
           (octave-continuation-offset 4)
           (octave-continuation-string "...")
           (octave-send-echo-input t)
           (octave-send-show-buffer t))
  :config
  (define-key octave-mode-map (kbd "C-c C-d") 'octave-help)
  (define-key inferior-octave-mode-map (kbd "C-c C-d") 'octave-help))

;; (setq auto-mode-alist
;;       (cons '("\\.m$" . octave-mode) auto-mode-alist))

;; (add-hook 'octave-mode-hook
;;           (lambda ()
;;             (abbrev-mode 1)
;;             (auto-fill-mode 1)
;;             (if (eq window-system 'x)
;;                 (font-lock-mode 1))))
