;;; -*- lexical-binding: t -*-

(use-package project
  :config
  (setq project-vc-ignores
        '("tmp" ".shadow-cljs" "node_modules"
          ".lsp" ".cpcache" ".clj-kondo"
          "*.elc" "*.pyc" "*.o" "*.so")))
