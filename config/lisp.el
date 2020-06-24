;;; -*- lexical-binding: t -*-

;; elisp
(use-package package-lint)

;; clojure TODO:
(use-package clojure-mode)
(use-package inf-clojure)
(use-package cider)
(use-package clj-refactor
  :hook (clojure-mode . clj-refactor-mode))
