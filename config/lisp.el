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
