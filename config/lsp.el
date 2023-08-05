;;; -*- lexical-binding: t -*-

(use-package eglot
  :straight (:type built-in)
  :bind-keymap ("C-c l" . eglot-mode-map)
  :bind (("<f9>" . eglot)
         ("M-?" . xref-find-references))
  :bind (:map eglot-mode-map
              ("r" . eglot-rename)
              ("f" . eglot-format)
              ("C-<return>" . eglot-code-actions))
  :config
  (setq eglot-events-buffer-size 0
        eglot-connect-timeout 60
        eglot-extend-to-xref t
        eglot-stay-out-of '(flymake eldoc)
        eglot-confirm-server-initiated-edits nil)
  ;; lsp optimizations
  (defun +lsp-init-optimizations ()
    (when (eglot-managed-p)
      (setq-local read-process-output-max (* 1024 1024))
      (setq-local gcmh-high-cons-threshold (* 2 (default-value 'gcmh-high-cons-threshold)))))
  (add-hook 'eglot-managed-mode-hook #'+lsp-init-optimizations))
