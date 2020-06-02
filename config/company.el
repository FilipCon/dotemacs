;;; -*- lexical-binding: t -*-

;; company
(use-package company
  :init
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 1
        company-tooltip-limit 14
        company-dabbrev-downcase nil
        company-tooltip-align-annotations t
        company-require-match nil
        company-dabbrev-code-ignore-case t
        company-dabbrev-ignore-case t
        company-etags-ignore-case t
        company-global-modes
        '(not erc-mode message-mode help-mode gud-mode eshell-mode))
  :bind (
         :map company-active-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous)
         ([tab] . company-complete-selection))
  :hook (after-init . global-company-mode))

;; fuzzy auto completion
(use-package company-fuzzy
  :after company
  :init
  (setq company-fuzzy-prefix-ontop nil)
  (with-eval-after-load 'company
    (global-company-fuzzy-mode t)))

;; quick tips
(use-package company-quickhelp
  :after company
  :config
  (company-quickhelp-mode t)
  (use-package pos-tip
    :commands (pos-tip-show)))

;; sort and filter completion candidates
(use-package company-prescient
  :after company
  :hook (company-mode . company-prescient-mode))

;; for icons
(use-package company-box
  :after company
  :hook (company-mode . company-box-mode)
  :config
  (setq company-box-icons-alist 'company-box-icons-images))
