;;; -*- lexical-binding: t -*-

(defun web-mode-defaults ()
  (setq web-mode-block-padding 2
        web-mode-code-indent-offset 2
        web-mode-comment-style 2
        web-mode-css-indent-offset 2
        web-mode-enable-auto-closing t
        web-mode-auto-close-style 2
        web-mode-enable-auto-pairing t
        web-mode-enable-comment-keywords t
        web-mode-enable-html-entities-fontification t
        web-mode-enable-css-colorization t
        web-mode-enable-current-element-highlight t
        web-mode-markup-indent-offset 2))

(use-package web-mode
  :straight t
  :init (web-mode-defaults)
  :mode (("\\.html?\\'" . web-mode)))

(use-package emmet-mode)

(use-package json-mode
  :mode ("\\.json?\\'" . json-mode))

(use-package tagedit
  :hook (html-mode . tagedit-mode)
  :config
  (tagedit-add-paredit-like-keybindings))

(use-package csv-mode
  :hook (csv-mode . csv-align-mode))

(use-package yaml-mode
  :hook (yaml-mode . lsp-mode))

(use-package restclient
  :mode (("\\.http$" . restclient-mode)))

(use-package company-restclient
  :after restclient
  :config
  (set-company-backend! 'restclient-mode 'company-restclient))

(use-package sass-mode)

(use-package company-web
  :config
  (set-company-backend! 'sass-mode '(company-capf
                                     company-yasnippet
                                     company-css))
  (set-company-backend! 'web-mode '(company-capf
                                    company-yasnippet
                                    company-css
                                    company-web-html)))

(use-package sql
  :mode (("\\.sql?\\'" . sql-mode))
  :config
  ;; (add-to-list 'sql-postgres-options "--no-psqlrc")
  (defun sanityinc/fix-postgres-prompt-regexp ()
    "Work around https://debbugs.gnu.org/cgi/bugreport.cgi?bug=22596.
Fix for the above hasn't been released as of Emacs 25.2."
    (when (eq sql-product 'postgres)
      (setq-local sql-prompt-regexp "^[[:alnum:](-|_)]*=[#>] ")
      (setq-local sql-prompt-cont-regexp "^[[:alnum:](-|_)]*[-(][#>] ")))

  (add-hook 'sql-interactive-mode-hook 'sanityinc/fix-postgres-prompt-regexp))
