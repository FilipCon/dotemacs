;;; -*- lexical-binding: t -*-

(use-package eglot
  :custom-face
  (eglot-highlight-symbol-face ((t (:inherit bold :foreground "white" :background "dodger blue"))))
  (eglot-diagnostic-tag-unnecessary-face ((t (:inherit (flymake-warning)))))
  :bind-keymap ("C-c l" . eglot-mode-map)
  :bind (("<f6>" . eglot))
  :bind (:map eglot-mode-map
              ("M-," . xref-find-references)
              ("C-c l r" . eglot-rename)
              ("C-c l f" . eglot-format)
              ("C-<return>" . eglot-code-actions))
  :config
  (setq eldoc-echo-area-use-multiline-p nil)
  ;; lsp optimizations
  (defun +lsp-init-optimizations ()
    (when (eglot-managed-p)
      (setq-local read-process-output-max (* 1024 1024)) ; 1mb
      (setq-local gc-cons-threshold (* 1024 1024 1024)))) ; 1gb
  (add-hook 'eglot-managed-mode-hook #'+lsp-init-optimizations))
