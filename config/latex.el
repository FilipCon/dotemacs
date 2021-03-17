;;; -*- lexical-binding: t -*-

;; latex
(use-package tex-site
  :straight auctex
  :ensure auctex)

(use-package tex
  :straight auctex
  :after tex-site pdf-tools
  :hook ((TeX-mode . TeX-PDF-mode)
         (TeX-mode . TeX-source-correlate-mode))
  :config
  (setf (default-value 'TeX-master) nil
        TeX-parse-self t
        TeX-auto-save t)
  (setf TeX-electric-sub-and-superscript t
        TeX-electric-math (cons "$" "$"))
  (setf TeX-source-correlate-start-server nil
        TeX-source-correlate-method 'synctex)
  (setf TeX-clean-confirm nil)
  (add-to-list 'TeX-view-program-selection '(output-pdf "PDF Tools")))

(use-package tex-buf
  :straight auctex
  :after tex-site
  :config (setf TeX-save-query nil))

(use-package tex-fold
  :straight auctex
  :after tex-site
  :bind (:map TeX-fold-keymap ("\\" . prettify-symbols-mode))
  :hook (TeX-mode . TeX-fold-mode))

(use-package tex-style
  :straight auctex
  :after tex-site
  :config
  (setf LaTeX-csquotes-open-quote "\\enquote{"
        LaTeX-csquotes-close-quote "}"))

(use-package latex
  :straight auctex
  :after tex-site
  :hook (LaTeX-mode . LaTeX-math-mode)
  :config
  (setf LaTeX-babel-hyphen nil))

(use-package preview
  :straight auctex
  :after tex-site
  :config (setf preview-auto-cache-preamble nil))

(use-package auctex-latexmk
  :load-path "lisp"
  :after latex
  :config (auctex-latexmk-setup))

(use-package reftex
  :hook (LaTeX-mode . reftex-mode)
  :config
  (setf reftex-plug-into-AUCTeX t)
  ;; Offer a guess but ask for confirmation
  (setf reftex-insert-label-flags '(t t))
  (setf reftex-cite-format 'biblatex))

(use-package reftex-cite
  :config
  (defun my-query-reftex-citation-search-regexps (default)
    "Query for regular expressions of search queries.
DEFAULT is the default value.
This is a replacement for `reftex--query-search-regexps'."
    (split-string (read-string (format "Regex [&& Regex...] (%s): " default)
                               nil 'reftex-cite-regexp-hist default)
                  "[ \t]*&&[ \t]*"))
  (setf (symbol-function 'reftex--query-search-regexps)
        #'my-query-reftex-citation-search-regexps))

(use-package company-auctex)
(use-package company-math)
(use-package company-reftex)

(use-package bibtex
  :init (setf bibtex-dialect 'biblatex)
  :config
  (setf bibtex-align-at-equal-sign t)
  (setf bibtex-entry-format '(opts-or-alts
                              required-fields
                              numerical-fields
                              whitespace
                              realign
                              last-comma
                              delimiters
                              unify-case
                              braces
                              strings
                              sort-fields))
  (setf bibtex-autokey-year-length 4
        bibtex-autokey-year-title-separator ""
        bibtex-autokey-titleword-separator ""
        bibtex-autokey-titlewords 1
        bibtex-autokey-titleword-length 10)
  (unbind-key "C-c $" bibtex-mode-map))
