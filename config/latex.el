;;; -*- lexical-binding: t -*-

(use-package company-math)

(use-package tex
  :straight auctex
  :after pdf-tools
  :hook (LaTeX-mode . reftex-mode)
  :config
  (set-company-backend! 'latex-mode '(company-capf
                                      company-yasnippet
                                      company-math-symbols-latex
                                      company-math-symbols-unicode
                                      company-latex-commands
                                      company-ispell))
  (add-to-list 'TeX-view-program-selection '(output-pdf "PDF Tools")))

(use-package cdlatex
  :hook (LaTeX-mode . turn-on-cdlatex))

(use-package auctex-latexmk
  :init (auctex-latexmk-setup)
  :config
  (setq-default TeX-master nil))
