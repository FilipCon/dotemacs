;;; -*- lexical-binding: t -*-

;; globally ignored files and directories
(defvar ignored-directories
  '("node_modules" ".shadow-cljs" ".lsp" ".cpcache" ".clj-kondo" "tmp" "build"
    "target" ".git" "log"))

(defvar ignored-files
  '("*.elc" "*.pyc" "*.o" "*.so" "*.ipynb" "*.svg"))

(use-package project
  :straight (:type built-in)
  :bind ("C-`" . project-eshell)
  :config
  (setq project-vc-ignores (append ignored-files ignored-directories)))
