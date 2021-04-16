;;; -*- lexical-binding: t -*-

;; language server
(use-package lsp-mode
  :hook ((
          ;; python-mode
          c-mode
          c++-mode
          csharp-mode
          clojure-mode
          clojurec-mode
          latex-mode
          LaTeX-mode
          tex-mode
          yatex-mode
          bibtex-mode) . lsp)
  :hook
  (lsp-mode . (lambda ()
                       (let ((lsp-keymap-prefix "C-c l"))
                         (lsp-enable-which-key-integration))))
  :config
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
  (setq lsp-completion-provider :none
        lsp-enable-indentation nil)
  (setq lsp-enable-file-watchers nil)
  (setq lsp-headerline-breadcrumb-enable-diagnostics nil)
  (setq-default lsp-enable-semantic-highlighting t
                lsp-prefer-flymake nil
                lsp-restart 'auto-restart
                lsp-pyls-plugins-yapf-enabled t
                lsp-pyls-plugins-autopep8-enabled nil)
  (global-set-key (kbd "C-<return>") 'lsp-execute-code-action)
  (setq-default lsp-clients-clangd-args '("--compile-commands-dir=build"
                                          "--clang-tidy" "--suggest-missing-includes"
                                          "--header-insertion=never"
                                          "--all-scopes-completion=true"
                                          "-j=2" "--background-index" "--log=error")))

;; lsp ui
(use-package lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :bind (:map lsp-mode-map
              ("M-." . lsp-ui-peek-find-definitions)
              ("M-," . lsp-ui-peek-find-references)
              ("C-c l f f". lsp-format-buffer)
              ("C-c l f r". lsp-format-region))
  :config
  (setq-default lsp-ui-doc-enable t
                lsp-ui-doc-use-childframe t
                lsp-ui-doc-position 'top
                lsp-ui-doc-include-signature t
                lsp-ui-sideline-ignore-duplicate t
                lsp-ui-flycheck-enable t
                lsp-ui-flycheck-list-position 'right
                lsp-ui-flycheck-live-reporting t
                lsp-ui-peek-enable t
                lsp-ui-peek-list-width 60
                lsp-ui-peek-peek-height 25))

;; lsp-treemacs
(use-package lsp-treemacs
  :after lsp treemacs
  :hook (lsp-mode . lsp-treemacs-sync-mode))

(use-package tree-sitter
  :config
  (global-tree-sitter-mode 1)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs)
