;;; -*- lexical-binding: t -*-

;; The markdown mode is awesome! unbeatable
(use-package markdown-mode
  :mode (("README\\(?:\\.md\\)?\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :hook (markdown-mode . auto-fill-mode)
  :init
  (advice-add #'markdown--command-map-prompt :override #'ignore)
  (advice-add #'markdown--style-map-prompt   :override #'ignore)
  :custom
  (markdown-header-scaling t)
  (markdown-enable-wiki-links t)
  (markdown-italic-underscore t)
  (markdown-asymmetric-header t)
  (markdown-gfm-uppercase-checkbox t)
  (markdown-fontify-code-blocks-natively t))

;; (use-package markdown-preview-eww)

;; ;; Generate table of contents for markdown-mode
;; (use-package markdown-toc
;;   :after markdown-mode
;;   :bind (:map markdown-mode-command-map
;;               ("r" . markdown-toc-generate-or-refresh-toc)))
