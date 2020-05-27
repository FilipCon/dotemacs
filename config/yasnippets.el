;;; -*- lexical-binding: t -*-

(use-package yasnippet
  :defer t
  :config
  ;; see https://emacs.stackexchange.com/a/30150/11934
  (defun cpm/yas-org-mode-hook ()
    (setq-local yas-buffer-local-condition
            '(not (org-in-src-block-p t))))
  (add-hook 'org-mode-hook #'cpm/yas-org-mode-hook)

  ;; snippet directory
  ;; (setq yas-snippet-dirs '("~/.emacs.d/.local/snippets/cpm-snippets"
  ;;                          yasnippet-snippets-dir))
  ;; the official snippet collection https://github.com/AndreaCrotti/yasnippet-snippets
  (use-package yasnippet-snippets :after yasnippet :demand t)

  ;; Adding yasnippet support to company
  (with-eval-after-load 'company-mode
  (add-to-list 'company-backends '(company-yasnippet)))
  (yas-reload-all)
  (yas-global-mode 1))

(use-package yasnippet-snippets)
(use-package yasnippet-classic-snippets)
