;; github emojis
(use-package emojify)

(use-package vundo
  :straight (:host github :repo "casouri/vundo")
  :bind (:map vundo-mode-map
              ("C-f" . vundo-forward)
              ("C-b" . vundo-backward)
              ("C-n" . vundo-next)
              ("C-p" . vundo-previous)
              ("C-a" . vundo-stem-root)
              ("C-e" . vundo-stem-end)))
