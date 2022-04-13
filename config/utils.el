;;; -*- lexical-binding: t -*-

(defun fill-to-end ()
  "Fill with `-' until fill column."
  (interactive)
  (save-excursion
    (end-of-line)
    (while (< (current-column) 80)
      (insert-char ?-))))
(global-set-key (kbd "<f8>") 'fill-to-end)

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

;; move buffers
(use-package buffer-move
  :bind (("C-c b p" . buf-move-up)
         ("C-c b n" . buf-move-down)
         ("C-c b b" . buf-move-left)
         ("C-c b f" . buf-move-right)))

;; replacement for kill-ring-save
(use-package easy-kill
  :config
  (global-set-key [remap kill-ring-save] 'easy-kill)
  (global-set-key [remap mark-sexp] 'easy-mark))

;; easy comment/uncomment
(use-package evil-nerd-commenter
  :bind ("C-;" . evilnc-comment-or-uncomment-lines))

;; collection of utilities
(use-package crux
  :bind (("C-c d" . crux-duplicate-current-line-or-region)))

;; unfill paragraph
(use-package unfill
  :bind ("C-M-q" . unfill-paragraph))

;; global search tool
(use-package ag
  :config
  (advice-add 'project-find-regexp :override #'ag-project-regexp)
  (setq ag-highlight-search t)
  (setq-default ag-ignore-list (append ignored-files ignored-directories)))

;; writable grep
(use-package wgrep-ag)

;; restart emacs
(use-package restart-emacs)

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

;; github emojis
(use-package emojify
  :hook (after-init . global-emojify-mode))

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

;; sneaky garbage collector
(use-package gcmh-mode
  :commands (gcmh-mode)
  :straight (:host github :repo "emacsmirror/gcmh")
  :init
  (gcmh-mode 1))
