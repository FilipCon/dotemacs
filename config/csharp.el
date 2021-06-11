;;; -*- lexical-binding: t -*-

(use-package csharp-mode)

(use-package omnisharp
  :config
  (push 'csharp-omnisharp-codecheck flycheck-checkers)
  (set-company-backend! 'csharp-mode
    '(company-omnisharp company-capf company-yasnippet)))
