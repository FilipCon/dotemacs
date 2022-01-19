;;; -*- lexical-binding: t -*-

(use-package magit
  :config
  (setq magit-diff-refine-hunk 'all
        magit-diff-expansion-threshold 10)
  :bind (("C-c g s" . magit-status)
         ("C-c g o" . magit-checkout)
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

(use-package git-gutter
  :config
  (global-git-gutter-mode t)
  (setq git-gutter:disabled-modes '(fundamental-mode image-mode pdf-view-mode)
        git-gutter:ask-p nil)
  (add-hook 'focus-in-hook #'git-gutter:update-all-windows)
  (global-set-key (kbd "C-c h u") 'git-gutter:revert-hunk)
  (global-set-key (kbd "C-c h o") 'git-gutter:popup-hunk)
  (global-set-key (kbd "C-c h n") 'git-gutter:next-hunk)
  (global-set-key (kbd "C-c h p") 'git-gutter:previous-hunk))

(use-package git-gutter-fringe
  :after git-gutter
  :custom-face
  (git-gutter-fr:mod ((t (:foreground "DeepSkyBlue" :background nil))))
  (git-gutter-fr:add ((t (:foreground "YellowGreen" :background nil))))
  (git-gutter-fr:del ((t (:foreground "OrangeRed" :background nil))))
  :config
  (setq-default fringes-outside-margins t)
  (define-fringe-bitmap 'git-gutter-fr:add [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:mod [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:del [224] nil nil '(center repeated)))
