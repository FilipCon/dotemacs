;;; -*- lexical-binding: t -*-

(use-package cider
  :straight (:host github :repo "FilipCon/cider" :branch "v0_24")
  :bind (:map cider-mode-map
              ("C-c C-b" . cider-eval-buffer)
              ("C-c C-c" . cider-eval-defun-at-point))
  :config
  (global-unset-key (kbd "C-c C-f"))
  (setq cider-completion-annotations-include-ns 'always)
  (add-to-list 'cider-test-defining-forms "deftest-db"))

;; clojure TODO:
(use-package clojure-mode)

;; (use-package inf-clojure
;;   :hook (clojure-mode . inf-clojure-minor-mode))

(use-package clj-refactor
  :hook (clojure-mode . clj-refactor-mode))

;; elisp
(use-package package-lint)
