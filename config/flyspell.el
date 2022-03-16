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
  :bind ("<f6>" . flyspell-mode)
  :init
  (use-package flyspell-correct-popup)
  (unbind-key "C-;" flyspell-mode-map))
