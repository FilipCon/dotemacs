;;; -*- lexical-binding: t -*-

;; Reset after early-init
(setq gc-cons-threshold 100000000       ; for safety, gcmh will correct it
      gc-cons-percentage 0.1)

;; Straight bootstrap
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; use-package
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; Load all files from my `~/.emacs.d/config' directory
;; It doesn't support nested dirs
(dolist
    (file
     (directory-files
      (concat (expand-file-name user-emacs-directory) "config")
      t
      "^.[^#].+el$"))
  (load-file file))

;; init emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

;; dispose automatically generated custom garbage
(setq custom-file (make-temp-file "emacs-custom-"))
