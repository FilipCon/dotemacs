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
  :mode (("\\.html?\\'" . web-mode )))

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
  (set-company-backend! 'sass-mode '(company-capf company-yasnippet
                                                  company-css))
  (set-company-backend! '(company-capf company-yasnippet
                                       web-mode company-css company-web-html))
  (set-company-backend! '(company-capf company-yasnippet
                                       pug-mode company-web-jade))
  (set-company-backend! '(company-capf company-yasnippet
                                       slim-mode company-web-slim)))
