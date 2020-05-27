;;; -*- lexical-binding: t -*-

(use-package projectile
  :defer t
  :config
  (setq projectile-completion-system 'ivy)
  :bind-keymap ("C-c p" . projectile-command-map)
  :config (projectile-mode +1))

(use-package counsel-projectile
  :after (counsel projectile)
  :config
  (counsel-projectile-mode +1))
