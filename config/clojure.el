;;; -*- lexical-binding: t -*-

;; cider
(use-package cider
  :bind (:map cider-mode-map
              ("C-c ." . cider-find-var)
              ("C-c M-." . cider-find-dwim-other-window))
  :bind (:map cider-repl-mode-map
              ("C-c C-o" . cider-repl-clear-buffer))
  :hook (cider-mode . (lambda ()
                        (remove-hook 'completion-at-point-functions
                                     #'cider-complete-at-point)))
  :config
  (set-company-backend! '(cider-repl-mode) '(company-capf company-yasnippet))
  (add-to-list 'company-begin-commands 'cljr-slash)
  (setq cider-auto-select-error-buffer nil
        cider-repl-display-help-banner nil
        nrepl-hide-special-buffers t
        cider-repl-history-file "~/.emacs.d/cider-history"
        cider-repl-history-size 3000
        cider-repl-pop-to-buffer-on-connect 'display-only
        cider-ns-refresh-show-log-buffer t
        cider-use-fringe-indicators nil
        cider-font-lock-dynamically nil ; use lsp semantic tokens
        cider-eldoc-display-for-symbol-at-point nil)
  (defun +kill-company-doc-buffer (orig-fun &rest args)
    ;; HACK *company-documentation* buffer opens when selecting snippet
    ;; candidates with company. The buffer is in REPL mode which confuses cider
    ;; so no other repl can be created
    (kill-buffer (company-doc-buffer))
    (apply orig-fun args))
  (advice-add 'cider--gather-connect-params :around #'+kill-company-doc-buffer))

;; clojure mode
(use-package clojure-mode
  :mode (("\\.edn$" . clojure-mode)
         ("\\.repl$" . clojure-mode)
         ("\\.bb$" . clojure-mode))
  :config
  ;; (setq clojure-align-reader-conditionals t)
  ;; (setq clojure-indent-style 'align-arguments) ; align function arguments
  (setq clojure-align-forms-automatically t) ; align s-expressions
  :bind ("C-c C-<SPC>" . clojure-align))
