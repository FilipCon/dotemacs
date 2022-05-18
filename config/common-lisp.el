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
  (defalias 'equalp 'cl-equalp)
  (autoload 'slime "slime" "Superior Lisp Interaction Mode for Emacs" t)
  (unbind-key "M-n" slime-mode-map)
  (unbind-key "M-p" slime-mode-map)
  (slime-setup
   '(slime-asdf slime-banner slime-clipboard
                slime-compiler-notes-tree slime-fancy
                slime-fontifying-fu slime-hyperdoc
                slime-indentation slime-media
                slime-mrepl slime-parse
                slime-sbcl-exts slime-sprof
                slime-xref-browser
                slime-company))
  (setq common-lisp-style 'modern
        slime-header-line-p nil
        slime-startup-animation nil
        slime-net-coding-system 'utf-8-unix
        ;; lisp-indent-function 'common-lisp-indent-function
        inferior-lisp-program "sbcl --dynamic-space-size 4096"
        ;; "ccl -K utf-8" "ecl" "alisp" "ccl" "clisp" "abcl"
        ;; slime-complete-symbol-function 'slime-fuzzy-complete-symbol
        ))

(use-package slime-company
  :config
  (set-company-backend! '(lisp-mode) '(company-slime company-yasnippet)))
