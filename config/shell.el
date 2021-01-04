;;; -*- lexical-binding: t -*-

(if (not (eq system-type 'windows-nt))
    (use-package exec-path-from-shell
      :init
      (when (display-graphic-p)
        (exec-path-from-shell-copy-env "LD_LIBRARY_PATH")
        (exec-path-from-shell-initialize))
      :config
      (setq exec-path-from-shell-check-startup-files nil)))

(use-package vterm)
