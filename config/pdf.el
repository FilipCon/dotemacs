;;; -*- lexical-binding: t -*-

;; PDF tools
(use-package pdf-tools
  :straight t
  :init
  (pdf-tools-install)
  :config
  (add-hook 'pdf-view-mode-hook (lambda () (blink-cursor-mode 0)))
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer))
