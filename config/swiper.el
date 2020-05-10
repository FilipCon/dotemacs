;;; -*- lexical-binding: t -*-

(use-package ivy
  :init
  (setq ivy-initial-inputs-alist nil)
  :custom
  (ivy-use-virtual-buffers t)
  :config
  (ivy-mode 1)
;;   (use-package ivy-hydra
;;     :defer t)
  (use-package flx))

(use-package swiper
  :after ivy
  :config (define-key ivy-mode-map (kbd "C-s") 'swiper))

(use-package counsel
  :after swiper
  :config
  (setq-default counsel-mode-override-describe-bindings t)
  (counsel-mode))
