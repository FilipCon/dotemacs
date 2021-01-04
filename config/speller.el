;;; -*- lexical-binding: t -*-

(use-package flycheck
  :init
  (define-fringe-bitmap 'flycheck-fringe-indicator
    (vector #b0000000000000000
        #b0000000000000000
        #b0000000000000000
        #b0000000000000000
        #b0000000000000000
        #b1111111111111111
        #b1111111111111111
        #b1111111111111111
        #b1111111111111111
        #b1111111111111111
        #b1111111111111111
        #b0000000000000000
        #b0000000000000000
        #b0000000000000000
        #b0000000000000000
        #b0000000000000000
        #b0000000000000000) nil 16)
  :hook (prog-mode . flycheck-mode)
  :custom (flycheck-indication-mode 'right-fringe)
  :config
  (flycheck-define-error-level 'error
                   :severity 2
                   :overlay-category 'flycheck-error-overlay
                   :fringe-bitmap 'flycheck-fringe-indicator
                   :fringe-face 'flycheck-fringe-error)
  (flycheck-define-error-level 'warning
                   :severity 1
                   :overlay-category 'flycheck-warning-overlay

                   :fringe-bitmap 'flycheck-fringe-indicator
                   :fringe-face 'flycheck-fringe-warning)
  (flycheck-define-error-level 'info
                   :severity 0
                   :overlay-category 'flycheck-info-overlay
                   :fringe-bitmap 'flycheck-fringe-indicator
                   :fringe-face 'flycheck-fringe-info))

;; speller
(use-package flyspell
  :config
  (setq flyspell-sort-corrections t)
  (global-set-key (kbd "C-c b s") 'flyspell-buffer))

;; show correction options
(use-package flyspell-correct
  :after flyspell
  :hook ((text-mode . flyspell-mode)
         (prog-mode . flyspell-prog-mode))
  :bind (:map flyspell-mode-map ("C-." . flyspell-correct-wrapper))
  :init
  (use-package flyspell-correct-popup)
  (unbind-key "C-;" flyspell-mode-map))

;; languagetool
(use-package langtool
  :config
  (setq langtool-java-classpath
        "/home/filipkon/Software/languagetool/*")
  :bind ("C-c b l" . langtool-check-buffer))

;; word definition
(use-package define-word)

;;synonyms
(use-package synosaurus
  :config (synosaurus-mode 1))
