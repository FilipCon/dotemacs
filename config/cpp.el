;;; -*- lexical-binding: t -*-

;; (defun ds/c++-hook ()
;;   ;; (linum-mode)
;;   (c-set-offset 'substatement-open 0) ;; close statement
;;   (c-set-offset 'arglist-intro '+)    ;; long argument names
;;   (setq c++-tab-always-indent t
;;         c-basic-offset 4
;;         c-indent-level 4
;;         tab-width 4
;;         indent-tabs-mode nil)
;;   (flyspell-prog-mode))
;; (add-hook 'c-mode-common-hook 'ds/c++-hook)

(use-package cmake-ide
  :after dash
  :config
  (cmake-ide-setup)
  (setq cmake-ide-make-command "make --no-print-directory"
        compilation-skip-threshold 2 ;; show only errors
        compilation-auto-jump-to-first-error t))

;; make sure cmake-mode is installed for viewing CMake files
(use-package cmake-mode)
(use-package dash) ;; dependency of cmake-ide

(use-package rtags
  :config (progn (setq rtags-autostart-diagnostics nil)
                 (setq rtags-completions-enabled t)
                 ;; (require 'company)
                 (push 'company-rtags company-backends)
                 (add-hook 'c-mode-hook 'rtags-start-process-unless-running)
                 (add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
                 (add-hook 'objc-mode-hook 'rtags-start-process-unless-running)
                 ;;
                 (define-key c-mode-base-map (kbd "M-.") #'rtags-find-symbol-at-point)
                 (define-key c-mode-base-map (kbd "M-,") #'rtags-location-stack-back)
                 ;; (define-key c-mode-base-map (kbd "M->") #'rtags-find-references-at-point)
                 ;; (define-key c-mode-base-map (kbd "M-;") #'rtags-find-file)
                 ;; (define-key c-mode-base-map (kbd "C-.") #'rtags-find-symbol)
                 ;; (define-key c-mode-base-map (kbd "C-,") #'rtags-find-references)
                 ;; (define-key c-mode-base-map (kbd "C-<") #'rtags-find-virtuals-at-point)
                 ;; (define-key c-mode-base-map (kbd "M-i") #'rtags-imenu)
                 ))

(use-package clang-format
             :config
             ;; (global-set-key (kbd "C-c i") 'clang-format-region)
             ;; (global-set-key (kbd "C-c u") 'clang-format-buffer)
             (setq clang-format-style-option "file"))
