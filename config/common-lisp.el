;;; -*- lexical-binding: t -*-

(use-package slime
  :hook ((lisp-mode . slime-mode)
         (inferior-lisp-mode . inferior-slime-mode))
  :bind (:map slime-mode-map
              ("C-c M-j" . slime)
              ("C-c C-e" . slime-eval-last-expression)
              ("C-c C-q" . slime-repl-quit))
  :bind (:map slime-repl-mode-map
              ("C-c C-q" . slime-repl-quit))
  :config
  (unbind-key "M-n" slime-mode-map)
  (unbind-key "M-p" slime-mode-map)
  (slime-setup '(slime-repl slime-fuzzy))
  (setq common-lisp-style 'modern
        slime-header-line-p nil
        slime-startup-animation nil
        slime-net-coding-system 'utf-8-unix
        inferior-lisp-program "sbcl"))
