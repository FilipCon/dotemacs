;;; -*- lexical-binding: t -*-

;; configure packages
(setq package-archives '(("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

;; Make startup faster
(setq package-enable-at-startup nil
      file-name-handler-alist nil
      message-log-max 16384
      gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6
      auto-window-vscroll nil
      package--init-file-ensured t
      read-process-output-max (* 1024 1024))

;; Straight
(setq straight-use-package-by-default t)
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

;; doom vars and functions for autoconfiguring company backends
(load (concat (expand-file-name user-emacs-directory) "company-backends.el"))

;; Load all files from my ~/.emacs.d/config directory
;; It doesn't support nested dirs
(dolist
    (file
     (directory-files
      (concat (expand-file-name user-emacs-directory) "config")
      t
      "^.[^#].+el$"))
  (load-file file))

(require 'server)
;; `server-running-p' doesn't work.
;; (unless (server-running-p) (server-start))
(defun server-started-p ()
    "Return non-nil if this Emacs has a server started."
    (bound-and-true-p server-process))
(unless (server-started-p)
  (server-start))

;; Load automatically generated custom garbage
(setq custom-file
      (concat (file-name-directory user-init-file) "custom-variables.el"))
(when (file-exists-p custom-file)
  (load custom-file))
