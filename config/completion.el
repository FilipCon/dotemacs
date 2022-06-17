;;; -*- lexical-binding: t -*-

(use-package corfu
  :straight (corfu :files (:defaults "extensions/*")
                   :includes (corfu-info corfu-history))
  :custom
  (corfu-cycle t)
  ;; (corfu-quit-no-match nil)
  (corfu-quit-at-boundary nil)
  (corfu-auto-prefix 1)
  :bind ("M-RET" . completion-at-point)
  :bind (:map corfu-map
              ("C-n" . corfu-next)
              ("C-p" . corfu-previous))
  :init
  (global-corfu-mode)
  (corfu-history-mode t))

;; cape extensions
(use-package cape
  :bind (("C-c p d" . cape-dabbrev)
         ("C-c p f" . cape-file)
         ("C-c p i" . cape-ispell)
         ("C-c p l" . cape-line)
         ("C-c p w" . cape-dict)))

;; icons
(use-package kind-icon
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))
