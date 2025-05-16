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
        cider-nbb-command "npx nbb"
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

;; (use-package zprint-mode) ;; uses dynamically linked executable
;; (use-package zprint-format)

;; ;; jump to definition for re-frame events/subs
;; (use-package re-jump
;;   :straight (:host github :repo "oliyh/re-jump.el"))

;; ;; jet tool
;; (use-package jet
;;   :straight (:host github :repo "ericdallo/jet.el"))

;; ;; refactor utils
;; (use-package clj-refactor
;;   :config
;;   (setq cljr-warn-on-eval nil
;;         cljr-magic-requires nil
;;         ;; cljr-insert-newline-after-require nil
;;         ;; cljr-populate-artifact-cache-on-startup nil
;;         cljr-find-usages-ignore-analyzer-errors t))

(defun wrap-next-sexp (open close)
  "Wrap the next `sexp' from point with OPEN and CLOSE strings.
  The cursor is placed after the opening delimiter."
  (forward-sexp)
  (let ((bounds (bounds-of-thing-at-point 'sexp)))
    (when bounds
      (goto-char (cdr bounds))
      (insert close)
      (goto-char (car bounds))
      (insert open))))

(defun wrap-next-sexp-with-do ()
  "Wrap the next `sexp' with `do' function.
  The cursor is placed between `do' and `sexp`."
  (wrap-next-sexp "(do  " ")")
  (backward-char 1))

(defun clj-insert-persist-scope-macro ()
  (interactive)
  (insert
   "(defmacro persist-scope
              \"Takes local scope vars and defines them in the global scope. Useful for RDD\"
              []
              `(do ~@(map (fn [v] `(def ~v ~v))
                  (keys (cond-> &env (contains? &env :locals) :locals)))))"))

(defun persist-scope-do ()
  (interactive)
  (undo-boundary)
  (wrap-next-sexp-with-do)
  (clj-insert-persist-scope-macro)
  (cider-eval-last-sexp)
  (backward-sexp)
  (kill-sexp)
  ;; If emacs is slow, it will start evaluating function at point
  ;; before macro is evaluated and deleted.
  (sleep-for 0 10)
  (insert "(persist-scope)")
  (cider-eval-defun-at-point)
  (undo-tree-undo))
