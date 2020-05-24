;;; -*- lexical-binding: t -*-

;; restart emacs
(use-package restart-emacs)

(use-package whitespace
  :hook (prog-mode . whitespace-mode)
  :config
  (setq whitespace-line-column nil)
  (setq whitespace-style
      '(face indentation tabs tab-mark spaces space-mark newline
             trailing)))

;; hack for disabling whitespaces in company
;; basically it turns it on/off when company pops up
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

(use-package ws-butler
  ;; a less intrusive `delete-trailing-whitespaces' on save
  :config (ws-butler-global-mode +1))

;; delete trailing whitespaces and untabify on save
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'untabify)

;; undo-tree
(use-package undo-tree
  :config
  (global-undo-tree-mode 1)
  (global-set-key (kbd "C-/") 'undo)
  (global-set-key (kbd "C-S-/") 'undo-tree-redo))

(defun restore-killed-buffer ()
  (interactive)
  (let ((active-files (loop for buf in (buffer-list)
                            when (buffer-file-name buf) collect it)))
    (loop for file in recentf-list
          unless (member file active-files) return (find-file file))))
(define-key global-map (kbd "C-S-t") 'restore-killed-buffer)

;; move buffers
(use-package buffer-move
  :bind (("C-c b p" . buf-move-up)
         ("C-c b n" . buf-move-down)
         ("C-c b b" . buf-move-left)
         ("C-c b f" . buf-move-right)))

;; move cursor to other buffers
(global-set-key (kbd "C-c c p") 'windmove-up)
(global-set-key (kbd "C-c c n") 'windmove-down)
(global-set-key (kbd "C-c c b") 'windmove-left)
(global-set-key (kbd "C-c c f") 'windmove-right)

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

;; set key for rgrep
(global-set-key (kbd "C-c C-s") 'counsel-rg)

;; expand region vim style
(use-package expand-region
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

;; evil-jumper is awesome!
(use-package evil
  :config
  (global-set-key (kbd "C-M--") 'evil-jump-backward)
  (global-set-key (kbd "C-M-=") 'evil-jump-forward))

(use-package dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g b" . dumb-jump-back)
         ("M-g i" . dumb-jump-go-prompt)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config (setq dumb-jump-selector 'ivy))

;; remap key for ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

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
  "Remove all whitespace if the character behind the cursor is whitespace,
    otherwise remove a word."
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

;; copy/cut whole line without selecting (better than
;; whole-line-or-region-mode)
(defun ds/string-chomp (str)
  "Chomp leading and tailing whitespace from str."
  (while (string-match "\\`\n+\\|^\\s-+\\|\\s-+$\\|\n+\\'"
                       str)
    (setq str (replace-match "" t t str)))
  str)

(defun ds/chomp-kill-ring-car ()
  "Clear whitespaces from first element of kill ring."
  (let ((str (pop kill-ring)))
    (push (ds/string-chomp str) kill-ring)))

(defun ds/copy-whole-line ()
  "Place current line in kill ring."
  (interactive)
  (kill-whole-line)
  (yank)
  (ds/chomp-kill-ring-car))
(global-set-key (kbd "C-c u c") 'ds/copy-whole-line)

(defun ds/cut-whole-line ()
  "Place current line in kill ring and kill."
  (interactive)
  (kill-whole-line)
  (ds/chomp-kill-ring-car))
(global-set-key (kbd "C-c u x") 'ds/cut-whole-line)

;; delete
(defun ds/delete-line-no-kill ()
  (interactive)
  (delete-region
   (point)
   (save-excursion (move-end-of-line 1) (point)))
  (delete-char 1))
(global-set-key (kbd "C-c u d") 'ds/delete-line-no-kill)
