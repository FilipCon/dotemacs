;;; -*- lexical-binding: t -*-

;; elpy
(use-package elpy
  :bind ("C-c C-g" . elpy-shell-send-codecell)
  :init
  (setq elpy-shell-cell-boundary-regexp
        "^\\(?:##.*\\|#\\s-*<.+>\\|#\\s-*\\(?:In\\|Out\\)\\[.*\\]:\\|#\\s-*%%.*\\)\\s-*$"
        elpy-shell-codecell-beginning-regexp
        "^\\(?:##.*\\|#\\s-*<.+>\\|#\\s-*\\(?:In\\|Out\\)\\[.*\\]:\\|#\\s-*%%.*\\)\\s-*$")
  (elpy-enable)
  :config
  (unbind-key "C-<return>" elpy-mode-map)
  (setq elpy-modules nil
        elpy-shell-starting-directory (quote current-directory)
        python-shell-interpreter "ipython3"
        python-shell-interpreter-args "-i --simple-prompt --pprint"
        elpy-rpc-python-command "python3"
        python-shell-prompt-detect-failure-warning nil))

;; code documentation
(use-package sphinx-doc
  :hook (python-mode . sphinx-doc-mode))

;; jupyter
(use-package ein
  :config
  (setq ein:use-auto-complete-superpack t
        ein:output-type-preference '(emacs-lisp svg png jpeg html
                                                text latex javascript)))
;; (use-package lsp-jedi
;;   :init
;;   (setq lsp-jedi-trace-server "off")
;;   (setq lsp-jedi-diagnostics-enable nil
;;         lsp-jedi-completion-disable-snippets t)
;;   :config
;;   (with-eval-after-load "lsp-mode"
;;     (add-to-list 'lsp-disabled-clients 'pyls)
;;     (add-to-list 'lsp-enabled-clients 'jedi)))

;;(use-package lsp-pyright)

;; (use-package lsp-python-ms
;;   :init (setq lsp-python-ms-auto-install-server t)
;;     :config
;;   (with-eval-after-load "lsp-mode"
;;     (add-to-list 'lsp-disabled-clients 'pyls)
;;     (add-to-list 'lsp-enabled-clients 'mspyls)))

(use-package poetry)

(use-package pyvenv)
