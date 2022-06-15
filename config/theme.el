;;; -*- lexical-binding: t -*-

;; Prot's themes
(use-package modus-themes
  :straight (:type built-in)
  :init
  (setq modus-themes-mode-line '(borderless)
        modus-themes-region '(bg-only)
        modus-themes-bold-constructs t
        modus-themes-italic-constructs t
        modus-themes-paren-match '(bold)
        modus-themes-syntax '(green-strings)
        modus-themes-subtle-line-numbers t
        modus-themes-headings '((t . (bold rainbow)))
        modus-themes-scale-headings t
        modus-themes-org-blocks 'gray-background)
  (load-theme 'modus-operandi t)
  :bind ("<f5>" . modus-themes-toggle))

;; hide minor modes in modeline
(use-package minions
  :config
  (minions-mode t))
