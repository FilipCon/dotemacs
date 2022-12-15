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

;; json
(use-package json-mode)

;; csv
(use-package csv-mode
  :hook (csv-mode . csv-align-mode))

;; yaml
(use-package yaml-mode)

;; tf
(use-package terraform-mode)

;; ;; view log files
;; (use-package logview)
