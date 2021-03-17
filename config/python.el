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
  (unbind-key "C-c C-f" elpy-mode-map)
  (unbind-key "C-c C-r" elpy-mode-map)
  ;; (unbind-key "C-c C-c" elpy-mode-map)
  (setq elpy-modules nil
        elpy-shell-echo-input nil
        elpy-shell-starting-directory (quote current-directory)
        python-shell-interpreter "ipython3"
        python-shell-interpreter-args "-i --simple-prompt --pprint"
        elpy-rpc-python-command "python3"
        elpy-shell-echo-output nil))

;; ;; use microsoft lsp
;; (use-package lsp-python-ms)

;; write code documentation
(use-package sphinx-doc
  :hook (python-mode . sphinx-doc-mode))

;; ;; jupyter kernel
;; (use-package jupyter)

;; ;; jupyter notebooks
;; (use-package ein
;;   :config
;;   (setq ein:use-auto-complete-superpack t
;;         ein:output-type-preference '(emacs-lisp svg png jpeg html
;;                                                 text latex javascript)))
;; (use-package lsp-jedi
;;   :init
;;   (setq lsp-jedi-trace-server "off")
;;   (setq lsp-jedi-diagnostics-enable nil)
;;   :config
;;   (with-eval-after-load "lsp-mode"
;;     (add-to-list 'lsp-disabled-clients 'pyls)
;;     (add-to-list 'lsp-enabled-clients 'jedi)))



;; (use-package py-isort)

;; (use-package poetry)

;; (use-package pyvenv)
