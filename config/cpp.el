;;; -*- lexical-binding: t -*-

(require 'cc-mode)

(defun ds/c++-hook ()
  ;; (linum-mode)
  (c-set-offset 'substatement-open 0) ;; close statement
  (c-set-offset 'arglist-intro '+)    ;; long argument names
  ;; (modify-syntax-entry ?_ "w")  ; Treat underscore as a word char in C.
  (setq c++-tab-always-indent t
        c-basic-offset 4
        c-indent-level 4
        tab-width 4
        indent-tabs-mode nil
        hide-ifdef-mode t)
  (flyspell-prog-mode))
(add-hook 'c-mode-common-hook 'ds/c++-hook)

(use-package cmake-ide
  :after dash
  :config
  (use-package dash) ;; dependency of cmake-ide
  ;; (cmake-ide-setup)
  (setq cmake-ide-make-command "make --no-print-directory -j6"
        compilation-skip-threshold 2 ;; show only errors
        compilation-auto-jump-to-first-error t)
  :bind ("C-c m" . cmake-ide-compile))


;; (defun cmake-ide/c-c++-hook ()
;;     (with-eval-after-load 'projectile
;;       (setq cmake-ide-project-dir (projectile-project-root))
;;       (setq cmake-ide-build-dir (concat cmake-ide-project-dir "build")))
;;     (cmake-ide-load-db))
;; (add-hook 'c-mode-common-hook #'cmake-ide/c-c++-hook)

(use-package cmake-mode
  :mode ("CMakeLists\\.txt\\'" "\\.cmake\\'"))

(use-package cmake-font-lock
  :after (cmake-mode)
  :hook (cmake-mode . cmake-font-lock-activate))

;; (use-package modern-cpp-font-lock
;;   :config (add-hook 'c++-mode-hook #'modern-c++-font-lock-mode))

;; clang-format
(use-package clang-format
  :config
  (setq clang-format-style-option "file")
  (defun clang-format-auto ()
    (interactive)
    (if mark-active
        (call-interactively 'clang-format-region)
      (clang-format-buffer)))
  (define-key c-mode-base-map (kbd "C-c f") (function clang-format))
  (define-key c-mode-base-map (kbd "C-c C-f") (function clang-format-auto)))

;; switch between header/source
(use-package  cff
  :config
  (add-hook 'c-mode-common-hook
            '(lambda ()
               (define-key c-mode-base-map (kbd "M-o") 'cff-find-other-file))))

;; assembly code
;; (use-package rmsbolt)
;; (use-package disaster)

;; ;; debugger front-end
;; (use-package realgud)

;; ;;; eldoc
;; (use-package eldoc
;;   :diminish eldoc-mode)
