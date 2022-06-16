;;; -*- lexical-binding: t -*-

(use-package project
  :straight (:type built-in)
  :bind ("C-`" . project-eshell)
  :config
  (setq project-vc-ignores (append ignored-files ignored-directories)))
