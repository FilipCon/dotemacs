;;; -*- lexical-binding: t -*-

;; theme
(use-package doom-themes
  :custom
  (doom-one-comment-bg nil)
  (doom-themes-enable-bold t)    ; if nil, bold is universally disabled
  (doom-themes-enable-italic t) ; if nil, italics is universally disabled
  :init
  (load-theme 'doom-vibrant t) ;; load theme
  :config
  (doom-themes-visual-bell-config) ;; Enable flashing mode-line on errors
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))
