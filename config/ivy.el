;;; -*- lexical-binding: t -*-

;; ivy
(use-package ivy
  :config
  (setq ivy-display-style 'fancy
        ivy-count-format ""
        ivy-initial-inputs-alist nil
        ivy-extra-directories nil
        ivy-use-virtual-buffers t
        ivy-case-fold-search-default t)
  (require 'counsel nil t)
  (setq ivy-re-builders-alist
        '((swiper . ivy--regex-plus)
          (t . ivy--regex-ignore-order)))
  :hook (after-init . ivy-mode))

;; sort completions
(use-package ivy-prescient
  :hook ((ivy-mode . ivy-prescient-mode)
         (ivy-prescient-mode . prescient-persist-mode))
  :config
  (setq prescient-filter-method
        '(literal regexp initialis))
  (setq ivy-prescient-retain-classic-highlighting t)
  (setq prescient-save-file (concat user-emacs-directory ".cache/prescient-save.el")))

;; remember last commands
(use-package amx
  :defer t
  :config
  (setq amx-save-file (concat user-emacs-directory ".cache/amx-items")))

(use-package swiper
  :after ivy
  :config
  (define-key ivy-mode-map (kbd "C-s") 'swiper)
  (define-key ivy-mode-map (kbd "C-S-s") 'swiper-all)
  (define-key ivy-mode-map (kbd "C-M-s") 'swiper-thing-at-point)
  (define-key ivy-mode-map (kbd "C-M-S-s") 'swiper-all-thing-at-point))

(use-package counsel
  :after swiper
  :hook (ivy-mode . counsel-mode)
  :config
  (setq-default counsel-mode-override-describe-bindings t)
  (global-set-key (kbd "M-x") 'counsel-M-x))

(use-package flx)
