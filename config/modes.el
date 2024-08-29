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
