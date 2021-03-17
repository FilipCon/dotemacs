;;; -*- lexical-binding: t -*-

(use-package projectile
  :config
  :bind-keymap ("C-c p" . projectile-command-map)
  :custom ((projectile-completion-sythem 'selectrum))
  :init
  (setq projectile-globally-ignored-files '(".DS_Store" "Icon" "TAGS")
        projectile-globally-ignored-file-suffixes '(".elc" ".pyc" ".o")
        projectile-ignored-projects '("~/" "/tmp"))
  :config (projectile-mode 1))
