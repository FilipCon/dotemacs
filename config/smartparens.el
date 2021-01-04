;;; -*- lexical-binding: t -*-

(use-package smartparens
  :hook (after-init . smartparens-global-mode)
  :config
  (setq sp-highlight-pair-overlay nil
        sp-cancel-autoskip-on-backward-movement nil
        sp-show-pair-delay 0
        sp-show-pair-from-inside t
        sp-escape-quotes-after-insert nil
        sp-escape-wrapped-region nil
        sp-autoskip-closing-pair 'always)
  (sp-use-paredit-bindings))

;; rainbow-delimiters
(use-package rainbow-delimiters
  :init (rainbow-delimiters-mode t)
  :hook((prog-mode
         markdown-mode
         text-mode
         conf-mode
         cider-repl-mode
         LaTeX-mode) . rainbow-delimiters-mode))
