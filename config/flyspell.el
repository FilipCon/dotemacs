;; speller
(use-package flyspell
  :bind (:map flyspell-mode-map
              ("C-c b s" . flyspell-buffer))
  :config
  (setq flyspell-sort-corrections t))

;; show correction options
(use-package flyspell-correct-popup)
(use-package flyspell-correct
  :bind (:map flyspell-mode-map
              ("C-." . flyspell-correct-at-point))
  :init
  (unbind-key "C-;" flyspell-mode-map))

;; (use-package jinx)
