;;; -*- lexical-binding: t -*-

(use-package yasnippet
  :after company company-fuzzy
  :defer t
  :config

  ;; snippet directory
  (setq yas-snippet-dir '(yasnippet-snippets-dir
                          "~/.emacs.d/snippets"))

  ;; Adding yasnippet support to company
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-yasnippet))
  (yas-reload-all)
  (yas-global-mode 1))

(use-package yasnippet-snippets :after yasnippet)
;; (use-package yasnippet-classic-snippets :after yasnippet)
