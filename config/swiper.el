;;; -*- lexical-binding: t -*-

(use-package ivy
  :config
  (setq ivy-display-style 'fancy
        ivy-count-format "" ; this is what you want
        ivy-initial-inputs-alist nil ; remove initial ^ input.
        ivy-extra-directories nil ; remove . and .. directory.)
        projectile-completion-system 'ivy
        ivy-use-virtual-buffers t)
  (setq ivy-re-builders-alist
      '((swiper . ivy--regex-plus) ;; use fuzzy completion except swiper
        ;; (t      . ivy--regex-fuzzy)
        (t . ivy--regex-ignore-order))))

(use-package ivy-prescient
  :hook ((ivy-mode . ivy-prescient-mode)
         (ivy-prescient-mode . prescient-persist-mode))
  :config
  (setq prescient-filter-method
        '(literal regexp initialis))
  (setq ivy-prescient-sort-commands
        '(not swiper swiper-isearch ivy-switch-buffer counsel-grep
              counsel-git-grep counsel-ag counsel-rg counsel-imenu
              counsel-yank-pop counsel-recentf counsel-buffer-or-recentf)
        ivy-prescient-retain-classic-highlighting t)
  (setq prescient-save-file (concat user-emacs-directory ".cache/prescient-save.el")))

;; remember last commands
(use-package amx
  :defer t
  :config
  (setq amx-save-file (concat user-emacs-directory ".cache/amx-items")))

(use-package swiper
  :after ivy
  :config
  (define-key ivy-mode-map (kbd "C-s") 'swiper))

(use-package counsel
  :after swiper
  :config
  (setq-default counsel-mode-override-describe-bindings t)
  :hook (after-init . counsel-mode))
