;;; -*- lexical-binding: t -*-

(use-package projectile
  ;; :defer t
  ;; :after ivy
  :config
  (setq projectile-completion-system 'ivy)
  :commands (projectile-project-root
             projectile-project-name
             projectile-project-p
             projectile-locate-dominating-file)
  :bind-keymap ("C-c p" . projectile-command-map)
  :init
  (setq projectile-globally-ignored-files '(".DS_Store" "Icon" "TAGS")
        projectile-globally-ignored-file-suffixes '(".elc" ".pyc" ".o")
        projectile-kill-buffers-filter 'kill-only-files
        projectile-ignored-projects '("~/" "/tmp"))
  :config (projectile-mode +1))

(use-package counsel-projectile
  :after (counsel projectile)
  :config
  (counsel-projectile-mode +1))
