;;; -*- lexical-binding: t -*-

(use-package lsp-mode
  :after flycheck
  :commands lsp
  :hook ((python-mode . lsp)
         (c-mode-common . lsp)
         (csharp-mode . lsp)
         (clojure-mode . lsp)
         (latex-mode . lsp)
         (cmake-mode lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :config
  (setq lsp-prefer-capf t) ;; prefer company-capf than company-lsp
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

(use-package lsp-ivy
  :after lsp-mode ivy
  :commands lsp-ivy-workspace-symbol)

;; lsp-treemacs
(use-package lsp-treemacs
  :after lsp treemacs
  :config
  (lsp-treemacs-sync-mode 1))
