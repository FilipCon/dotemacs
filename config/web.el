;;; -*- lexical-binding: t -*-

;; basic web mode settings
(use-package web-mode
  :straight t
  :config
  (setq web-mode-block-padding 2
        web-mode-code-indent-offset 2
        web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-comment-style 2
        web-mode-enable-auto-quoting nil
        web-mode-enable-html-entities-fontification t))

;; edit html tags as sexps
(use-package tagedit)

;; emmet expansion
(use-package emmet-mode
  :hook (html-mode web-mode css-mode)
  :config
  (setq emmet-move-cursor-between-quotes t))

;; sass
(use-package sass-mode)

;; sql
(use-package sql
  :hook (sql-interactive-mode-hook . (lambda () (toggle-truncate-lines t)))
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

;; format sql
(use-package sqlformat
  :config
  ;; (setq sqlformat-command 'pgformatter)
  ;; (setq sqlformat-args '("-s2" "-g"))
  (define-key sql-mode-map (kbd "C-c C-f") 'sqlformat))

;; json
(use-package json-mode
  :mode ("\\.json?\\'" . json-mode))

;; csv
(use-package csv-mode
  :hook (csv-mode . csv-align-mode))

;; yaml
(use-package yaml-mode)

;; ;; tf
;; (use-package terraform-mode)

;; ;; view log files
;; (use-package logview)
