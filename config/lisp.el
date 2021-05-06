;;; -*- lexical-binding: t -*-

(use-package cider
  ;; :straight (:host github :repo "FilipCon/cider" :branch "v0_24")
  :config
  (setq-default cider-completion-annotations-include-ns 'always
                cider-font-lock-dynamically t
                cider-repl-use-clojure-font-lock t
                nrepl-hide-special-buffers nil
                cider-show-error-buffer nil
                cider-auto-select-error-buffer nil
                cider-repl-pop-to-buffer-on-connect 'display-only
                cider-repl-display-help-banner nil
                cider-repl-use-pretty-printing t))

;; clojure
(use-package clojure-mode)

(use-package clj-refactor
  :hook (clojure-mode . clj-refactor-mode)
  :config
  (cljr-add-keybindings-with-prefix "C-r"))

;; (use-package clojure-snippets)

;; elisp
(use-package package-lint
  :bind ("C-c C-c" . eval-buffer))
