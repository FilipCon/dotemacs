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

;; ;; visit previous versions of file
;; (use-package git-timemachine)

;; ;; create URLs for files and commits
;; (use-package git-link
;;   :config
;;   (setq git-link-open-in-browser t))

;; ;; browse selection at remote
;; (use-package browse-at-remote)

;; ;; git-modes
;; (use-package git-modes)

;; (use-package forge
;;   (setq auth-sources '("~/.authinfo")))

;; diffs in margin
(use-package git-gutter
  :custom-face
  (git-gutter:modified ((t (:background "deep sky blue"))))
  (git-gutter:added ((t (:background "yellow green"))))
  (git-gutter:deleted ((t (:background "orange red"))))
  :config
  (custom-set-variables
   '(git-gutter:window-width 1)
   '(git-gutter:modified-sign " ")
   '(git-gutter:added-sign " ")
   '(git-gutter:deleted-sign " "))
  (global-git-gutter-mode t)
  (setq git-gutter:disabled-modes '(fundamental-mode image-mode pdf-view-mode)
        git-gutter:ask-p nil
        git-gutter:update-interval 0.2)
  (add-to-list 'git-gutter:update-hooks 'focus-in-hook)
  (global-set-key (kbd "C-c h v") 'git-gutter:revert-hunk)
  (global-set-key (kbd "C-c h o") 'git-gutter:popup-hunk)
  (global-set-key (kbd "C-c h n") 'git-gutter:next-hunk)
  (global-set-key (kbd "C-c h p") 'git-gutter:previous-hunk))
