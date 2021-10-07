;;; -*- lexical-binding: t -*-

;; theme
(use-package doom-themes
  :config
  (load-theme 'doom-solarized-light t)
  ;; (load-theme 'doom-vibrant t)

  (doom-themes-visual-bell-config) ;; Enable flashing mode-line on errors
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))
