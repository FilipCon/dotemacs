;;; -*- lexical-binding: t -*-

;; elisp
(use-package package-lint)

;; clojure TODO:
(use-package clojure-mode)

;; (use-package inf-clojure
;;   :hook (clojure-mode . inf-clojure-minor-mode))

(use-package clj-refactor
  :hook (clojure-mode . clj-refactor-mode))

(use-package cider
  :bind (:map cider-mode-map
              ("C-c C-b" . cider-eval-buffer)
              ("C-c C-c" . cider-eval-defun-at-point))
  :config
  (global-unset-key (kbd "C-c C-f"))
  (setq cider-completion-annotations-include-ns 'always)
  (add-to-list 'cider-test-defining-forms "deftest-db"))

;; miracle - arcadia nRepl
(add-to-list 'load-path "~/.emacs.d/miracle")
(require 'miracle)
(add-hook 'clojure-mode-hook 'clojure-enable-miracle)

(with-eval-after-load "miracle"
  (defun miracle-eval-string (s callback)
    (miracle-send-eval-string
     s
     (lambda (response)
             (miracle-dbind-response response (id value status)
                                     (when (member "done" status)
                                       (remhash id miracle-requests))
                                     (when value
                                       (funcall callback nil value))))))

    (defun miracle-get-completions (word callback)
    (interactive)
    (miracle-eval-string
     (format "(do (require '[%s]) (%s/completions \"%s\"))"
             "complete.core" "complete.core" word)
     (lambda (err s)
             (progn
              ;; XXX
              (message (format "received str: %s" s))
              (message (format "err: %s" err))
              (when (not err)
                (funcall callback (read-from-whole-string s)))))))

    (defun company-miracle (command &optional arg &rest ignored)
    (interactive (list 'interactive))
    (cl-case command
             (interactive (company-begin-backend 'company-miracle))
             (prefix (and (or ;;(eq major-mode 'clojurec-mode)
                           ;;(eq major-mode 'clojure-mode)
                           (eq major-mode 'miracle-mode))
                          (get-buffer "*miracle-connection*")
                          (substring-no-properties (company-grab-symbol))))
             (candidates (lexical-let ((arg (substring-no-properties arg)))
                                      (cons :async (lambda (callback)
                                                           (miracle-get-completions arg callback)))))))

    ;; XXX: problems w/o the following when invoking company-grab-symbol
    (setq cider-mode nil)

    (add-to-list 'company-backends 'company-miracle)
    )
