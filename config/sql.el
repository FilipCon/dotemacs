;;; -*- lexical-binding: t -*-

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

;; sql linter (requires sqlfluff on system)
(use-package flymake-sqlfluff
  :hook ((sql-mode . flymake-sqlfluff-load))
  :straight (flymake-sqlfluff
             :type git
             :host github
             :repo "erickgnavar/flymake-sqlfluff"))
