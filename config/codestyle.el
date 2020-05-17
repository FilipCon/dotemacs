;;; -*- lexical-binding: t -*-
(setq-default
 vc-follow-symlinks t
 ;; Save clipboard contents into kill-ring before replacing them
 save-interprogram-paste-before-kill t
 fill-column 80
 sentence-end-double-space nil
 word-wrap t
 indent-tabs-mode nil
 require-final-newline t
 tab-always-indent t
 tab-width 4
 ;; Wrapping
 truncate-lines t
 truncate-partial-width-windows 50)

(global-set-key (kbd "C-x k") 'kill-this-buffer)

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


;; copy line down
(global-set-key "\C-c\C-d" "\C-a\C- \C-n\M-w\C-y")

;; move line/region 
(use-package move-text
  :config
  (global-set-key (kbd "M-p") 'move-text-up)
  (global-set-key (kbd "M-n") 'move-text-down))

;; editor config
(use-package editorconfig
  :hook (prog-mode . editorconfig-mode))

