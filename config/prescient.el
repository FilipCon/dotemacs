;;; -*- lexical-binding: t -*-

(use-package prescient
  :config
  (setq-default prescient-filter-method
                '(literal regexp initialism)
                prescient-save-file
                (concat user-emacs-directory ".cache/prescient-save.el")))
