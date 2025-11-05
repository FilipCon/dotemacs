(use-package magit
  :config
  (setq magit-diff-refine-hunk 'all
        magit-diff-expansion-threshold 10
        magit-show-long-lines-warning nil)
  :bind (("C-c g d" . magit-diff)
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

(use-package magit-pretty-graph
  :straight (:host github :repo "georgek/magit-pretty-graph"))

;; diffs in margin
(use-package git-gutter
  :custom-face
  (git-gutter:modified ((t (:background "deep sky blue"))))
  (git-gutter:added ((t (:background "yellow green"))))
  (git-gutter:deleted ((t (:background "orange red"))))
  :config
  (global-git-gutter-mode t)
  (setq git-gutter:disabled-modes '(fundamental-mode image-mode pdf-view-mode)
        git-gutter:ask-p nil
        git-gutter:update-interval 0
        git-gutter:modified-sign " "
        git-gutter:added-sign " "
        git-gutter:deleted-sign " ")
  ;; (add-to-list 'git-gutter:update-hooks 'focus-in-hook)
  (global-set-key (kbd "C-c h v") 'git-gutter:revert-hunk)
  (global-set-key (kbd "C-c h o") 'git-gutter:popup-hunk)
  (global-set-key (kbd "C-c h n") 'git-gutter:next-hunk)
  (global-set-key (kbd "C-c h p") 'git-gutter:previous-hunk))

;; browse region at remote repo
(use-package browse-at-remote)

(use-package dired-git-info)

;; git history
(use-package git-timemachine
  :straight (:host github :repo "emacsmirror/git-timemachine" :branch "master"))
