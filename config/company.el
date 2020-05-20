;;; -*- lexical-binding: t -*-

;; company
(use-package company
  :commands company-complete-common company-manual-begin company-grab-line
  :init
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 1
        company-tooltip-limit 14
        company-dabbrev-e nil
        company-tooltip-align-annotations t
        company-eclim-auto-save nil       ; Stop eclim auto save.
        company-require-match 'never)
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

;; fuzzy auto complition
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

(use-package yasnippet
  :defer t
  :config
  ;; see https://emacs.stackexchange.com/a/30150/11934
  (defun cpm/yas-org-mode-hook ()
    (setq-local yas-buffer-local-condition
            '(not (org-in-src-block-p t))))
  (add-hook 'org-mode-hook #'cpm/yas-org-mode-hook)

  ;; snippet directory
  (setq yas-snippet-dirs '("~/.emacs.d/.local/snippets/cpm-snippets"
                           yasnippet-snippets-dir))
  ;; the official snippet collection https://github.com/AndreaCrotti/yasnippet-snippets
  (use-package yasnippet-snippets :after yasnippet :demand t)

  ;; Adding yasnippet support to company
  (with-eval-after-load 'company-mode
  (add-to-list 'company-backends '(company-yasnippet)))
  (yas-reload-all)
  (yas-global-mode 1))

(use-package yasnippet-snippets)
(use-package yasnippet-classic-snippets)
