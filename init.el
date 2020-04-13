;;; -*- lexical-binding: t -*-

(require 'cl)
(require 'cl-lib)

;; Configure package.el
(require 'package)
(setq package-archives '(("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; (defvar file-name-handler-alist-old file-name-handler-alist)

;; ;; Make startup faster
;; (setq package-enable-at-startup nil
;;       file-name-handler-alist nil
;;       message-log-max 16384
;;       gc-cons-threshold 402653184
;;       gc-cons-percentage 0.6
;;       auto-window-vscroll nil
;;       package--init-file-ensured t)

;; (add-hook 'after-init-hook
;;           `(lambda ()
;;              (setq file-name-handler-alist file-name-handler-alist-old
;;                    ;;gc-cons-threshold 800000
;;                    ;; gc-cons-percentage 0.1
;; 		   )) t)

;; Straight
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

;;On-demand installation of packages
(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
      (if (or (assoc package package-archive-contents) no-refresh)
          (if (boundp 'package-selected-packages)
              ;; Record this as a package the user installed explicitly
              (package-install package nil)
              (package-install package))
          (progn
            (package-refresh-contents)
            (require-package package min-version t)))))

;; load config settings
(org-babel-load-file "~/.emacs.d/config.org" t)

;; Load automatically generated custom garbage
;; add directory to load-path
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(provide 'init)


