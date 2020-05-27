;;; -*- lexical-binding: t -*-

(use-package lsp-mode
  :commands lsp
  :config
  (setq lsp-prefer-capf t) ;; prefer company-capf than company-lsp
  ;; prefer using lsp-ui (flycheck)
  (setq lsp-prefer-flymake nil)
  ;; setup clangd
  (setq lsp-clients-clangd-args '("-j=2" "-background-index" "-log=error" "--clang-tidy"))
  ;; Disable LSP's superfluous, expensive and/or debatably unnecessary features.
  ;; Some servers implement these poorly. Better to just rely on Emacs' native
  ;; mechanisms and make these opt-in.
  (setq lsp-enable-folding nil
        ;; HACK Fix #2911, until it is resolved upstream. Links come in
        ;;      asynchronously from the server, but lsp makes no effort to
        ;;      "select" the original buffer before laying them down, so they
        ;;      could be rendered in the wrong buffer (like the minibuffer).
        lsp-enable-links nil
        ;; Potentially slow
        lsp-enable-file-watchers nil
        lsp-enable-text-document-color nil
        lsp-enable-semantic-highlighting nil
        ;; Don't modify our code without our permission
        lsp-enable-indentation nil
        lsp-enable-on-type-formatting nil)
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
        lsp-ui-doc-include-signature nil
        lsp-ui-sideline-enable nil
        lsp-ui-flycheck-enable t
        lsp-ui-flycheck-list-position 'right
        lsp-ui-flycheck-live-reporting t
        lsp-ui-peek-enable t
        lsp-ui-peek-list-width 60
        lsp-ui-peek-peek-height 25)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

;; ;; lsp-treemacs
;; (use-package lsp-treemacs 
;;   :config
;;   (lsp-treemacs-sync-mode 1))

(use-package lsp-ivy)

;; (use-package company-lsp
;;   :defer t
;;   :after (company)
;;   :commands company-lsp
;;   :hook (prog-mode . company-lsp-mode)
;;   :config
;;   (setq company-lsp-cache-candidates 'auto)
;;   (push 'company-lsp company-backends)
;;   ;; disable client-side cache because the LSP server does a better job.
;;   (setq company-transformers nil
;;         company-lsp-async t
;;         company-lsp-cache-candidates nil))
