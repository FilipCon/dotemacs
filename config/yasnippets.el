;;; -*- lexical-binding: t -*-

(use-package yasnippet
  :config
  ;; snippet directory
  (setq yas-snippet-dir '(yasnippet-snippets-dir
                          "~/.emacs.d/snippets"))
  (yas-reload-all)
  (yas-global-mode 1))

(use-package yasnippet-snippets :after yasnippet)
