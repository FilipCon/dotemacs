;;; -*- lexical-binding: t -*-

;; paredit but for all languages
(use-package smartparens
  :bind (("C-c r" . sp-rewrap-sexp)
         ("M-(" . sp-wrap-round)
         ("M-[" . sp-wrap-square)
         ("M-{" . sp-wrap-curly)
         ("M-\"" . sp-wrap-doublequote)
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
        sp-show-pair-delay 0
        sp-show-pair-from-inside t)
  (sp-use-paredit-bindings))

(defun sp-wrap-doublequote (&optional arg)
  (interactive "P")
  (sp-wrap-with-pair "\""))

;; rainbow-delimiters
(use-package rainbow-delimiters
  :config (rainbow-delimiters-mode t)
  :hook ((prog-mode
          markdown-mode
          text-mode
          conf-mode
          cider-repl-mode
          LaTeX-mode) . rainbow-delimiters-mode))
