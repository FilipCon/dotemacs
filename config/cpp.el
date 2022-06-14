;;; -*- lexical-binding: t -*-

;; cmake files
(use-package cmake-mode
  :straight (:host github :repo "emacsmirror/cmake-mode"
                   :files (:defaults "*"))
  :mode (("CMakeLists\\.txt\\'" . cmake-mode)
         ("\\.cmake\\'" . cmake-mode)))

;; font lock for cmake
(use-package cmake-font-lock)

(with-eval-after-load 'lsp-mode
  ;; switch between header/source
  (define-key c-mode-base-map (kbd "C-x M-o") #'lsp-clangd-find-other-file)
  (setq lsp-clients-clangd-args
        '("--compile-commands-dir=build"
          "--clang-tidy" "--suggest-missing-includes"
          "--header-insertion=never"
          "--all-scopes-completion=true"
          "-j=2" "--background-index" "--log=error")))

;; ;; assembly code
;; (use-package rmsbolt)
