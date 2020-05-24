;;; -*- lexical-binding: t -*-

(use-package tex
  :straight auctex
  :mode ("\\.tex\\'" . latex-mode)
  :init
  (progn
    (setq TeX-auto-save t
          TeX-parse-self t
          TeX-syntactic-comment t
          ;; Synctex support
          TeX-source-correlate-mode t
          TeX-source-correlate-method 'synctex
          TeX-source-correlate-start-server nil
          ;; Don't insert line-break at inline math
          LaTeX-fill-break-at-separators nil)
    (add-hook 'LaTeX-mode-hook 'auto-fill-mode)
    (add-hook 'LaTeX-mode-hook 'TeX-fold-mode)
    (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
    (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
    (add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
    (add-hook 'LaTeX-mode-hook 'flyspell-mode)
    (add-hook 'LaTex-mode-hook 'company-mode)
    (add-hook 'LaTex-mode-hook 'prog-mode))
  :config
  (use-package auctex-latexmk
    :straight t
    :config
    (auctex-latexmk-setup))

  (use-package company-auctex :straight t)

  (use-package pdf-tools
    :straight t
    :init
    (pdf-tools-install)
    :config
    (defun ds/disable-cursor-blink () (blink-cursor-mode 0))
    (add-hook 'pdf-view-mode-hook 'ds/disable-cursor-blink)
    (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer))

  ;; Reftex
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
  (add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode

  ;; Viewer
  (cond
   ((eq system-type 'windows-nt)
    (add-hook 'LaTeX-mode-hook
              (lambda ()
                (setq TeX-view-program-selection '((output-pdf "Acrobat")
                                                   (output-dvi "Yap"))))))
   ((eq system-type 'gnu/linux)
    (add-hook 'LaTeX-mode-hook
              (lambda ()
                (setq TeX-view-program-selection '((output-pdf "PDF Tools")
                                                   (output-dvi "gv"))))))))

