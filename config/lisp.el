;;; -*- lexical-binding: t -*-

(use-package cider
  :straight (:host github :repo "FilipCon/cider" :branch "v0_24")
  :config
  (setq-default cider-completion-annotations-include-ns 'always
                cider-font-lock-dynamically t
                cider-repl-use-clojure-font-lock t
                nrepl-hide-special-buffers nil
                cider-show-error-buffer nil
                cider-auto-select-error-buffer nil
                cider-repl-pop-to-buffer-on-connect 'display-only
                cider-repl-display-help-banner nil
                cider-repl-use-pretty-printing t))

;; clojure
(use-package clojure-mode)

;; clojure linter via flycheck
(use-package flycheck-clj-kondo)

(use-package clj-refactor
  :hook (clojure-mode . clj-refactor-mode))


;; ;; miracle - arcadia nRepl
;; (add-to-list 'load-path "~/.emacs.d/miracle")
;; (require 'miracle)
;; (add-hook 'clojure-mode-hook 'clojure-enable-miracle)

;; (with-eval-after-load "miracle"
;;   (defun miracle-eval-string (s callback)
;;     (miracle-send-eval-string
;;      s
;;      (lambda (response)
;;              (miracle-dbind-response response (id value status)
;;                                      (when (member "done" status)
;;                                        (remhash id miracle-requests))
;;                                      (when value
;;                                        (funcall callback nil value))))))

;;     (defun miracle-get-completions (word callback)
;;     (interactive)
;;     (miracle-eval-string
;;      (format "(do (require '[%s]) (%s/completions \"%s\"))"
;;              "complete.core" "complete.core" word)
;;      (lambda (err s)
;;              (progn
;;               ;; XXX
;;               (message (format "received str: %s" s))
;;               (message (format "err: %s" err))
;;               (when (not err)
;;                 (funcall callback (read-from-whole-string s)))))))

;;     (defun company-miracle (command &optional arg &rest ignored)
;;     (interactive (list 'interactive))
;;     (cl-case command
;;              (interactive (company-begin-backend 'company-miracle))
;;              (prefix (and (or ;;(eq major-mode 'clojurec-mode)
;;                            ;;(eq major-mode 'clojure-mode)
;;                            (eq major-mode 'miracle-mode))
;;                           (get-buffer "*miracle-connection*")
;;                           (substring-no-properties (company-grab-symbol))))
;;              (candidates (lexical-let ((arg (substring-no-properties arg)))
;;                                       (cons :async (lambda (callback)
;;                                                            (miracle-get-completions arg callback)))))))

;;     ;; XXX: problems w/o the following when invoking company-grab-symbol
;;     (setq cider-mode nil)

;;     (add-to-list 'company-backends 'company-miracle)
;;     )


;; elisp
(use-package package-lint
  :bind ("C-c C-c" . eval-buffer))

;; linter for the metadata in Emacs Lisp files which are intended to be packages.
(use-package package-lint
  :commands (package-lint-current-buffer))
