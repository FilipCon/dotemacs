;;; -*- lexical-binding: t -*-

;; restart emacs
(use-package restart-emacs)

(use-package whitespace
  :bind ("<f11>" . global-whitespace-mode)
  :hook (prog-mode . whitespace-mode)
  :config
  (setq whitespace-line-column 80)
  (setq indent-tags-mode nil)
  (setq whitespace-style
        (quote
         (face tabs spaces trailing space-before-tab newline indentation
               lines empty space-after-tab space-mark tab-mark))))

;; hack for disabling whitespaces in company
;; https://github.com/company-mode/company-mode/pull/245
(defvar my-prev-whitespace-mode nil)
(make-variable-buffer-local 'my-prev-whitespace-mode)
(defun pre-popup-draw ()
  "Turn off whitespace mode before showing company complete tooltip"
  (if whitespace-mode
      (progn
        (setq my-prev-whitespace-mode t)
        (whitespace-mode -1)
        (setq my-prev-whitespace-mode t))))
(defun post-popup-draw ()
  "Restore previous whitespace mode after showing company tooltip"
  (if my-prev-whitespace-mode
      (progn
        (whitespace-mode 1)
        (setq my-prev-whitespace-mode nil))))
(advice-add 'company-pseudo-tooltip-unhide :before #'pre-popup-draw)
(advice-add 'company-pseudo-tooltip-hide :after #'post-popup-draw)

;; delete trailing whitespaces and untabify on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'untabify)

;; undo-tree
(use-package undo-tree
  :config
  ;;turn on everywhere
  (global-undo-tree-mode 1)
  (global-set-key (kbd "C-/") 'undo)
  (global-set-key (kbd "C-S-/") 'undo-tree-redo))

;; move buffers
(use-package buffer-move
  :bind (("C-c b p" . buf-move-up)
         ("C-c b n" . buf-move-down)
         ("C-c b b" . buf-move-left)
         ("C-c b f" . buf-move-right)))

;; move buffers
(use-package buffer-move
             :ensure t
             :bind (("C-c b p" . buf-move-up)
                    ("C-c b n" . buf-move-down)
                    ("C-c b b" . buf-move-left)
                    ("C-c b f" . buf-move-right)))

;; transpose buffers horizontally
(use-package transpose-frame
  :bind ("C-c b t" . flop-frame))

;; move line/region
(use-package move-text
  :config
  (global-set-key (kbd "M-p") 'move-text-up)
  (global-set-key (kbd "M-n") 'move-text-down))

;; remap kill buffer
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; copy line down
(global-set-key "\C-c\C-d" "\C-a\C- \C-n\M-w\C-y")

;; expand region vim style
(use-package expand-region
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

;; does not jump across buffer...
(use-package goto-last-change
  :config
  (global-set-key (kbd "C-M--") 'goto-last-change)
  )

;; remap toggle comment key
(defun fk/comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))
(global-set-key (kbd "C-;") 'fk/comment-or-uncomment-region-or-line)

;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph
(defun ds/unfill-paragraph (&optional region)
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive (progn (barf-if-buffer-read-only) '(t)))
  (let ((fill-column (point-max))
        ;; This would override `fill-column' if it's an integer.
        (emacs-lisp-docstring-fill-column t))
    (fill-paragraph nil region)))
(global-set-key (kbd "C-c b u") 'ds/unfill-paragraph)

(defun fk/backward-kill-word ()
  "Remove all whitespace if the character behind the cursor is whitespace, otherwise remove a word."
  (interactive)
  (if (looking-back "[ \n]")
      ;; delete horizontal space before us and then check to see if we
      ;; are looking at a newline
      (progn (delete-horizontal-space 't)
             (while (looking-back "[ \n]")
               (backward-delete-char 1)))
    ;; otherwise, just do the normal kill word.
    (backward-kill-word 1)))
(global-set-key (kbd "C-<backspace>") 'fk/backward-kill-word)
