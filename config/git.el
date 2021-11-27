;;; -*- lexical-binding: t -*-

(use-package magit
  :config
  (setq magit-diff-refine-hunk 'all
        magit-diff-expansion-threshold 20)
  :bind (("C-c g s" . magit-status)
         ("C-c g d" . magit-diff)
         ("C-c g b" . magit-blame-addition)))

;; ediff config
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; fringe highlight diffs
(use-package diff-hl
  :custom-face
  (diff-hl-change ((t (:foreground "DeepSkyBlue" :background nil))))
  (diff-hl-insert ((t (:foreground "YellowGreen" :background nil))))
  (diff-hl-delete ((t (:foreground "OrangeRed" :background nil))))
  :bind (:map diff-hl-mode-map
              ("C-x v n" . diff-hl-next-hunk )
              ("C-x v p" . diff-hl-previous-hunk)
              ("C-x v u" . diff-hl-revert-hunk))
  :hook ((after-init . global-diff-hl-mode)
         (after-init . diff-hl-flydiff-mode)
         (dired-mode . diff-hl-dired-mode-unless-remote)
         (magit-post-refresh . diff-hl-magit-post-refresh))
  :init (setq diff-hl-draw-borders nil)
  :config
  (setq diff-hl-ask-before-revert-hunk nil
        fringes-outside-margins t
        diff-hl-fringe-bmp-function
        (lambda (_type _pos)
          (define-fringe-bitmap 'my-diff-hl-bmp [224] 1 8 '(center t))))
  (unless (display-graphic-p)
    (setq diff-hl-margin-symbols-alist
          '((insert . " ") (delete . " ") (change . " ")
            (unknown . " ") (ignored . " ")))))
