;;; -*- lexical-binding: t -*-

;; language server
(use-package lsp-mode
  :hook ((c-mode c++-mode
          python-mode
          csharp-mode
          clojure-mode clojurec-mode clojurescript-mode
          sql-mode css-mode html-mode
          racket-mode
          latex-mode LaTeX-mode tex-mode yatex-mode bibtex-mode) . lsp)
  :bind-keymap ("C-c l" . lsp-command-map)
  :bind ("C-<return>" . lsp-execute-code-action)
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
              ("M-." . lsp-ui-peek-find-definitions)
              ("<f1>" . lsp-ui-doc-mode))
  :config
  (setq lsp-ui-doc-max-height 80
        lsp-ui-doc-max-width 100
        lsp-ui-doc-include-signature t
        lsp-ui-doc-show-with-mouse nil
        lsp-ui-doc-show-with-cursor t
        lsp-ui-sideline-ignore-duplicate t
        lsp-ui-sideline-show-code-actions nil))

;; lsp optimizations
(defun +lsp-init-optimizations-h ()
  (when (bound-and-true-p lsp-mode)
    (setq-local read-process-output-max (* 1024 1024))
    (setq-local gcmh-high-cons-threshold (* 2 (default-value 'gcmh-high-cons-threshold)))))
(add-hook 'lsp-mode-hook #'+lsp-init-optimizations-h)

;; ;; experimental
;; (use-package eglot
;;   :custom-face
;;   (eglot-highlight-symbol-face ((t (:inherit bold :background "DodgerBlue"))))
;;   (eglot-diagnostic-tag-unnecessary-face ((t (:inherit (flymake-warning shadow)))))
;;   :bind-keymap ("C-c l" . eglot-mode-map)
;;   :bind (("<f6>" . eglot))
;;   :bind (:map eglot-mode-map
;;               ("C-c l r" . eglot-rename)
;;               ("C-c l f" . eglot-format)
;;               ("C-<return>" . eglot-actions))
;;   :config
;;   (setq eglot-sync-connect 1
;;         eglot-stay-out-of '(eldoc)))
