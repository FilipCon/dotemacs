;;; -*- lexical-binding: t -*-

(use-package magit
  :config
  (setq magit-diff-refine-hunk 'all
        magit-diff-expansion-threshold 20)
  :bind (("C-c g s" . magit-status)
         ("C-c g d" . magit-diff-dwim)
         ("C-c g b" . magit-blame-addition)))

(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; (use-package git-link
;;   :commands (git-link git-link-commit git-link-open-in-browser)
;;   :custom (git-link-open-in-browser t))

;; (use-package gitignore-mode)
;; (use-package gitconfig-mode)
;; (use-package gitattributes-mode)

;; (use-package forge
;;   :after magit
;;   :config
;;   (setq auth-sources '("~/.authinfo.gpg")))

;; (use-package git-timemachine
;;   :commands git-timemachine)

;; fringe highlight diffs
(use-package diff-hl
  :custom-face
  (diff-hl-change ((t (:foreground "DeepSkyBlue" :background nil))))
  (diff-hl-insert ((t (:foreground "YellowGreen" :background nil))))
  (diff-hl-delete ((t (:foreground "OrangeRed" :background nil))))
  :hook ((after-init . global-diff-hl-mode)
         (after-init . diff-hl-flydiff-mode)
         (dired-mode . diff-hl-dired-mode-unless-remote))
  :hook (magit-post-refresh . diff-hl-magit-post-refresh)
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
  (bind-key "C-x v u" 'diff-hl-revert-hunk diff-hl-mode-map))
