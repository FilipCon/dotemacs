;; The markdown mode is awesome! unbeatable
(use-package markdown-mode
  :mode (("README\\(?:\\.md\\)?\\'" . gfm-mode)
         ("\\.md\\'" . gfm-mode)
         ("\\.markdown\\'" . gfm-mode))
  :init
  (advice-add #'markdown--command-map-prompt :override #'ignore)
  (advice-add #'markdown--style-map-prompt   :override #'ignore)
  :custom
  (markdown-gfm-additional-languages '("sh"))
  (markdown-open-command "xdg-open")
  (markdown-enable-math t)
  (markdown-command "pandoc")
  (markdown-header-scaling t)
  (markdown-enable-wiki-links t)
  (markdown-italic-underscore t)
  (markdown-asymmetric-header t)
  (markdown-gfm-uppercase-checkbox t)
  (markdown-fontify-code-blocks-natively t))

(use-package mermaid-mode)

;; (use-package impatient-mode)

;; (use-package grip-mode
;;   ;; :config (setq grip-use-mdopen t) ;; to use `mdopen` instead of `grip`
;;   :hook ((markdown-mode org-mode) . grip-mode))
