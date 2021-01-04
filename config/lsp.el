;;; -*- lexical-binding: t -*-

;; language server
(use-package lsp-mode
  :hook ((python-mode
          c-mode
          c++-mode
          csharp-mode
          clojure-mode
          clojurec-mode
          clojurescript-mode
          sh-mode
          nxml-mode
          latex-mode
          LaTeX-mode
          cmake-mode) . lsp)
  (lsp-mode . lsp-enable-which-key-integration)
  :config
  (setq lsp-print-performance t)
  (setq-default lsp-prefer-capf -1
                lsp-xml-jar-file (expand-file-name ".cache/lsp/lemminx/org.eclipse.lemminx/target/org.eclipse.lemminx-uber.jar"
                                  user-emacs-directory)
                lsp-enable-semantic-highlighting t
                lsp-prefer-flymake nil
                lsp-restart 'auto-restart)
  (global-set-key (kbd "C-<return>") 'lsp-execute-code-action)
  (dolist (m '(clojure-mode
               clojurec-mode
               clojurescript-mode
               clojurex-mode))
    (add-to-list 'lsp-language-id-configuration `(,m . "clojure")))
  (setq lsp-enable-indentation nil)
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
              ("C-c C-r" . lsp-format-region))
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
