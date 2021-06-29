;;; -*- lexical-binding: t -*-

;; centaur tabs
(use-package centaur-tabs
  :config
  (setq centaur-tabs-style "rounded"
        centaur-tabs-height 38
        centaur-tabs-set-icons t
        centaur-tabs-set-modified-marker t
        centaur-tabs-modified-marker "●"
        centaur-tabs-set-bar 'under)
  (setq x-underline-at-descent-line t)
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
  ("C-M-[" . centaur-tabs-backward)
  ("C-M-]" . centaur-tabs-forward))
