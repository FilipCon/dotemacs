;;; -*- lexical-binding: t -*-

(use-package corfu
  :straight (corfu :files (:defaults "extensions/*")
                   :includes (corfu-info corfu-history))
  :hook (eshell-mode . (lambda () (setq-local corfu-quit-at-boundary t
                                              corfu-quit-no-match t)))
  :config
  (setq corfu-cycle t
        corfu-separator ?-
        corfu-preview-current nil
        ;; corfu-quit-at-boundary nil
        corfu-quit-no-match nil
        corfu-auto-prefix 1)
  :bind (:map corfu-map
              ("C-n" . corfu-next)
              ("C-p" . corfu-previous))
  :init
  (global-corfu-mode)
  (corfu-history-mode t))

;; cape extensions
(use-package cape
  :bind (("C-c p p" . completion-at-point)
         ("C-c p d" . cape-dabbrev)
         ("C-c p f" . cape-file)
         ("C-c p i" . cape-ispell)
         ("C-c p w" . cape-dict)))

;; margin icons
(use-package kind-icon
  :custom
  (kind-icon-default-face 'corfu-default) ; to compute blended backgrounds correctly
  :config
  (setq kind-icon-use-icons nil)
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))
