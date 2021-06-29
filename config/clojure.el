;;; -*- lexical-binding: t -*-

;; cider
(use-package cider
  :hook (cider-mode . lsp)
  :config
  (set-company-backend! '(cider-repl-mode) '(company-capf company-yasnippet))
  (setq-default cider-completion-annotations-include-ns 'always
                cider-show-error-buffer t
                cider-auto-select-error-buffer nil
                cider-repl-display-help-banner nil
                nrepl-hide-special-buffers t
                ;; cider-font-lock-dynamically '(macro core function var deprecated)
                cider-repl-history-display-duplicates nil
                cider-repl-history-display-style 'one-line
                cider-repl-history-highlight-current-entry t
                cider-repl-history-quit-action 'delete-and-restore
                cider-repl-history-highlight-inserted-item t
                cider-repl-result-prefix "=> "
                cider-repl-pop-to-buffer-on-connect 'display-only)
  (unbind-key "M-," cider-mode-map))

;; clojure mode
(use-package clojure-mode)

;; refactor
(use-package clj-refactor
  :hook (clojure-mode . clj-refactor-mode)
  :config
  (cljr-add-keybindings-with-prefix "C-r"))

;; kondo
(use-package flycheck-clj-kondo)

;; toggle between core/test files
(defun toggle-test-path (path)
  (mapconcat 'identity
   "/"
   (mapcar
    (lambda (x)
      (cond ((string-equal x "test") "src")
            ((string-equal x "src") "test")

            ((string-equal x "src-cljs") "test-cljs")
            ((string-equal x "test-cljs") "src-cljs")

            ((string-match "\\(.+\\)_test\\.clj\\(.?\\)" x)
             (concat (match-string 1 x) ".clj" (match-string 2 x)))
            ((string-match "\\(.+\\)\\.clj\\(.?\\)" x)
             (concat (match-string 1 x) "_test.clj" (match-string 2 x)))

            (t x)))
    (split-string path "/"))

   ))

(defun clojure-jump-to-test ()
    "Jump to corresponding test buffer (or the corresponding src buffer if you're in a test.)"
    (interactive)
    (find-file (toggle-test-path buffer-file-name)))

(global-set-key (kbd "C-c t") #'clojure-jump-to-test)
