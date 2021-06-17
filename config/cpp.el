;;; -*- lexical-binding: t -*-

;; cmake files
(use-package cmake-mode
  :straight (:host github :repo "emacsmirror/cmake-mode"
                   :files (:defaults "*"))
  :mode (("CMakeLists\\.txt\\'" . cmake-mode)
         ("\\.cmake\\'" . cmake-mode))
  :config
  (set-company-backend! 'cmake-mode
    '(company-cmake company-capf company-yasnippet)))

;; font lock for cmake
(use-package cmake-font-lock)

;; switch between header/source
(use-package cff
  :config
  (add-hook 'c-mode-common-hook
            '(lambda ()
               (define-key c-mode-base-map (kbd "C-x o") 'cff-find-other-file))))

;; assembly code
(use-package rmsbolt)
