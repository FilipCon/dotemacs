;;; -*- lexical-binding: t -*-

;; elpy
(use-package elpy
  :bind ("C-c C-g" . elpy-shell-send-codecell)
  :init
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
