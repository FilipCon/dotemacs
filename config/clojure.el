;;; -*- lexical-binding: t -*-

;; clojure
(use-package cider
  :hook (cider-mode . lsp)
  :config
  (setq-default cider-completion-annotations-include-ns 'always
                cider-show-error-buffer t
                cider-auto-select-error-buffer nil
                cider-repl-display-help-banner nil

                nrepl-hide-special-buffers t
                nrepl-log-messages nil
                cider-font-lock-dynamically '(macro core function var deprecated)
                cider-overlays-use-font-lock t
                cider-prompt-for-symbol nil
                cider-repl-history-display-duplicates nil
                cider-repl-history-display-style 'one-line
                cider-repl-history-highlight-current-entry t
                cider-repl-history-quit-action 'delete-and-restore
                cider-repl-history-highlight-inserted-item t
                cider-repl-history-size 1000
                cider-repl-result-prefix ";; => "
                cider-repl-print-length 100
                cider-repl-use-clojure-font-lock t
                cider-repl-use-pretty-printing t
                cider-repl-wrap-history nil
                cider-repl-pop-to-buffer-on-connect 'display-only
                cider-stacktrace-default-filters '(tooling dup))
  (unbind-key "M-," cider-mode-map))

(use-package clojure-mode)

(use-package clj-refactor
  :hook (clojure-mode . clj-refactor-mode)
  :config
  (cljr-add-keybindings-with-prefix "C-r"))

(use-package flycheck-clj-kondo)

(use-package clojure-snippets)
