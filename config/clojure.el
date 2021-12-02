;;; -*- lexical-binding: t -*-

;; cider
(use-package cider
  :bind (:map cider-mode-map ("C-c ." . cider-find-var))
  :mode (("\\.edn$" . clojure-mode)
         ("\\.repl$" . clojure-mode)
         ("\\.bb$" . clojure-mode))
  :hook (cider-mode . (lambda ()
                        (remove-hook 'completion-at-point-functions
                                     #'cider-complete-at-point)))
  :config
  (set-company-backend! '(cider-repl-mode) '(company-capf company-yasnippet))
  (setq cider-auto-select-error-buffer nil
        cider-repl-display-help-banner nil
        nrepl-hide-special-buffers t
        cider-repl-pop-to-buffer-on-connect 'display-only
        cider-ns-refresh-show-log-buffer t
        cider-use-fringe-indicators nil
        cider-font-lock-dynamically nil ; use lsp semantic tokens
        cider-eldoc-display-for-symbol-at-point nil))

;; clojure mode
(use-package clojure-mode
  :config
  ;; (setq clojure-align-reader-conditionals t)
  ;; (setq clojure-indent-style 'align-arguments) ; align function arguments
  (setq clojure-align-forms-automatically t) ; align s-expressions
  :bind ("C-c C-<SPC>" . clojure-align))
