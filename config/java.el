;;; -*- lexical-binding: t -*-

;; lsp
(use-package lsp-java
  :hook (java-mode . lsp)
  :config
  (setq lsp-java-save-action-organize-imports nil))

;; android
(use-package android-mode)

;; groovy
(use-package groovy-mode
  :mode "\\.g\\(?:radle\\|roovy\\)$")
