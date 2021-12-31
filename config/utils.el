;;; -*- lexical-binding: t -*-

;; fill with `-' until fill column
(defun fill-to-end ()
  (interactive)
  (save-excursion
    (end-of-line)
    (while (< (current-column) 80)
      (insert-char ?-))))
(global-set-key (kbd "<f8>") 'fill-to-end)

;; make modeline pretty
(use-package doom-modeline
  :hook (after-init . doom-modeline-init)
  :config
  (setq doom-modeline-icon t))

;; all the icons
(use-package all-the-icons)
(use-package all-the-icons-ibuffer
  :after all-the-icons
  :hook (ibuffer-mode . all-the-icons-ibuffer-mode))

;; tildes in EOF like vim
(use-package vi-tilde-fringe
  :hook ((prog-mode org-mode) . vi-tilde-fringe-mode))

;; fill column indicator
(use-package hl-fill-column
  :bind ("<f12>" . display-fill-column-indicator-mode)
  :hook (prog-mode . hl-fill-column-mode))

;; highlight specific words
(use-package hl-todo
  :hook ((prog-mode text-mode) . hl-todo-mode)
  :config
  (setq hl-todo-keyword-faces
      '(("TODO"   . "#FF0000")
        ("FIXME"  . "#FF0000")
        ("DEBUG"  . "#A020F0")
        ("OPTIMIZE"  . "#A020F0")
        ("WARNING" . "#ff00ff")
        ("NEXT" . "#ff00ff")
        ("HACK"   . "#FF4500")
        ("CITE"   . "#1E90FF")
        ("STUB"   . "#1E90FF")
        ("NOTE"   . "#66CD00")
        ("DONE"   . "#66CD00")
        ("REVIEW"   . "#66CD00"))))

;; show whitespaces
(use-package whitespace
  :bind ("<f11>" . global-whitespace-mode)
  :config
  (setq whitespace-line-column nil))

;; move cursor to other buffers
(global-set-key (kbd "C-c c p") 'windmove-up)
(global-set-key (kbd "C-c c n") 'windmove-down)
(global-set-key (kbd "C-c c b") 'windmove-left)
(global-set-key (kbd "C-c c f") 'windmove-right)

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

;; collection of utilities
(use-package crux
  :bind (("C-x 4 t". crux-transpose-windows)
         ("C-c d" . crux-duplicate-current-line-or-region)
         ("C-c b r" . crux-rename-file-and-buffer)))

;; easy comment/uncomment
(use-package evil-nerd-commenter
  :bind ("C-;" . evilnc-comment-or-uncomment-lines))

;; global search tool
(use-package ag
  :config
  (advice-add 'project-find-regexp :override #'ag-project-regexp)
  (setq ag-highlight-search t))

;; writable grep
(use-package wgrep-ag)

;; restart emacs
(use-package restart-emacs)

;; show key bind
(use-package which-key
  :init (which-key-mode 1))

;; delete trailing whitespace and untabify in edited regions only
(use-package ws-butler
  :config
  (ws-butler-global-mode 1)
  (setq ws-butler-convert-leading-tabs-or-spaces t))

;; undo/redo
(use-package undo-fu
  :bind (("C-/". undo-fu-only-undo)
         ("C-?" . undo-fu-only-redo)))

;; move line/region
(use-package move-text
  :bind(("M-p" .  'move-text-up)
        ("M-n" .  'move-text-down)))

;; multiple cursors
(use-package multiple-cursors
  :bind (("M-C->" . mc/edit-lines)
         ("C-|" . mc/mark-pop)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("M-C-l" . mc/mark-all-like-this))
  :custom
  (smartparens-global-mode 1)
  (mc/always-run-for-all t)
  (mc/always-repeat-command t))

;; sneaky garbage collector
(use-package gcmh-mode
  :commands (gcmh-mode)
  :straight (:host github :repo "emacsmirror/gcmh")
  :init
  (gcmh-mode 1))
