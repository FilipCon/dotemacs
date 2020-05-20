;;; -*- lexical-binding: t -*-

;; (defun vj/terminal-in-project-root (arg)
;;   (interactive "P")
;;   (let ((default-directory
;; 	    (if arg default-directory
;; 	      (projectile-project-root))))
;;     (start-process "terminal" nil (getenv "TERMINAL"))))

;; (global-set-key (kbd "C-x t") 'vj/terminal-in-project-root)

;; (if (not (eq system-type 'windows-nt))
;;     (use-package exec-path-from-shell
;;       :init
;;       (when (display-graphic-p)
;;         (exec-path-from-shell-initialize))
;;       :config
;;       ;;   (setq exec-path-from-shell-arguments '("-l"))
;;       (setq exec-path-from-shell-check-startup-files nil)))
