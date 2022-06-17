;;; -*- lexical-binding: t -*-

;; speller
(use-package flyspell
  :bind (:map flyspell-mode-map
              ("C-c b s" . flyspell-buffer))
  :config
  (setq flyspell-sort-corrections t))

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
