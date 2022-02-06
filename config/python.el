;;; -*- lexical-binding: t -*-

(use-package python
  :bind (:map python-mode-map
              ("C-c M-j" . run-python)) ; "jack-in"
  ;; Remove guess indent python message
  :custom (python-indent-guess-indent-offset-verbose nil)
  :config
  (setq python-shell-interpreter "ipython3"
        python-shell-interpreter-args "-i --simple-prompt --pprint"))

(use-package elpy
  :bind (:map elpy-mode-map
              ("C-c C-g" . elpy-shell-send-codecell)
              ("C-c C-k" . elpy-shell-send-buffer)
              ("C-c C-e" . elpy-shell-send-statement))
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
        elpy-shell-starting-directory 'current-directory
        elpy-rpc-python-command "python3"
        elpy-shell-echo-output nil))

;;; See https://python-poetry.org/ for more info
;;; See https://python-poetry.org/docs/managing-environments/ for virtual envs management
(use-package poetry
  :config
  (setq poetry-tracking-strategy 'switch-buffer)
  (setenv "WORKON_HOME" (expand-file-name "~/.cache/pypoetry/virtualenvs")))

;; numpy docstring for python
(use-package numpydoc
  :custom
  (numpydoc-insert-examples-block nil)
  (numpydoc-template-long nil))

;; (use-package python-black
;;   :after python
;;   :hook (python-mode . python-black-on-save-mode-enable-dwim))

;; ;; Buffer formatting on save
;; (use-package yapfify
;;   :diminish yapf-mode
;;   :hook (python-mode . yapf-mode))

;; ;; write code documentation
;; (use-package sphinx-doc
;;   :hook (python-mode . sphinx-doc-mode))

;; ;; jupyter kernel
;; (use-package jupyter)

;; ;; jupyter notebooks
;; (use-package ein
;;   :config
;;   (setq ein:use-auto-complete-superpack t
;;         ein:output-type-preference '(emacs-lisp svg png jpeg html
;;                                                 text latex javascript)))

;; (use-package py-isort)

;; (use-package pyvenv)
