;;; -*- lexical-binding: t -*-

(use-package paredit
  :config
  (paredit-mode -1))

(use-package smartparens
  :bind (("C-c r" . sp-rewrap-sexp)
         ("C-c u" . sp-unwrap-sexp)
         ("M-(" . sp-wrap-round)
         ("M-[" . sp-wrap-square)
         ("M-{" . sp-wrap-curly)
         ("M-\"" . paredit-meta-doublequote)
         ("C-0" . sp-forward-slurp-sexp)
         ("C-9" . sp-forward-barf-sexp)
         ("C-M-9" . sp-backward-slurp-sexp)
         ("C-M-0" . sp-backward-barf-sexp)
         ("C-M-<backspace>" . backward-kill-sexp)
         ("M-DEL" . sp-backward-kill-word)
         ("M-d" . sp-kill-word))
  :config
  (require 'smartparens-config)
  (smartparens-global-mode 1)
  (show-smartparens-global-mode 1)
  (setq-default sp-autoskip-closing-pair 'always)
  (setq sp-highlight-pair-overlay nil
        sp-cancel-autoskip-on-backward-movement nil
        sp-show-pair-delay 0
        sp-show-pair-from-inside t
        sp-escape-wrapped-region nil)
  (sp-use-paredit-bindings))

;; rainbow-delimiters
(use-package rainbow-delimiters
  :init (rainbow-delimiters-mode t)
  :hook ((prog-mode
          markdown-mode
          text-mode
          conf-mode
          cider-repl-mode
          LaTeX-mode) . rainbow-delimiters-mode))
