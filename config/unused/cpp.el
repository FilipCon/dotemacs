;;; -*- lexical-binding: t -*-

;; cmake files
(use-package cmake-mode
  :straight (:host github :repo "emacsmirror/cmake-mode"
                   :files (:defaults "*"))
  :mode (("CMakeLists\\.txt\\'" . cmake-mode)
         ("\\.cmake\\'" . cmake-mode)))

;; font lock for cmake
(use-package cmake-font-lock)

;; (define-key 'c++-mode-map (kbd "TAB") nil)

(defun my-c++-mode-hook ()
  (setq c-basic-offset 4)
  (setq c-indent-level 4)
  (setq c-default-style "linux")
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'inline-open '0))

(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(add-hook 'c++-mode-hook (lambda () (electric-indent-local-mode -1)))

;; switch between header/source
(use-package cff
  :config
  (add-hook 'c-mode-common-hook
            #'(lambda ()
                (define-key c-mode-base-map (kbd "C-c M-o") 'cff-find-other-file))))

(require 'ansi-color)
(defun endless/colorize-compilation ()
  "Colorize from `compilation-filter-start' to `point'."
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region
     compilation-filter-start (point))))

(add-hook 'compilation-filter-hook
          #'endless/colorize-compilation)

;; ;; assembly code
;; (use-package rmsbolt)
