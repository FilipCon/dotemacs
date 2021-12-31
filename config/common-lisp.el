;;; -*- lexical-binding: t -*-

(use-package slime
  :hook ((lisp-mode . slime-mode)
         (inferior-lisp-mode . inferior-slime-mode))
  :config
  (defalias 'equalp 'cl-equalp)
  (autoload 'slime "slime" "Superior Lisp Interaction Mode for Emacs" t)
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
        ;; slime-enable-evaluate-in-emacs t
        slime-net-coding-system 'utf-8-unix
        ;; lisp-indent-function 'common-lisp-indent-function
        inferior-lisp-program "sbcl --dynamic-space-size 4096"
        ;; "ccl -K utf-8" "ecl" "alisp" "ccl" "clisp" "abcl"
        ;; slime-complete-symbol-function 'slime-fuzzy-complete-symbol
        ))

(use-package slime-company
  :config
  (set-company-backend! '(lisp-mode) '(company-slime company-yasnippet)))
