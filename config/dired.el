;;; -*- lexical-binding: t -*-

;; dired
(use-package dired
  :straight (:type built-in)
  :bind (:map dired-mode-map
              ("RET" . dired-find-alternate-file)
              ("C-c C-e" . wdired-change-to-wdired-mode)
              ("f" . dired-create-empty-file))
  :config
  (setq dired-listing-switches "-aBhl  --group-directories-first"
        dired-recursive-copies 'always
        dired-recursive-deletes 'top
        dired-auto-revert-buffer t
        dired-dwim-target t
        dired-create-destination-dirs 'ask))

;; dired /w all icons
(use-package all-the-icons-dired
  :after all-the-icons
  :config
  (advice-add 'dired-do-create-files :around #'all-the-icons-dired--refresh-advice)
  (advice-add 'dired-create-directory :around #'all-the-icons-dired--refresh-advice)
  :hook (dired-mode . all-the-icons-dired-mode))

;; pack/unpack zip files
(use-package dired-atool
  :config
  (define-key dired-mode-map "z" #'dired-atool-do-unpack)
  (define-key dired-mode-map "Z" #'dired-atool-do-pack))

;; oh! colors!
(use-package diredfl
  :hook (dired-mode . diredfl-mode))

;; (use-package dired-git-info)

;; (use-package dired-rsync
;;   :bind ("C-c C-r" . dired-rsync))
