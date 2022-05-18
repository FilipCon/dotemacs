;;; -*- lexical-binding: t -*-

;; latex
(use-package tex
  :straight auctex
  :after pdf-tools
  :hook ((LaTeX-mode . reftex-mode)
         (latex-mode . reftex-mode))
  :config
  (setq-default TeX-master nil)
  (setq TeX-auto-save t
        TeX-parse-self t)
  (add-to-list 'TeX-view-program-selection '(output-pdf "PDF Tools")))

;; auctec improvements (eg. math mode)
(use-package cdlatex
  :hook ((LaTeX-mode . turn-on-cdlatex)
         (latex-mode . turn-on-cdlatex)))

;; ;; latexmk
;; (use-package auctex-latexmk
;;   :init (auctex-latexmk-setup)
;;   :config
;;   (setq auctex-latexmk-inherit-TeX-PDF-mode t))

;; completion backends
(use-package company-math
  :config
  (set-company-backend! 'latex-mode '(company-capf
                                      company-yasnippet
                                      company-math-symbols-latex
                                      company-math-symbols-unicode
                                      company-latex-commands
                                      company-ispell)))

;; PDF tools
(use-package pdf-tools
  :straight t
  :init
  (pdf-tools-install)
  :config
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer))
