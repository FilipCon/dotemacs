;;; -*- lexical-binding: t -*-

(setq-default dired-dwim-target t)

;; Not spawn endless amount of dired buffers
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
  (define-key dired-mode-map (kbd "C-c C-e") 'wdired-change-to-wdired-mode)
  (define-key dired-mode-map (kbd "f") 'dired-create-empty-file)
  (setq dired-listing-switches "-aBhl  --group-directories-first")
  (setq dired-recursive-copies 'always
        dired-recursive-deletes 'top
        dired-auto-revert-buffer t
        dired-dwim-target t
        dired-create-destination-dirs 'ask))

(use-package all-the-icons-dired
  :after all-the-icons
  :config
  (advice-add 'dired-do-create-files :around #'all-the-icons-dired--refresh-advice)
  (advice-add 'dired-create-directory :around #'all-the-icons-dired--refresh-advice)
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-atool
  :config
  (define-key dired-mode-map "z" #'dired-atool-do-unpack)
  (define-key dired-mode-map "Z" #'dired-atool-do-pack))

(use-package diredfl
  :hook (dired-mode . diredfl-mode))

;; (use-package dired-git-info)

;; (use-package dired-rsync
;;   :bind ("C-c C-r" . dired-rsync))
