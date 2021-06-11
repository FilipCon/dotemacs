;;; -*- lexical-binding: t -*-

;; company
(use-package company
  :config
  (global-company-mode)
  (add-hook 'company-mode-hook #'+company-init-backends-h)
  (setq company-backends '())
  (setq-default company-idle-delay 0
                company-minimum-prefix-length 1
                company-tooltip-align-annotations t
                company-require-match nil
                company-selection-wrap-around t
                company-dabbrev-downcase nil
                company-dabbrev-code-other-buffers nil
                company-dabbrev-other-buffers nil
                company-dabbrev-code-ignore-case t
                company-dabbrev-ignore-case t
                company-tooltip-idle-delay 0)
  :bind (:map company-active-map
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous)
          ([tab] . company-complete-selection)))

;; sort candidates
(use-package company-prescient
  :after (company prescient)
  :hook (company-mode . company-prescient-mode))

;; company box
(use-package company-box
  :after company all-the-icons
  :hook (company-mode . company-box-mode)
  :config
  (setq company-box-doc-delay 0
        company-box-backends-colors nil
        company-box-color-icon nil
        company-box-icons-alist 'company-box-icons-images))

;;snippets
(use-package yasnippet
  :config
  (yas-reload-all)
  (yas-global-mode))

(use-package yasnippet-snippets
  :after yasnippet)
