;;; -*- lexical-binding: t -*-

(use-package web-mode
  :straight t
  :mode (("\\.html?\\'" . web-mode))
  :config
  (setq-default
   web-mode-block-padding 2
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

(use-package emmet-mode
  :hook (html-mode . emmet-mode))

(use-package json-mode
  :mode ("\\.json?\\'" . json-mode))

(use-package sgml-mode
  :config
  :bind (:map sgml-mode-map
         ("<f1> SPC" . sgml-mark-tag))
  :mode (("\\.html$" . sgml-mode)
         ("\\.xml$" . sgml-mode)))

(use-package tagedit
  :hook (html-mode . tagedit-mode)
  :config
  (tagedit-add-paredit-like-keybindings))

(use-package csv-mode
  :hook (csv-mode . csv-align-mode))

(use-package logview)

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
  :config
  (setq sql-postgres-login-params
        '((user :default "postgres")
          (database :default "postgres")
          (server :default "localhost")
          (port :default 5432)))
  ;; bug fix
  (add-to-list 'sql-postgres-options "--no-psqlrc")
  (defun sanityinc/fix-postgres-prompt-regexp ()
    "Work around https://debbugs.gnu.org/cgi/bugreport.cgi?bug=22596.
Fix for the above hasn't been released as of Emacs 25.2."
    (when (eq sql-product 'postgres)
      (setq-local sql-prompt-regexp "^[[:alnum:](-|_)]*=[#>] ")
      (setq-local sql-prompt-cont-regexp "^[[:alnum:](-|_)]*[-(][#>] ")))
  (add-hook 'sql-interactive-mode-hook 'sanityinc/fix-postgres-prompt-regexp))

(use-package sqlformat
  :config
  ;; (setq sqlformat-command 'pgformatter)
  ;; (setq sqlformat-args '("-s2" "-g"))
  (define-key sql-mode-map (kbd "C-c C-f") 'sqlformat))

(use-package log4j-mode
  :disabled t
  :hook
  ((log4j-mode .view-mode)
   (log4j-mode .read-only-mode)))

(use-package terraform-mode)
