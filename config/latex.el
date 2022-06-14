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
  :config (unbind-key "TAB" cdlatex-mode-map)
  :hook ((LaTeX-mode . turn-on-cdlatex)
         (latex-mode . turn-on-cdlatex)))

;; latexmk
(use-package auctex-latexmk
  :init (auctex-latexmk-setup)
  :config
  (setq auctex-latexmk-inherit-TeX-PDF-mode t))

;; PDF tools
(use-package pdf-tools
  :straight t
  :init
  (pdf-tools-install)
  :config
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer))
