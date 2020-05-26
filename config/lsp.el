;;; -*- lexical-binding: t -*-

(use-package lsp-mode
  :commands lsp
  :config
  (setq lsp-prefer-capf t) ;; prefer company-capf than company-lsp
  ;; prefer using lsp-ui (flycheck)
  (setq lsp-prefer-flymake nil)
  ;; setup clangd
  (setq lsp-clients-clangd-args '("-j=2" "-background-index" "-log=error" "--clang-tidy"))
  ;; hook languages
  (add-hook 'python-mode-hook 'lsp)
  (add-hook 'c-mode-common-hook 'lsp)
  (add-hook 'csharp-mode-hook 'lsp)
  (add-hook 'clojure-mode-hook 'lsp)
  (add-hook 'latex-mode-hook 'lsp)
  (add-hook 'cmake-mode-hook 'lsp))

;; lsp extras
(use-package lsp-ui
  :requires lsp-mode flycheck
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
        lsp-ui-peek-peek-height 25
        )
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

;; (use-package company-lsp
;;             :after (company)
;;             :commands company-lsp
;;             :config
;;             (push 'company-lsp company-backends)
;;             ;; disable client-side cache because the LSP server does a better job.
;;             (setq company-transformers nil
;;                   company-lsp-async t
;;                   company-lsp-cache-candidates nil))
