;;; -*- lexical-binding: t -*-

(use-package magit
  :config
  (setq magit-diff-refine-hunk 'all
        magit-diff-expansion-threshold 10)
  :bind (("C-c g s" . magit-status)
         ("C-c g d" . magit-diff)
         ("C-c g b" . magit-blame-addition)))

;; ediff config
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; Enforce git commit conventions.
;; See https://chris.beams.io/posts/git-commit/
(setq git-commit-summary-max-length 50
      git-commit-style-convention-checks
      '(overlong-summary-line non-empty-second-line))
(add-hook 'git-commit-mode-hook (lambda () (setq fill-column 72)))

;; visit previous versions of file
(use-package git-timemachine)

;; create URLs for files and commits
(use-package git-link
  :config
  (setq git-link-open-in-browser t))

;; git-modes
(use-package git-modes)

;; (use-package forge
;;   :after magit
;;   :config
;;   (setq auth-sources '("~/.authinfo.gpg")))

;; fringe highlight diffs
(use-package diff-hl
  :custom-face
  (diff-hl-change ((t (:foreground "DeepSkyBlue" :background nil))))
  (diff-hl-insert ((t (:foreground "YellowGreen" :background nil))))
  (diff-hl-delete ((t (:foreground "OrangeRed" :background nil))))
  :bind (:map diff-hl-mode-map
              ("C-x v n" . diff-hl-next-hunk)
              ("C-x v p" . diff-hl-previous-hunk)
              ("C-x v u" . diff-hl-revert-hunk))
  :hook ((magit-post-refresh . diff-hl-magit-post-refresh)
         (magit-pre-refresh . diff-hl-magit-pre-refresh)
         (dired-mode . diff-hl-dired-mode-unless-remote))
  :init (setq diff-hl-draw-borders nil)
  :config
  (global-diff-hl-mode 1)
  (diff-hl-flydiff-mode 1)
  (setq-default fringes-outside-margins t)
  (setq diff-hl-ask-before-revert-hunk nil
        diff-hl-fringe-bmp-function
        (lambda (_type _pos)
          (define-fringe-bitmap 'my-diff-hl-bmp [224] 1 8 '(center t)))))
