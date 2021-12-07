;;; -*- lexical-binding: t -*-

;; language server
(use-package lsp-mode
  :hook ((c-mode c++-mode
          python-mode
          csharp-mode
          clojure-mode clojurec-mode clojurescript-mode
          sql-mode css-mode html-mode
          latex-mode LaTeX-mode tex-mode yatex-mode bibtex-mode) . lsp)
  :bind-keymap ("C-c l" . lsp-command-map)
  :bind (("C-<return>" . lsp-execute-code-action))
  :config
  (setq lsp-lens-enable nil
        lsp-sqls-workspace-config-path nil
        lsp-completion-provider :none
        lsp-enable-file-watchers nil
        lsp-enable-indentation nil
        lsp-headerline-breadcrumb-enable-diagnostics nil
        lsp-semantic-tokens-enable t))

;; lsp ui
(use-package lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :bind (:map lsp-mode-map
              ("M-," . lsp-ui-peek-find-references)
              ("M-." . lsp-ui-peek-find-definitions))
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-use-childframe t
        lsp-ui-doc-position 'top
        lsp-ui-doc-max-height 80
        lsp-ui-doc-include-signature t
        lsp-ui-sideline-ignore-duplicate t
        lsp-ui-flycheck-enable t
        lsp-ui-flycheck-list-position 'right
        lsp-ui-flycheck-live-reporting t
        lsp-ui-sideline-show-code-actions nil
        lsp-ui-peek-enable t
        lsp-ui-peek-list-width 60
        lsp-ui-peek-peek-height 25))

;; lsp optimizations
(defun +lsp-init-optimizations-h ()
  (when (bound-and-true-p lsp-mode)
    (setq-local read-process-output-max (* 1024 1024))
    (setq-local gcmh-high-cons-threshold (* 2 (default-value 'gcmh-high-cons-threshold)))))
(add-hook 'lsp-mode-hook #'+lsp-init-optimizations-h)
