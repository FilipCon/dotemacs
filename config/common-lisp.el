;;; -*- lexical-binding: t -*-

(use-package slime
  :config
  (setq inferior-lisp-program "sbcl"))

(use-package slime-company
  :config
  (set-company-backend! '(lisp-mode) '(company-slime company-yasnippet)))
