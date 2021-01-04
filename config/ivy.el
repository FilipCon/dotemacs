;;; -*- lexical-binding: t -*-

;; ivy
(use-package ivy
  :bind
  ("C-r" . 'ivy-resume)
  :config
  (setq ivy-display-style 'fancy
        ivy-extra-directories nil
        ivy-use-virtual-buffers t
        ivy-wrap t)
  :hook (after-init . ivy-mode))

(use-package ivy-rich
  :after ivy
  :custom
  (ivy-virtual-abbreviate 'full)
  (ivy-rich-switch-buffer-align-virtual-buffer nil)
  (ivy-rich-path-style 'full)
  :config
  (ivy-rich-mode))

;; sort completions
(use-package ivy-prescient
  :after (ivy prescient)
  :config (setq ivy-prescient-retain-classic-highlighting t)
  :hook ((ivy-mode . ivy-prescient-mode)
         (ivy-prescient-mode . prescient-persist-mode)))

;; search tool
(use-package swiper
  :after ivy
  :config
  (define-key ivy-mode-map (kbd "C-s") 'swiper)
  (define-key ivy-mode-map (kbd "C-M-s") 'swiper-thing-at-point))

(use-package counsel
  :hook (ivy-mode . counsel-mode)
  :config
  (global-set-key (kbd "M-x") 'counsel-M-x))
