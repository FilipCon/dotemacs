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
  (smartparens-global-mode t)
  (show-smartparens-global-mode t)
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
  :hook ((prog-mode
          markdown-mode
          text-mode
          conf-mode
          cider-repl-mode
          LaTeX-mode) . rainbow-delimiters-mode))
