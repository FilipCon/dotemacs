;; Prot's themes
(use-package modus-themes
  :straight (:type built-in)
  :bind ("<f5>" . modus-themes-toggle)
  :init
  (setq modus-themes-bold-constructs t
        modus-themes-common-palette-overrides
        '((builtin blue-cooler)
          ;; (comment yellow-faint)
          ;; (constant blue-cooler)
          ;; (docstring green-faint)
          ;; (docmarkup magenta-faint)
          ;; (fnname blue-cooler)
          ;; (keyword cyan)
          ;; (preprocessor cyan-cooler)
          ;; (type magenta-cooler)
          ;; (variable blue-warmer)
          ;; (rx-construct magenta-warmer)
          ;; (rx-backslash blue-cooler)
          (string green-cooler)))
  (load-theme 'modus-vivendi t)) ; dark

;; hide minor modes in modeline
(use-package minions
  :config
  (minions-mode t))
