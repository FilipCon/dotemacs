;;; -*- lexical-binding: t -*-

(use-package racket-mode
  :after lsp-mode
  :bind (:map racket-mode-map
              ("C-c M-j" . racket-run)
              ("C-c C-<SPC>" . racket-align))
  :config
  (require 'lsp-racket))
