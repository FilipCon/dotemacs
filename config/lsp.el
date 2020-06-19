;; ;;; -*- lexical-binding: t -*-

;; language server
(use-package lsp-mode
  :hook ((python-mode
          c-mode-common
          clojure-mode
          latex-mode
          LaTeX-mode
          cmake-mode) . lsp)
         (lsp-mode . lsp-enable-which-key-integration)
  :config
  (advice-add #'lsp--auto-configure :override #'ignore)
  (setq lsp-print-performance t)
  (setq-default lsp-prefer-capf t
                ;; lsp-auto-guess-root t
                lsp-enable-semantic-highlighting t
                lsp-prefer-flymake nil
                lsp-restart 'auto-restart)
  (setq-default lsp-clients-clangd-args '("--compile-commands-dir=build"
                                          "--clang-tidy" "--suggest-missing-includes"
                                          "--all-scopes-completion=true"
                                          "-j=2" "--background-index" "--log=error")))

;; lsp ui
(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode)
  :bind (:map lsp-mode-map
              ("M-." . lsp-ui-peek-find-definitions)
              ("M-?" . lsp-ui-peek-find-references)
              ("C-c C-f" . lsp-format-buffer)
              ("C-c f" . lsp-format-region))
  :config
  (setq-default lsp-ui-doc-enable t
                lsp-ui-doc-use-childframe t
                lsp-ui-doc-position 'top
                lsp-ui-doc-include-signature t
                lsp-ui-sideline-ignore-duplicate t
                ;; lsp-ui-sideline-enable nil
                lsp-ui-flycheck-enable t
                lsp-ui-flycheck-list-position 'right
                lsp-ui-flycheck-live-reporting t
                lsp-ui-peek-enable t
                lsp-ui-peek-list-width 60
                lsp-ui-peek-peek-height 25))

;; ivy support
(use-package lsp-ivy
  :after lsp-mode ivy
  :commands lsp-ivy-workspace-symbol)

;; lsp-treemacs
(use-package lsp-treemacs
  :after lsp treemacs
  :config
  (lsp-treemacs-sync-mode 1))
