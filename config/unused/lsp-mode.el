

;; language server
(use-package lsp-mode
  :hook ((c-mode c++-mode
          python-mode
          csharp-mode
          clojure-mode clojurec-mode clojurescript-mode
          sql-mode css-mode html-mode
          racket-mode
          latex-mode LaTeX-mode tex-mode yatex-mode bibtex-mode) . lsp)
  :hook (lsp-completion-mode . my/lsp-mode-setup-completion)
  :bind-keymap ("C-c l" . lsp-command-map)
  :bind ("C-<return>" . lsp-execute-code-action)
  :init
  (defun my/lsp-mode-setup-completion ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
          '(flex))) ;; Configure flex
  :config
  (setq lsp-lens-enable nil
        lsp-sqls-workspace-config-path nil
        lsp-completion-provider :none
        lsp-enable-file-watchers nil
        lsp-enable-indentation nil
        lsp-enable-links nil
        lsp-enable-folding nil
        lsp-modeline-diagnostics-enable nil
        lsp-headerline-breadcrumb-enable nil
        ;; lsp-semantic-tokens-enable nil
        ))

;; lsp ui
(use-package lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :bind (:map lsp-mode-map
              ("M-," . lsp-ui-peek-find-references)
              ("M-." . lsp-ui-peek-find-definitions)
              ("<f1>" . lsp-ui-doc-mode))
  :config
  (setq lsp-ui-doc-max-height 80
        lsp-ui-doc-max-width 100
        lsp-ui-doc-include-signature t
        lsp-ui-doc-show-with-mouse nil
        lsp-ui-doc-show-with-cursor t
        lsp-ui-imenu-enable nil
        lsp-ui-sideline-ignore-duplicate t
        lsp-ui-sideline-show-code-actions nil))

;; lsp optimizations
(defun +lsp-init-optimizations-h ()
  (when (bound-and-true-p lsp-mode)
    (setq-local read-process-output-max (* 1024 1024))
    (setq-local gcmh-high-cons-threshold (* 2 (default-value 'gcmh-high-cons-threshold)))))
(add-hook 'lsp-mode-hook #'+lsp-init-optimizations-h)
