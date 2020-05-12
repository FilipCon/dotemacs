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

;; TODO fix it only for dired mode
;; (use-package diff-hl
;;   :hook (dired-mode . diff-hl-dired-mode)
;;   :config
;;   (global-diff-hl-mode t))

  (use-package git-link
    :commands (git-link git-link-commit git-link-open-in-browser)
    :custom (git-link-open-in-browser t))

; Git Gutter
 ;;Git gutter is great for giving visual feedback on changes, but it doesn't play well
 ;;with org-mode using org-indent. So I don't use it globally.

(use-package git-gutter
   :defer t
   :hook ((markdown-mode . git-gutter-mode)
          (prog-mode . git-gutter-mode)
          (conf-mode . git-gutter-mode))
   :config
   (setq git-gutter:disabled-modes '(org-mode asm-mode image-mode)
         git-gutter:update-interval 1
         git-gutter:window-width 2
         git-gutter:ask-p nil))

 (use-package git-gutter-fringe
    :commands git-gutter-mode
    ;; :diminish git-gutter-mode
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
