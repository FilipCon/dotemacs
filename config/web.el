;; basic web mode settings
(use-package web-mode
  :straight t
  :mode (("\\.html" . web-mode))
  :hook ((web-mode . flymake-mode))
  :config
  (setq web-mode-block-padding 2
        web-mode-code-indent-offset 2
        web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-comment-style 2
        web-mode-enable-auto-quoting nil
        web-mode-enable-html-entities-fontification t
        web-mode-enable-css-colorization t
        web-mode-enable-auto-pairing t
        web-mode-enable-comment-keywords t
        web-mode-enable-current-element-highlight t
        web-mode-enable-auto-indentation nil))

;; emmet expansion
(use-package emmet-mode
  :hook (web-mode . emmet-mode)
  :config
  (setq emmet-move-cursor-between-quotes t))

;; sass
(use-package sass-mode)

;; ;; view log files
;; (use-package logview)
