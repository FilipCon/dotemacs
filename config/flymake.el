(use-package flymake
  :straight (:type built-in)
  :config
  (setq flymake-fringe-indicator-position 'right-fringe))

(use-package flycheck
  :init
  :custom (flycheck-indication-mode 'right-fringe))
