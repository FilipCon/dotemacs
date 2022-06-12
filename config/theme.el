;;; -*- lexical-binding: t -*-

;; theme (also built in emacs)
(use-package modus-themes
  :init
  (setq modus-themes-mode-line '(borderless)
        modus-themes-region '(bg-only)
        modus-themes-bold-constructs t
        modus-themes-italic-constructs t
        modus-themes-paren-match '(bold intense)
        modus-themes-syntax '(green-strings)
        modus-themes-subtle-line-numbers t
        modus-themes-headings '((t . (bold rainbow)))
        modus-themes-scale-headings t
        modus-themes-org-blocks 'gray-background)
  (modus-themes-load-vivendi)
  :bind ("<f5>" . modus-themes-toggle))

;; hide minor modes in modeline
(use-package minions
  :config
  (minions-mode t))
