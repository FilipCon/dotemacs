;;; -*- lexical-binding: t -*-

;; elisp
(use-package package-lint)

;; clojure TODO:
(use-package clojure-mode)

(use-package inf-clojure
  :hook (clojure-mode . inf-clojure-minor-mode))

(use-package clj-refactor
  :hook (clojure-mode . clj-refactor-mode))

(use-package cider
  :commands (cider-jack-in
             cider-jack-in-clj
             cider-jack-in-cljs
             cider-connect
             cider-connect-clj
             cider-connect-cljs)
  ;;:hook (cider-mode . cider-mode-config)
  :bind (:map cider-mode-map
         ("C-c m" . cider-eval-buffer))
  :config
  (add-to-list 'cider-test-defining-forms "deftest-db"))
