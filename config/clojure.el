;;; -*- lexical-binding: t -*-

;; cider
(use-package cider
  :hook (cider-mode . lsp)
  :config
  (set-company-backend! '(cider-repl-mode) '(company-capf company-yasnippet))
  (setq-default cider-auto-select-error-buffer nil
                cider-repl-display-help-banner nil
                nrepl-hide-special-buffers t
                cider-repl-pop-to-buffer-on-connect 'display-only)
  (unbind-key "M-," cider-mode-map))

;; clojure mode
(use-package clojure-mode)

;; refactor
(use-package clj-refactor
  :hook (clojure-mode . clj-refactor-mode)
  :config
  (cljr-add-keybindings-with-prefix "C-r"))

;; kondo
(use-package flycheck-clj-kondo)
