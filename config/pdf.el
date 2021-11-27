;;; -*- lexical-binding: t -*-

;; PDF tools
(use-package pdf-tools
  :straight t
  :init
  (pdf-tools-install)
  :config
  (defun ds/disable-cursor-blink () (blink-cursor-mode 0))
  (add-hook 'pdf-view-mode-hook 'ds/disable-cursor-blink)
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer))
