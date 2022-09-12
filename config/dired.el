;;; -*- lexical-binding: t -*-

;; dired
(use-package dired
  :straight (:type built-in)
  :bind (:map dired-mode-map
              ("RET" . dired-find-alternate-file)
              ("C-c C-e" . wdired-change-to-wdired-mode)
              ("f" . dired-create-empty-file))
  :config
  (setq dired-listing-switches "-AGFhlv --group-directories-first"
        dired-recursive-copies 'always
        dired-recursive-deletes 'always
        delete-by-moving-to-trash nil
        dired-auto-revert-buffer t
        dired-dwim-target t
        dired-create-destination-dirs 'ask))

;; pack/unpack zip files
(use-package dired-atool
  :config
  (define-key dired-mode-map "Z" #'dired-atool-do-unpack)
  (define-key dired-mode-map "z" #'dired-atool-do-pack))

;; awww! colors!
(use-package diredfl
  :hook (dired-mode . diredfl-mode))

;; (use-package dired-rsync
;;   :bind ("C-c C-r" . dired-rsync))
