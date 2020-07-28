;;; -*- lexical-binding: t -*-

(use-package magit
  :config
  ;; show word by word difference
  (setq magit-diff-refine-hunk 'all)
  :bind (("C-c g s" . magit-status)
         ("C-c g i" . magit-init)
         ("C-c g t" . magit-stash)
         ("C-c g l" . magit-log)
         ("C-c g c" . magit-commit)
         ("C-c g p" . magit-push-other)
         ("C-c g u" . magit-pull)
         ("C-c g d" . magit-diff)
         ("C-c g o" . magit-checkout)
         ("C-c g m" . magit-merge)
         ("C-c g a" . magit-remote-add)
         ("C-c g r" . magit-remote-remove)
         ("C-c g n" . magit-clone)))

(use-package git-link
  :commands (git-link git-link-commit git-link-open-in-browser)
  :custom (git-link-open-in-browser t))

(use-package gitignore-mode)

(use-package git-gutter
  :hook (after-init . global-git-gutter-mode)
  :config
  (setq git-gutter:disabled-modes '(image-mode)
        git-gutter:update-interval 0.5
        git-gutter:window-width 2
        git-gutter:ask-p nil)
  (global-set-key (kbd "C-c g h r") 'git-gutter:revert-hunk)
  (global-set-key (kbd "C-c g h n") 'git-gutter:next-hunk)
  (global-set-key (kbd "C-c g h p") 'git-gutter:previous-hunk)
  (global-set-key (kbd "C-c g h s") 'git-gutter:popup-hunk))

(use-package git-gutter-fringe
  :after git-gutter
  :demand fringe-helper
  :init
  (progn
    (when (display-graphic-p)
      (with-eval-after-load 'git-gutter
        (require 'git-gutter-fringe)))
    (setq git-gutter-fr:side 'left-fringe))
  :config
  ;; subtle diff indicators in the fringe
  ;; places the git gutter outside the margins.
  (setq-default fringes-outside-margins t)
  ;; thin fringe bitmaps
  (define-fringe-bitmap 'git-gutter-fr:added   [224]
    nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified   [224]
    nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted   [128 192 224 240]
    nil nil 'bottom))
