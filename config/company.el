;;; -*- lexical-binding: t -*-

;; company
(use-package company
  :hook ((prog-mode
          text-mode
          latex-mode
          conf-mode) . my-enable-company)
  :init
  (setq-default company-frontends '(company-pseudo-tooltip-unless-just-one-frontend
                                    company-preview-if-just-one-frontend)
                company-backends '(company-capf
                                   company-keywords
                                   company-files
                                   company-yasnippet
                                   company-dabbrev-code
                                   company-dabbrev))
  :config
  (setq-default company-idle-delay 0.2
                company-minimum-prefix-length 1
                company-tooltip-limit 14
                company-dabbrev-downcase nil
                ;; company-dabbrev-code-other-buffers nil
                company-tooltip-align-annotations t
                company-require-match nil
                company-dabbrev-code-ignore-case t
                company-dabbrev-ignore-case t
                company-dabbrev-other-buffers t)
  ;; ignore candidates from other buffers depending on their major mode
  (setq-default company-dabbrev-ignore-buffers
                (lambda (buffer)
                  (or (memq (buffer-local-value 'major-mode buffer)
                            '(image-mode doc-view-mode dired-mode)) ; files in major modes
                      (string-match-p "\\` \\*" (buffer-name buffer)))))

  ;; enable company-backends per major-mode
  (defun my-enable-company ()
    (when-let* ((backends (cond ((derived-mode-p 'c-mode 'c++-mode)
                                 '(company-c-headers
                                   company-etags))
                                ((derived-mode-p 'cmake-mode)
                                 '(company-cmake))
                                ((derived-mode-p 'python-mode)
                                 '(company-jedi))
                                ((derived-mode-p 'latex-mode)
                                 '(company-auctex-macros
                                   company-auctex-symbols
                                   company-auctex-bibs
                                   company-auctex-environments
                                   company-reftex-citations
                                   company-reftex-labels)))))
      (make-local-variable 'company-backends)
      (dolist (backend (nreverse backends))
        (push backend company-backends))
      (setq company-backends (cons company-backends '()))); merge backends
    (company-mode))
  :bind (
         :map company-active-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous)
         ([tab] . company-complete-selection)))

;; quick tips
(use-package company-quickhelp
  :after company
  :hook (company-mode . company-quickhelp-mode)
  :demand pos-tip)

;; for icons
(use-package company-box
  :after company
  :hook (company-mode . company-box-mode)
  :config
  (setq company-box-icons-alist 'company-box-icons-images))
