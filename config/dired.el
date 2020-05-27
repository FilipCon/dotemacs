;;; -*- lexical-binding: t -*-

(setq dired-dwim-target t)

;; Not spawn endless amount of dired buffers
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

(use-package all-the-icons-dired
  :after all-the-icons
  :hook (dired-mode . all-the-icons-dired-mode))
