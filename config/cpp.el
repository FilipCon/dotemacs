;;; -*- lexical-binding: t -*-

;; cmake files
(use-package cmake-mode
  :straight (:host github :repo "emacsmirror/cmake-mode"
                   :files (:defaults "*"))
  :mode (("CMakeLists\\.txt\\'" . cmake-mode)
         ("\\.cmake\\'" . cmake-mode)))

(use-package cmake-font-lock)

;; c++ hook settings
(defun ds/c++-hook ()
  (c-set-offset 'substatement-open 0) ;; close statement
  (c-set-offset 'arglist-intro '+)    ;; long argument names
  (setq c++-tab-always-indent t
        c-basic-offset 4
        c-indent-level 4
        tab-width 4
        indent-tabs-mode nil
        hide-ifdef-mode t))
(add-hook 'c-mode-common-hook 'ds/c++-hook)

;; font-lock for modern c++
(use-package modern-cpp-font-lock
  :hook (c++-mode . modern-c++-font-lock-mode))

;; cmake project
(use-package cmake-ide
  :hook (c++-mode . my/cmake-ide-find-project)
  :preface
  (defun my/cmake-ide-find-project ()
    (with-eval-after-load 'projectile
      (setq cmake-ide-project-dir (projectile-project-root))
      (setq cmake-ide-build-dir (concat cmake-ide-project-dir "build")))
    (cmake-ide-load-db))
  :config
  ;; If cmake-ide cannot find correct build dir, provide function to solve issue
  (defun set-cmake-ide-project-dir()
    (interactive)
    (let ((dir (read-directory-name "Project dir:")))
      (setq cmake-ide-project-dir dir)
      (setq cmake-ide-build-dir (concat cmake-ide-project-dir "build")))
    (cmake-ide-run-cmake))
  (setq cmake-ide-make-command "make --no-print-directory -j8"
        compilation-skip-threshold 1 ;; warnings and errors
        compilation-auto-jump-to-first-error t)
  (put 'cmake-ide-build-dir 'safe-local-variable #'stringp)
  :bind (("C-c m" . cmake-ide-compile)
         ("C-c r" . cmake-ide-run-cmake)))

;; switch between header/source
(use-package cff
  :config
  (add-hook 'c-mode-common-hook
            '(lambda ()
               (define-key c-mode-base-map (kbd "M-o") 'cff-find-other-file))))

;; ;; assembly code
;; (use-package rmsbolt)

(use-package company-c-headers)
