;; cider
(use-package cider
  :bind (:map cider-mode-map
              ("C-c ." . cider-find-var)
              ("C-c M-." . cider-find-dwim-other-window))
  :bind (:map cider-repl-mode-map
              ("C-c C-o" . cider-repl-clear-buffer))
  :init
  (setq cider-auto-select-error-buffer nil
        cider-repl-display-help-banner nil
        nrepl-hide-special-buffers t
        cider-repl-history-file "~/.emacs.d/cider-history"
        cider-repl-pop-to-buffer-on-connect 'display-only
        cider-ns-refresh-show-log-buffer t
        cider-connection-message-fn nil
        cider-jack-in-nrepl-middlewares '("cider.nrepl/cider-middleware")
        cider-use-fringe-indicators nil
        cider-font-lock-dynamically nil
        cider-use-xref nil))

;; clojure mode
(use-package clojure-mode
  :mode (("\\.edn$" . clojure-mode)
         ("\\.repl$" . clojure-mode)
         ("\\.bb$" . clojure-mode))
  :config
  (setq clojure-align-reader-conditionals t
        clojure-align-forms-automatically t) ; align s-expressions
  ;; (setq clojure-indent-style 'align-arguments)
  :bind (:map clojure-mode-map
              ("C-c C-<SPC>" . clojure-align)))

;; linting
(use-package flymake-kondor
  :hook ((clojure-mode . flymake-kondor-setup)
         (clojure-mode . flymake-mode)))

;; jet tool
(use-package jet
  :straight (:host github :repo "ericdallo/jet.el"))

;; ;; refactor utils
;; (use-package clj-refactor
;;   :config
;;   (setq cljr-warn-on-eval nil
;;         cljr-magic-requires nil
;;         ;; cljr-insert-newline-after-require nil
;;         ;; cljr-populate-artifact-cache-on-startup nil
;;         cljr-find-usages-ignore-analyzer-errors t))
