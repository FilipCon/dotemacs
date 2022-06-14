;;; -*- lexical-binding: t -*-

(use-package exec-path-from-shell
  :init
  (when (display-graphic-p)
    (exec-path-from-shell-copy-env "LD_LIBRARY_PATH")
    (exec-path-from-shell-initialize))
  :config
  (setq exec-path-from-shell-check-startup-files nil)
  (setq exec-path-from-shell-variables
        '("PATH" "MANPATH" "SSH_AUTH_SOCK")))

;; eshell history suggestions
(use-package esh-autosuggest
  :hook (eshell-mode . esh-autosuggest-mode))

;; eshell completions
(use-package pcmpl-args)
