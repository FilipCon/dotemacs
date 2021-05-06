;;; -*- lexical-binding: t -*-

(use-package smartparens
  :bind (("C-c r" . sp-rewrap-sexp)
         ("C-c u" . sp-unwrap-sexp)
         ("M-(" . sp-wrap-round)
         ("M-[" . sp-wrap-square)
         ("M-{" . sp-wrap-curly))
  :config
  (smartparens-global-mode 1)
  (show-smartparens-global-mode)
  (require 'smartparens-config)
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
