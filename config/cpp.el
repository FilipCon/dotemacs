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
             :config
             ;; (cmake-ide-setup)
             (setq cmake-ide-make-command "make --no-print-directory -j4"
                   compilation-skip-threshold 2 ;; show only errors
                   compilation-auto-jump-to-first-error t) ;; go to first error
             :bind ("C-c m c" . cmake-ide-compile))

;; make sure cmake-mode is installed for viewing CMake files
(use-package cmake-mode)

(use-package clang-format
             :config
             ;; (global-set-key (kbd "C-c i") 'clang-format-region)
             ;; (global-set-key (kbd "C-c u") 'clang-format-buffer)
             (setq clang-format-style-option "file"))
