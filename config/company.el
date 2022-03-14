;;; -*- lexical-binding: t -*-

;; company
(use-package company
  :hook (company-mode . +company-init-backends-h)
  :config
  (global-company-mode)
  (setq company-backends '()
        company-idle-delay 0
        company-minimum-prefix-length 1
        company-tooltip-idle-delay 0
        company-tooltip-align-annotations t
        company-require-match nil
        company-selection-wrap-around t
        company-dabbrev-code-other-buffers nil
        company-dabbrev-other-buffers nil
        company-dabbrev-code-ignore-case nil
        company-dabbrev-ignore-case nil
        company-dabbrev-downcase nil)
  :bind (:map company-active-map
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous)
          ([tab] . company-complete-selection)))

;; sort candidates
(use-package prescient
  :config
  (prescient-persist-mode 1)
  (setq prescient-save-file
        (concat user-emacs-directory ".cache/prescient-save.el")))

(use-package company-prescient
  :after (company prescient)
  :hook (company-mode . company-prescient-mode))

;; company box
(use-package company-box
  :after (company all-the-icons)
  :hook (company-mode . company-box-mode)
  :config
  (setq x-gtk-resize-child-frames 'resize-mode
        company-box-doc-delay 0
        company-box-backends-colors nil))

;;snippets
(use-package yasnippet
  :config
  (setq yas-verbosity 0)
  (yas-global-mode))

(use-package yasnippet-snippets
  :after yasnippet)
