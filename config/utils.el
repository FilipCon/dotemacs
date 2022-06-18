;;; -*- lexical-binding: t -*-

(defun fill-to-end ()
  "Fill with `-' until fill column."
  (interactive)
  (save-excursion
    (end-of-line)
    (while (< (current-column) 80)
      (insert-char ?-))))
(global-set-key (kbd "<f8>") 'fill-to-end)

(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))
(global-set-key (kbd "C-c d") #'duplicate-current-line-or-region)

;; highlight specific words
(use-package hl-todo
  :hook ((prog-mode text-mode) . hl-todo-mode)
  :config
  (setq hl-todo-keyword-faces
        '(("TODO" . "#FF0000")
          ("FIXME" . "#FF0000")
          ("WARNING" . "#ff00ff")
          ("NEXT" . "#ff00ff")
          ("NOTE" . "#66CD00")
          ("DONE" . "#66CD00"))))

;; easy comment/uncomment
(use-package evil-nerd-commenter
  :bind ("C-;" . evilnc-comment-or-uncomment-lines))

;; unfill paragraph
(use-package unfill)

;; show available keybindings
(use-package which-key
  :init (which-key-mode 1))

;; delete trailing whitespace and untabify in edited regions only
(use-package ws-butler
  :config
  (ws-butler-global-mode 1)
  (setq ws-butler-convert-leading-tabs-or-spaces t))

;; move line/region
(use-package move-text
  :bind(("M-p" . 'move-text-up)
        ("M-n" . 'move-text-down)))

;; sexp editing
(use-package paredit
  :config
  (put 'paredit-forward-delete 'delete-selection 'supersede)
  (put 'paredit-backward-delete 'delete-selection 'supersede)
  :bind (("M-[" . paredit-wrap-square)
         ("M-{" . paredit-wrap-curly)
         ("C-0" . paredit-forward-slurp-sexp)
         ("C-9" . paredit-forward-barf-sexp)
         ("C-M-9" . paredit-backward-slurp-sexp)
         ("C-M-0" . paredit-backward-barf-sexp)
         ("M-s" . paredit-splice-sexp)
         ("C-M-<backspace>" . backward-kill-sexp)
         ("C-S-p" . paredit-mode))
  :hook ((text-mode prog-mode markdown-mode LaTeX-mode cider-repl-mode) . paredit-mode))

;; rainbow-delimiters
(use-package rainbow-delimiters
  :hook ((prog-mode cider-repl-mode LaTeX-mode) . rainbow-delimiters-mode))

;; multiple cursors
(use-package multiple-cursors
  :bind (("M-C->" . mc/edit-lines)
         ("C-|" . mc/mark-pop)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("M-C-l" . mc/mark-all-like-this))
  :custom
  (mc/always-run-for-all t)
  (mc/always-repeat-command t))
