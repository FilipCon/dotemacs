;;; -*- lexical-binding: t -*-

;; lsp for java
(use-package lsp-java
  :hook (java-mode . lsp)
  :config
  (setq lsp-java-save-action-organize-imports nil))
