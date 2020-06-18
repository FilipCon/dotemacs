;;; -*- lexical-binding: t -*-

(use-package smartparens
  :hook (after-init . smartparens-global-mode)
  :config
  (require 'smartparens-config)
  (setq sp-highlight-pair-overlay nil
      sp-cancel-autoskip-on-backward-movement nil
      sp-show-pair-delay 0
      sp-show-pair-from-inside t
      sp-escape-quotes-after-insert nil
      sp-escape-wrapped-region nil
      sp-base-key-bindings 'paredit
      sp-autoskip-closing-pair 'always
      sp-hybrid-kill-entire-symbol nil)
      (sp-use-paredit-bindings))

;; rainbow-delimiters
(use-package rainbow-delimiters
  :init (rainbow-delimiters-mode t)
  :hook((prog-mode
         markdown-mode
         text-mode
         conf-mode
         LaTeX-mode) . rainbow-delimiters-mode))
