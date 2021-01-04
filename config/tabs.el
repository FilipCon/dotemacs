;;; -*- lexical-binding: t -*-

;; centaur tabs
(use-package centaur-tabs
  :config
  (setq centaur-tabs-style "bar"
        centaur-tabs-height 32
        centaur-tabs-set-icons t
        centaur-tabs-set-modified-marker t
        centaur-tabs-set-bar 'left)
  (centaur-tabs-headline-match)
  (setq centaur-tabs-gray-out-icons 'buffer
        uniquify-separator "/"
        uniquify-buffer-name-style 'forward)
  :hook
  (term-mode . centaur-tabs-local-mode)
  (calendar-mode . centaur-tabs-local-mode)
  (org-agenda-mode . centaur-tabs-local-mode)
  (helpful-mode . centaur-tabs-local-mode)
  (after-init . centaur-tabs-mode)
  :bind
  ("C-M--" . centaur-tabs-backward)
  ("C-M-=" . centaur-tabs-forward)
  ("C-c t p" . centaur-tabs-group-by-projectile-project))
