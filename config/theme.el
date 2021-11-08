;;; -*- lexical-binding: t -*-

;; theme
(use-package doom-themes
  :config
  (doom-themes-visual-bell-config)      ; Enable flashing mode-line on errors
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; switch between dark & light themes
(use-package heaven-and-hell
  :config
  (setq heaven-and-hell-theme-type 'light)
  (setq heaven-and-hell-themes '((light . doom-solarized-light)
                                 (dark . doom-vibrant)))
  (setq heaven-and-hell-load-theme-no-confirm t)
  :hook (after-init . heaven-and-hell-init-hook)
  :bind ("<f6>" . heaven-and-hell-toggle-theme))
