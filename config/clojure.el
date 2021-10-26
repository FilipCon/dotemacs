;;; -*- lexical-binding: t -*-

;; cider
(use-package cider
  :hook (cider-mode . (lambda ()
                        (remove-hook 'completion-at-point-functions
                                     #'cider-complete-at-point)))
  :config
  (set-company-backend! '(cider-repl-mode) '(company-capf company-yasnippet))
  (setq-default cider-auto-select-error-buffer nil
                cider-repl-display-help-banner nil
                nrepl-hide-special-buffers t
                cider-repl-pop-to-buffer-on-connect 'display-only
                cider-ns-refresh-show-log-buffer t
                cider-font-lock-dynamically nil ; use lsp semantic tokens
                cider-eldoc-display-for-symbol-at-point nil)
  (unbind-key "M-," cider-mode-map)
  (unbind-key "M-." cider-mode-map))

;; clojure mode
(use-package clojure-mode
  ;; :custom (fill-column 80)
  :config
  :bind ("C-c C-<SPC>" . clojure-align))
