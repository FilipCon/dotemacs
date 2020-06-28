;;; -*- lexical-binding: t -*-

;; preview org files
(use-package org-preview-html
  :hook (org-mode . org-preview-html-mode))
(use-package org-ref)

;; The markdown mode is awesome! unbeatable
(use-package markdown-mode
  :ensure t
  :mode ("README\\(?:\\.md\\)?\\'" . gfm-mode)
  :hook (markdown-mode . auto-fill-mode)
  :init
  (advice-add #'markdown--command-map-prompt :override #'ignore)
  (advice-add #'markdown--style-map-prompt   :override #'ignore)
  :custom
  (markdown-header-scaling t)
  (markdown-enable-wiki-links t)
  (markdown-italic-underscore t)
  (markdown-asymmetric-header t)
  (markdown-gfm-uppercase-checkbox t)
  (markdown-fontify-code-blocks-natively t))

;; Generate table of contents for markdown-mode
(use-package markdown-toc
  :ensure t
  :after markdown-mode
  :bind (:map markdown-mode-command-map
              ("r" . markdown-toc-generate-or-refresh-toc)))

(use-package tex-site
  :straight auctex
  :ensure auctex)

(use-package tex
  :straight auctex
  :after tex-site
  :hook ((TeX-mode . TeX-PDF-mode)
         (TeX-mode . TeX-source-correlate-mode))
  :config
  (setf (default-value 'TeX-master) nil
        (default-value 'TeX-engine) 'luatex
        TeX-parse-self t
        TeX-auto-save t)
  (setf TeX-electric-sub-and-superscript t)
  (setf TeX-source-correlate-start-server nil
        TeX-source-correlate-method 'synctex)
  (setf TeX-clean-confirm nil)
  (setf TeX-command-list
        '(("View" "%V" TeX-run-discard-or-function t t :help "Run Viewer")
          ("TeXcount" "texcount -unicode -inc %t" TeX-run-shell nil
           (latex-mode) :help "Run TeXcount")
          ("ChkTeX" "chktex -v6 %s" TeX-run-compile nil (latex-mode)
           :help "Check LaTeX file for common mistakes")
          ("Clean" "TeX-clean" TeX-run-function nil t
           :help "Delete generated intermediate files")
          ("Clean All" "(TeX-clean t)" TeX-run-function nil t
           :help "Delete generated intermediate and output files")
          ("Other" "" TeX-run-command t t :help "Run an arbitrary command"))))

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
  (setf LaTeX-babel-hyphen nil)

  (defun my-setup-LaTeX-mode ()
    (make-local-variable 'TeX-electric-math)
    (setf TeX-electric-math '("\\(" . "\\)")))
  (add-hook 'LaTeX-mode-hook #'my-setup-LaTeX-mode))

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

;; PDF tools
(use-package pdf-tools
  :straight t
  :init
  (pdf-tools-install)
  :config
  (defun ds/disable-cursor-blink () (blink-cursor-mode 0))
  (add-hook 'pdf-view-mode-hook 'ds/disable-cursor-blink)
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer))
