;;; -*- lexical-binding: t -*-

;; company
(use-package company
  :hook ((prog-mode
          text-mode
          latex-mode
          cider-repl-mode
          jupyter-repl-mode
          inferior-python-mode
          conf-mode) . my-enable-company)
  :init
  (setq-default company-backends '(company-capf
                                   company-files
                                   company-yasnippet))
  :config
  (setq-default company-idle-delay 0
                company-minimum-prefix-length 1
                company-tooltip-align-annotations t
                company-require-match nil
                company-selection-wrap-around t
                company-dabbrev-downcase nil
                company-dabbrev-code-other-buffers nil
                company-dabbrev-other-buffers nil
                company-dabbrev-code-ignore-case t
                company-dabbrev-ignore-case t
                company-tooltip-idle-delay 0)

  ;; ignore candidates from other buffers depending on their major mode
  (setq-default company-dabbrev-ignore-buffers
                (lambda (buffer)
                  (or (memq (buffer-local-value 'major-mode buffer)
                            '(image-mode doc-view-mode dired-mode)) ; files in major modes
                      (string-match-p "\\` \\*" (buffer-name buffer)))))

  ;; enable company-backends per major-mode
  (defun my-enable-company ()
    (make-local-variable 'company-backends)
    (when-let* ((backends (cond ((derived-mode-p 'cmake-mode)
                                 '(company-cmake))
                                ((derived-mode-p 'c++-mode)
                                 '(company-c-headers))
                                ((derived-mode-p 'csharp-mode)
                                 '(company-omnisharp))
                                ((derived-mode-p 'latex-mode)
                                 '(company-math
                                   company-auctex-macros
                                   company-auctex-symbols
                                   company-auctex-bibs
                                   company-auctex-environments
                                   company-reftex-citations
                                   company-reftex-labels)))))
      (dolist (backend (reverse backends))
        (push backend company-backends)))
    (setq company-backends (cons company-backends '())); merge backends for combinded completions
    (add-to-list 'company-backends '(company-dabbrev company-dabbrev-code company-keywords) t)
    (company-mode))
  :bind (
         :map company-active-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous)
         ([tab] . company-complete-selection)))

;; sort candidates
(use-package company-prescient
  :after (company prescient)
  :hook (company-mode . company-prescient-mode))

;; for icons and quickhelp
(use-package company-box
  :after company all-the-icons
  :hook (company-mode . company-box-mode)
  :config
  (setq company-box-doc-delay 0
        company-box-backends-colors nil
        company-box-color-icon nil
        company-box-icons-alist 'company-box-icons-images))
