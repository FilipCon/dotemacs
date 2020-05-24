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

(use-package dash) ;; dependency of cmake-ide

(use-package cmake-ide
  :after dash
  :config
  (cmake-ide-setup)
  (setq cmake-ide-make-command "make --no-print-directory"
        compilation-skip-threshold 2 ;; show only errors
        compilation-auto-jump-to-first-error t))


(defun cmake-ide/c-c++-hook ()
    (with-eval-after-load 'projectile
      (setq cmake-ide-project-dir (projectile-project-root))
      (setq cmake-ide-build-dir (concat cmake-ide-project-dir "build")))
    (cmake-ide-load-db))

(add-hook 'c-mode-common-hook #'cmake-ide/c-c++-hook)


;; If cmake-ide cannot find correct build dir, provide function to solve issue
(defun set-cmake-ide-build-dir()
  "Set build dir with CompileCommands.json"
  (interactive)
  (let ((dir (read-directory-name "Build dir:")))
    (setq cmake-ide-build-dir dir)))

;; (defun find-top-cmake (dir)
;;   "Find the highest level directory above DIR with a CMakeLists.txt file."
;;   (if (equal "/" dir)
;;       nil
;;     (if (find-top-cmake (file-truename (concat dir "/..")))
;;         (find-top-cmake (file-truename (concat dir "/..")))
;;       (if (member "CMakeLists.txt" (directory-files dir))
;;           dir
;;         nil))))

;; (defun cmake-ide-guess-dirs ()
;;   "Guess the current CMake project directory.
;; Will set the build and project directories accordingly.
;; Uses the highest level directory above the current one
;; containing a CMakeLists.txt file."
;;   (interactive)
;;   (setq cmake-ide-project-dir (find-top-cmake default-directory))
;;   (setq cmake-ide-build-dir (concat (file-name-as-directory (find-top-cmake default-directory)) "build")))



(use-package cmake-mode
  :mode ("CMakeLists\\.txt\\'" "\\.cmake\\'"))

(use-package cmake-font-lock
  :after (cmake-mode)
  :hook (cmake-mode . cmake-font-lock-activate))


;; (use-package rtags
;;   :config (progn (setq rtags-autostart-diagnostics nil)
;;                  (setq rtags-completions-enabled t)
;;                  ;; (require 'company)
;;                  (push 'company-rtags company-backends)
;;                  (add-hook 'c-mode-hook 'rtags-start-process-unless-running)
;;                  (add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
;;                  (add-hook 'objc-mode-hook 'rtags-start-process-unless-running)
;;                  ;;
;;                  (define-key c-mode-base-map (kbd "M-.") #'rtags-find-symbol-at-point)
;;                  (define-key c-mode-base-map (kbd "M-,") #'rtags-location-stack-back)
;;                  ;; (define-key c-mode-base-map (kbd "M->") #'rtags-find-references-at-point)
;;                  ;; (define-key c-mode-base-map (kbd "M-;") #'rtags-find-file)
;;                  ;; (define-key c-mode-base-map (kbd "C-.") #'rtags-find-symbol)
;;                  ;; (define-key c-mode-base-map (kbd "C-,") #'rtags-find-references)
;;                  ;; (define-key c-mode-base-map (kbd "C-<") #'rtags-find-virtuals-at-point)
;;                  ;; (define-key c-mode-base-map (kbd "M-i") #'rtags-imenu)
;;                  ))

(use-package clang-format
             :config
             ;; (global-set-key (kbd "C-c i") 'clang-format-region)
             ;; (global-set-key (kbd "C-c u") 'clang-format-buffer)
             (setq clang-format-style-option "file"))

;; show output (assembly code) of compiler
(use-package rmsbolt)
;; (use-package disaster)

;; debugger front-end
(use-package realgud)

(use-package modern-cpp-font-lock
  :config (add-hook 'c++-mode-hook #'modern-c++-font-lock-mode))


;;; eldoc
(use-package eldoc
  :diminish eldoc-mode)

;; remove binding. i use it for centaur tabs
(define-key c++-mode-map (kbd "C-c C-b") nil)
