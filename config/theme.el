;;; -*- lexical-binding: t -*-

;; theme
(use-package doom-themes
  :custom-face
  (ediff-fine-diff-Ancestor                 ((t (:background "#74140f"))))
  (ediff-fine-diff-A                        ((t (:background "#74140f"))))
  (ediff-fine-diff-B                        ((t (:background "#4b5332"))))
  (ediff-fine-diff-C                        ((t (:background "#525252"))))
  (ediff-current-diff-Ancestor              ((t (:background "#551b1e"))))
  (ediff-current-diff-A                     ((t (:background "#551b1e"))))
  (ediff-current-diff-B                     ((t (:background "#39422a"))))
  (ediff-current-diff-C                     ((t (:background "#3D3D48"))))

  (ediff-even-diff-Ancestor                 ((t (:background "#333333"))))
  (ediff-even-diff-A                        ((t (:background "#333333"))))
  (ediff-even-diff-B                        ((t (:background "#333333"))))
  (ediff-even-diff-C                        ((t (:background "#333333"))))
  (ediff-odd-diff-Ancestor                  ((t (:background "#333333"))))
  (ediff-odd-diff-A                         ((t (:background "#333333"))))
  (ediff-odd-diff-B                         ((t (:background "#333333"))))
  (ediff-odd-diff-C                         ((t (:background "#333333"))))

  :config
  (doom-themes-visual-bell-config)      ; Enable flashing mode-line on errors
  (doom-themes-treemacs-config)
  (doom-themes-org-config)
  ;; (load-theme 'doom-solarized-light t)
  (load-theme 'doom-vibrant t))

;; make modeline pretty
(use-package doom-modeline
  :hook (after-init . doom-modeline-init))

;; all the icons
(use-package all-the-icons)
(use-package all-the-icons-ibuffer
  :after all-the-icons
  :hook (ibuffer-mode . all-the-icons-ibuffer-mode))
