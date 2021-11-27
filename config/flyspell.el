;;; -*- lexical-binding: t -*-

;; speller
(use-package flyspell
  :bind (:map flyspell-mode-map
              ("C-c b s" . flyspell-buffer))
  :config
  (setq flyspell-sort-corrections t
        ispell-program-name "aspell"))

;; show correction options
(use-package flyspell-correct
  :after flyspell
  :hook ((text-mode . flyspell-mode)
         (prog-mode . flyspell-prog-mode))
  :bind (:map flyspell-mode-map
              ("C-." . flyspell-correct-wrapper))
  :init
  (use-package flyspell-correct-popup)
  (unbind-key "C-;" flyspell-mode-map))

;; (use-package writegood-mode
;; ;; :config
;; ;; (global-set-key "\C-c\C-gg" 'writegood-grade-level)
;; ;; (global-set-key "\C-c\C-ge" 'writegood-reading-ease)
;;   )

;; ;; languagetool
;; (use-package langtool
;;   :config
;;   (setq langtool-java-classpath
;;         "/home/filipkon/Software/languagetool/*")
;;   :bind ("C-c b l" . langtool-check-buffer))

;; ;; word definition
;; (use-package define-word)

;; ;;synonyms
;; (use-package synosaurus
;;   :config (synosaurus-mode 1))
