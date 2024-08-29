;; json
(use-package json-mode)

;; csv
(use-package csv-mode)

;; yaml
(use-package yaml-mode
  :hook ((yaml-mode . highlight-indentation-mode)
         (yaml-mode . indent-tools-minor-mode)))

;; tf
(use-package terraform-mode)

;; Code format
;; format different source code files extremely intelligently
;; https://github.com/radian-software/apheleia
;; uses .prettierrc from the repository root
(use-package apheleia
  :ensure apheleia
  :diminish ""
  :defines
  apheleia-formatters
  apheleia-mode-alist
  :functions
  apheleia-global-mode
  :config
  (setf (alist-get 'prettier-json apheleia-formatters)
        '("prettier" "--stdin-filepath" filepath))
  ;; (apheleia-global-mode +1)
  )

;; code style
(use-package editorconfig
  :config
  (setq editorconfig-trim-whitespaces-mode 'ws-butler-mode)
  (editorconfig-mode 1))
