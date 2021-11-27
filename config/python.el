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
        elpy-shell-echo-input nil
        elpy-shell-starting-directory (quote current-directory)
        python-shell-interpreter "ipython3"
        python-shell-interpreter-args "-i --simple-prompt --pprint"
        elpy-rpc-python-command "python3"
        elpy-shell-echo-output nil))

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

;; (use-package py-isort)

;; (use-package poetry)

;; (use-package pyvenv)
