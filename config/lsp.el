;;; -*- lexical-binding: t -*-

(use-package lsp-mode
  :after flycheck company
  :hook ((python-mode . lsp)
         (c-mode-common . lsp)
         (csharp-mode . lsp)
         (clojure-mode . lsp)
         (latex-mode . lsp)
         (cmake-mode lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :config
  ;; prefer using lsp-ui (flycheck)
  (setq lsp-prefer-flymake nil)
  ;; setup clangd
  (setq lsp-clients-clangd-args '("-j=2" "-background-index" "-log=error")))

;; lsp extras
(use-package lsp-ui
  :after lsp-mode flycheck
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  ;; setup lsp-ui
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-use-childframe t
        lsp-ui-doc-position 'top
        lsp-ui-doc-include-signature t
        lsp-ui-sideline-enable nil
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

;; company support
(use-package company-lsp
  :after company lsp
  :commands company-lsp
  :config
  (push 'company-lsp company-backends)
  ;; disable client-side cache because the LSP server does a better job.
  (setq company-transformers nil
        company-lsp-async t
        company-lsp-cache-candidates nil))
