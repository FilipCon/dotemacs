;;; -*- lexical-binding: t -*-

;; company
(use-package company
  :commands company-complete-common company-manual-begin company-grab-line
  :init
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 1
        company-tooltip-limit 14
        company-dabbrev-e nil
        company-dabbrev-downcase nil
        company-tooltip-align-annotations t
        company-eclim-auto-save nil
        company-require-match nil
        company-search-regexp-function 'company-search-flex-regexp)
  (setq company-global-modes '(not erc-mode message-mode help-mode gud-mode eshell-mode)
        company-backends  '(company-capf)
        company-frontends '(company-pseudo-tooltip-frontend
                            company-echo-metadata-frontend))
  :bind (
         :map company-active-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous))
  :hook (after-init . global-company-mode)
  :config
;; Enable downcase only when completing the completion.
  (defun jcs--company-complete-selection--advice-around (fn)
    "Advice execute around `company-complete-selection' command."
    (let ((company-dabbrev-downcase t))
      (call-interactively fn)))
  (advice-add 'company-complete-selection :around #'jcs--company-complete-selection--advice-around))

;; fuzzy auto completion
(use-package company-fuzzy
  :init
  (setq company-fuzzy-sorting-backend 'fxl)
  (setq company-fuzzy-prefix-ontop nil)
  (with-eval-after-load 'company
    (global-company-fuzzy-mode t)))

;; quick tips
(use-package company-quickhelp
  :after company
  :init
  (company-quickhelp-mode t)
  (use-package pos-tip
    :commands (pos-tip-show)))

;; sort and filter completion candidates
(use-package company-prescient
  :after company
  :hook (company-mode . company-prescient-mode))

(if (not (eq system-type 'windows-nt))
    (use-package company-box
      :hook (company-mode . company-box-mode)
      :config
      (setq company-box-icons-alist 'company-box-icons-images)))
