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

(use-package git-messenger
  :config (setq git-messenger:show-detail t)
  :bind ("C-x v m" . git-messenger:popup-message))

(use-package git-timemachine
  :commands git-timemachine)

(use-package diff-hl
  :custom-face
  (diff-hl-change ((t (:foreground ,(face-background 'highlight) :background nil))))
  (diff-hl-insert ((t (:background nil))))
  (diff-hl-delete ((t (:background nil))))
  :hook ((after-init . global-diff-hl-mode)
         (after-init . diff-hl-flydiff-mode)
         (dired-mode . diff-hl-dired-mode))
  :init (setq diff-hl-draw-borders nil)
  :config
  (setq diff-hl-ask-before-revert-hunk nil)
  (setq-default fringes-outside-margins t)
  (defun my-diff-hl-fringe-bmp-function (_type _pos)
    "Fringe bitmap function for use as `diff-hl-fringe-bmp-function'."
    (define-fringe-bitmap 'my-diff-hl-bmp [224] 1 8 '(center t)))
  (setq diff-hl-fringe-bmp-function #'my-diff-hl-fringe-bmp-function)

  (unless (display-graphic-p)
    (setq diff-hl-margin-symbols-alist
          '((insert . " ") (delete . " ") (change . " ")
            (unknown . " ") (ignored . " "))))

  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode)

  (bind-key "C-x v n" 'diff-hl-next-hunk diff-hl-mode-map)
  (bind-key "C-x v p" 'diff-hl-previous-hunk diff-hl-mode-map)
  (bind-key "C-x v u" 'diff-hl-revert-hunk diff-hl-mode-map)
  (bind-key "C-x v =" 'diff-hl-diff-goto-hunk diff-hl-mode-map))
