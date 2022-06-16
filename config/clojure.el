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
  (setq cider-auto-select-error-buffer nil
        cider-repl-display-help-banner nil
        nrepl-hide-special-buffers t
        cider-repl-history-file "~/.emacs.d/cider-history"
        cider-repl-pop-to-buffer-on-connect 'display-only
        cider-ns-refresh-show-log-buffer t
        cider-use-fringe-indicators nil
        cider-font-lock-dynamically t
        cider-use-xref nil))

;; clojure mode
(use-package clojure-mode
  :mode (("\\.edn$" . clojure-mode)
         ("\\.repl$" . clojure-mode)
         ("\\.bb$" . clojure-mode))
  :config
  ;; (setq clojure-align-reader-conditionals t)
  ;; (setq clojure-indent-style 'align-arguments) ; align function arguments
  (setq clojure-align-forms-automatically t) ; align s-expressions
  :bind (:map clojure-mode-map
              ("C-c C-<SPC>" . clojure-align)))
