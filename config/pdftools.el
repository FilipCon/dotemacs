;;; -*- lexical-binding: t -*-

(use-package pdf-tools
  :config
  (pdf-tools-install)
  ;; (add-to-list 'pdf-tools-enabled-modes 'pdf-view-midnight-minor-mode)
  ;; (setq pdf-view-midnight-colors '("#d6d6d6" . "#000000"))
  (defun ds/disable-cursor-blink () (blink-cursor-mode 0))
  (add-hook 'pdf-view-mode-hook 'ds/disable-cursor-blink))
