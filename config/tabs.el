;;; -*- lexical-binding: t -*-

;; centaur tabs
(use-package centaur-tabs
  :config
  (setq centaur-tabs-style "rounded"
        centaur-tabs-height 38
        centaur-tabs-set-icons t
        centaur-tabs-set-modified-marker t
        centaur-tabs-modified-marker "●"
        centaur-tabs-set-bar 'under
        x-underline-at-descent-line t
        centaur-tabs-gray-out-icons 'buffer
        uniquify-separator "/"
        uniquify-buffer-name-style 'forward)
  (centaur-tabs-headline-match)
  :hook ((term-mode
          calendar-mode
          org-agenda-mode
          helpful-mode
          help-mode
          fundamental-mode) . centaur-tabs-local-mode)
  :hook (after-init . centaur-tabs-mode)
  :bind
  ("C-M-[" . centaur-tabs-backward)
  ("C-M-]" . centaur-tabs-forward))
