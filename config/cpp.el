;;; -*- lexical-binding: t -*-

(require 'cc-mode)
(use-package helm)

(defun ds/c++-hook ()
  ;; (linum-mode)
  (c-set-offset 'substatement-open 0) ;; close statement
  (c-set-offset 'arglist-intro '+)    ;; long argument names
  (modify-syntax-entry ?_ "w")  ; Treat underscore as a word char in C.
  (setq c++-tab-always-indent t
        c-basic-offset 4
        c-indent-level 4
        tab-width 4
        indent-tabs-mode nil))
(add-hook 'c-mode-hook 'ds/c++-hook)
(add-hook 'c++-mode-hook 'ds/c++-hook)

(use-package cmake-ide
  :after dash
  :config
  (use-package dash) ;; dependency of cmake-ide
  (cmake-ide-setup)
  (setq cmake-ide-make-command "make --no-print-directory -j6"
        compilation-skip-threshold 2 ;; show only errors
        compilation-auto-jump-to-first-error t)
  :bind ("C-c m" . cmake-ide-compile))


(defun cmake-ide/c-c++-hook ()
    (with-eval-after-load 'projectile
      (setq cmake-ide-project-dir (projectile-project-root))
      (setq cmake-ide-build-dir (concat cmake-ide-project-dir "build")))
    (cmake-ide-load-db))
(add-hook 'c-mode-hook #'cmake-ide/c-c++-hook)
(add-hook 'c++-mode-hook #'cmake-ide/c-c++-hook)


(use-package cmake-mode
  :mode ("CMakeLists\\.txt\\'" "\\.cmake\\'"))

(use-package cmake-font-lock
  :after (cmake-mode)
  :hook (cmake-mode . cmake-font-lock-activate))

;;; clang-format
(use-package clang-format
  :config
  (setq clang-format-style-option "file")
  (defun clang-format-auto ()
    (interactive)
    (if mark-active
      (call-interactively 'clang-format-region)
      (clang-format-buffer)))
  ;; (define-key c-mode-base-map (kbd "C-c C-f") (function clang-format))
  (define-key c-mode-base-map (kbd "C-c f") (function clang-format-auto)))

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

;;; To have cmake-ide automatically create a
;; compilation commands file in your project
;; root create a .dir-locals.el containing the following:
;;   ((nil . ((cmake-ide-build-dir . "<PATH_TO_PROJECT_BUILD_DIRECTORY>"))))

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


;;; cmake-ide + gdb/exec.
(defun run-process-in-comint (cmd)
  (let* ((name (format "Process: %s" cmd))
         (buf (set-buffer (generate-new-buffer name)))
         (proc nil)
         (line-- (make-string 80 ?-))
         (proc-sentinal-fn (lambda (proc evt)
                             (insert (format "%s\n%s -- %s\n%s\n" line-- evt (current-time-string) line--))))
         (comint-mode-result (comint-mode)))
    ;;
    (switch-to-buffer-other-window buf)
    ;;
    (insert (format "Starting: %s\n%s\n" (current-time-string) line--))
    (setq proc (start-process-shell-command name buf cmd))
    (set-process-sentinel proc (lambda (proc evt)
                                 (insert (format "==========\n%s -- (%s) %s\n"
                                                 evt
                                                 (process-exit-status proc)
                                                 evt (current-time-string)))))
    ;;
    proc))

(defun cmake-ide-find-exe-file ()
  (interactive)
  (let* ((exec-files (seq-filter 'file-executable-p
                                 (directory-files-recursively
                                  (cide--build-dir)
                                  ".*")))
         (base-buffer-name (file-name-base (buffer-name)))
         (calc-dist (lambda (fn) (cons fn
                                       (levenshtein-distance
                                        base-buffer-name
                                        (file-name-base fn)))))
         (cdr-< (lambda (a b) (< (cdr a) (cdr b))))
         (distances (sort (mapcar calc-dist exec-files) cdr-<))
         ;;(---- (message distances))
         (nearest (car (first distances))))
    (cons nearest exec-files)))

(defun cmake-ide-gdb-files-source ()
  "http://kitchingroup.cheme.cmu.edu/blog/2015/01/24/Anatomy-of-a-helm-source/"
  (interactive)
  (require 'seq)
  `((name . "Executable file to debug")
    (candidates . ,(cmake-ide-find-exe-file))
    (action . (lambda (sel)
                (gdb (read-from-minibuffer
                      "Cmd: " (format "%s %s" gud-gdb-command-name sel)))))))

(defun cmake-ide-helm-run-gdb ()
  (interactive)
  (helm :sources (cmake-ide-gdb-files-source)))

(define-key c-mode-base-map (kbd "C-c d")
  (function cmake-ide-helm-run-gdb))

(defun cmake-ide-run-files-source ()
  (interactive)
  (require 'seq)
  `((name . "Executable file")
    (candidates . ,(cmake-ide-find-exe-file))
    (action . (lambda (sel)
                (run-process-in-comint (read-from-minibuffer "Cmd: " sel))))))

(defun cmake-ide-helm-run-exe ()
  (interactive)
  (helm :sources (cmake-ide-run-files-source)))

(define-key c-mode-base-map (kbd "C-c x")
  (function cmake-ide-helm-run-exe))


;;; disaster
(use-package disaster)

(defun cmake-ide-objdump-disaster (file-name)
  (let* ((objdump-cmd (format "%s %s" disaster-objdump (shell-quote-argument file-name)))
         (buf (set-buffer (generate-new-buffer objdump-cmd))))
    (shell-command objdump-cmd buf)
    (read-only-mode)
    (asm-mode)
    (disaster--shadow-non-assembly-code)
    (switch-to-buffer-other-window buf)))

(defun cmake-ide-find-obj-files ()
  (interactive)
  (let* ((exec-files (seq-filter 'file-readable-p
                                 (directory-files-recursively
                                  (cide--build-dir) ".+\.o[bj]?$")))
         (base-buffer-name (file-name-base (buffer-name)))
         (calc-dist (lambda (fn) (cons fn
                                       (levenshtein-distance
                                        base-buffer-name
                                        (file-name-base fn)))))
         (cdr-< (lambda (a b) (< (cdr a) (cdr b))))
         (distances (sort (mapcar calc-dist exec-files) cdr-<)))
    (mapcar 'car distances)))

(defun cmake-ide-obj-files-source ()
  (interactive)
  (require 'seq)
  `((name . "Object file to objdump")
    (candidates . ,(cmake-ide-find-obj-files))
    (action . (lambda (sel) (cmake-ide-objdump-disaster sel)))))

(defun cmake-ide-objdump ()
  (interactive)
  (helm :sources (cmake-ide-obj-files-source)))

;; FILE ".dir-locals.el"
;; ((nil . ((cmake-ide-build-dir . "./build")
;; 	 (cmake-ide-cmake-opts . "-DCMAKE_BUILD_TYPE=Debug -GNinja"))))

(use-package  cff
  :config
;; defines shortcut for find source/header file for the current
;; file
(add-hook 'c++-mode-hook
           '(lambda ()
              (define-key c-mode-base-map (kbd "M-o") 'cff-find-other-file)))
(add-hook 'c-mode-hook
           '(lambda ()
              (define-key c-mode-base-map (kbd "M-o") 'cff-find-other-file))))
