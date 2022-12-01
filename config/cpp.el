;;; -*- lexical-binding: t -*-

;; cmake files
(use-package cmake-mode
  :straight (:host github :repo "emacsmirror/cmake-mode"
                   :files (:defaults "*"))
  :mode (("CMakeLists\\.txt\\'" . cmake-mode)
         ("\\.cmake\\'" . cmake-mode)))

;; font lock for cmake
(use-package cmake-font-lock)

;; ;; assembly code
;; (use-package rmsbolt)
