;;; -*- lexical-binding: t -*-

;; language server
(use-package lsp-mode
  :hook ((c-mode
	  c++-mode
	 ;; python-mode
	 csharp-mode
         clojure-mode clojurec-mode clojurescript-mode
	 sql-mode css-mode html-mode
         latex-mode LaTeX-mode tex-mode yatex-mode bibtex-mode) . lsp)
  :hook (lsp-mode . (lambda () (let ((lsp-keymap-prefix "C-c l"))
                                 (lsp-enable-which-key-integration))))
  :config
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
  (global-set-key (kbd "C-<return>") 'lsp-execute-code-action)
  (setq lsp-completion-provider :none
	lsp-enable-file-watchers nil
        lsp-enable-indentation nil
        lsp-headerline-breadcrumb-enable-diagnostics nil
        lsp-enable-semantic-highlighting t
        lsp-prefer-flymake nil
	lsp-restart 'auto-restart))

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
