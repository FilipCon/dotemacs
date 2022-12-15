;;; -*- lexical-binding: t -*-

(use-package slime
  :hook ((lisp-mode . slime-mode))
  :bind (:map slime-mode-map
              ("C-c M-j" . slime)
              ("C-c C-e" . slime-eval-last-expression)
              ("C-c C-q" . slime-repl-quit))
  :bind (:map slime-repl-mode-map
              ("C-c C-q" . slime-repl-quit))
  :config
  (unbind-key "M-n" slime-mode-map)
  (unbind-key "M-p" slime-mode-map)
  (slime-setup '(slime-asdf
                 slime-autodoc
                 slime-banner
                 slime-compiler-notes-tree
                 slime-editing-commands
                 slime-fancy-inspector
                 slime-fancy-trace
                 slime-fontifying-fu
                 slime-indentation
                 slime-macrostep
                 slime-mdot-fu
                 slime-mrepl
                 slime-package-fu
                 slime-presentations
                 slime-quicklisp
                 slime-references
                 slime-repl
                 slime-scratch
                 slime-sprof
                 slime-trace-dialog
                 slime-tramp
                 slime-xref-browser))
  (setq common-lisp-style 'modern
        slime-header-line-p nil
        slime-startup-animation nil
        ;; common-lisp-hyperspec-root (expand-file-name "~/.emacs.d/HyperSpec/")
        slime-net-coding-system 'utf-8-unix
        inferior-lisp-program "sbcl"))
