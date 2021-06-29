;;; -*- lexical-binding: t -*-

;; highlight current line
(global-hl-line-mode t)
(global-visual-line-mode t)

;; show line number in selected modes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'text-mode-hook 'display-line-numbers-mode)
(add-hook 'LaTeX-mode-hook 'display-line-numbers-mode)
(add-hook 'conf-mode-hook 'display-line-numbers-mode)

;; font size
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

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
  :init
  (add-hook 'prog-mode-hook 'vi-tilde-fringe-mode)
  (add-hook 'org-mode-hook 'vi-tilde-fringe-mode))

;; fill column indicator
(use-package hl-fill-column
  :hook (prog-mode . hl-fill-column-mode))

;; column indicator
(global-set-key (kbd "<f12>") 'display-fill-column-indicator-mode)

;; highlight specific words
(use-package hl-todo
  :hook ((prog-mode text-mode) . hl-todo-mode)
  :config
  (setq hl-todo-highlight-punctuation ":")
  (setq hl-todo-keyword-faces
      '(("TODO"   . "#FF0000")
        ("FIXME"  . "#FF0000")
        ("DEBUG"  . "#A020F0")
        ("WARNING". "#FFE600")
        ("CITE"   . "#FFE600")
        ("NOTE"   . "#66CD00"))))

;; show whitspaces
(use-package whitespace
  :commands whitespace-mode
  :bind ("<f11>" . global-whitespace-mode)
  :config
  (setq whitespace-line-column nil)
  (setq whitespace-style
        '(face indentation tabs tab-mark spaces space-mark
               newline trailing)))

;; eval elisp buffer
(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-buffer)

;; insert file name
(global-set-key [f7]
  (lambda () (interactive)
     (insert (buffer-name (window-buffer (minibuffer-selected-window))))))

;; move between recently visited
(global-set-key (kbd "C-M-,") 'previous-buffer)
(global-set-key (kbd "C-M-.") 'next-buffer)

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

;; remap default keys
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; replacement for kill-ring-save
(use-package easy-kill
  :config
  (global-set-key [remap kill-ring-save] 'easy-kill)
  (global-set-key [remap mark-sexp] 'easy-mark))

;; visualize regexp
(use-package visual-regexp)

;; unfill paragraph, etc
(use-package unfill)

;; collection of utilities
(use-package crux
  :bind (("C-x 4 t". crux-transpose-windows)
         ("C-c d" . crux-duplicate-current-line-or-region)
         ("C-c b r" . crux-rename-file-and-buffer)))

;; easy comment/uncomment
(use-package evil-nerd-commenter
  :bind ("C-;" . evilnc-comment-or-uncomment-lines))

;; global search tool
(use-package ag)

;; move like a ninja! swoosh!
(use-package avy
  :bind (("C-'" . avy-goto-char)
         ("C-\"" . avy-goto-char-2)))

;; writable grep
(use-package wgrep)

;; Workaround with minified source files
(use-package so-long
  :hook (after-init . global-so-long-mode))

;; Update buffer whenever file changes
(use-package autorevert
  :config
  (global-auto-revert-mode t)
  :custom
  (auto-revert-interval 2)
  (auto-revert-verbose nil)
  (auto-revert-remote-files t)
  (auto-revert-check-vc-info t)
  (global-auto-revert-non-file-buffers nil))

;; hippie expand
(use-package hippie-expand
  :straight (:type built-in)
  :bind ("M-/" . hippie-expand))

;; fold/expand region
(use-package origami
  :hook (prog-mode . origami-mode)
    :bind (:map origami-mode-map
              ("C-: :" . origami-recursively-toggle-node)
              ("C-: a" . origami-toggle-all-nodes)
              ("C-: t" . origami-toggle-node)
              ("C-: o" . origami-show-only-node)
              ("C-: C-r" . origami-reset)))

;; restart emacs
(use-package restart-emacs)

;; show key bind
(use-package which-key
  :init (which-key-mode))

;; delete trailing whitespace and untabify in edited regions only
(use-package ws-butler
  :config
  (ws-butler-global-mode 1)
  (setq ws-butler-convert-leading-tabs-or-spaces t))

(use-package undo-fu
  :bind (("C-/". undo-fu-only-undo)
         ("C-?" . undo-fu-only-redo)))

;; (use-package undo-tree
;;   :bind (("C-/". undo-tree-undo)
;;          ("C-?" . undo-tree-redo))
;;   :config
;;   (global-undo-tree-mode)
;;   (setq undo-tree-visualizer-diff t
;;         undo-tree-auto-save-history t
;;         undo-tree-enable-undo-in-region t))

;; move line/region
(use-package move-text
  :bind(("M-p" .  'move-text-up)
        ("M-n" .  'move-text-down)))

;; expand region vim style
(use-package expand-region
  :bind ("C-=" . 'er/expand-region))

;; multiple cursors
(use-package multiple-cursors
  :config
  (setq mc/always-run-for-all t
        mc/always-repeat-command t)
  (global-set-key (kbd "M-C->") 'mc/edit-lines)
  (global-set-key (kbd "C-|") 'mc/mark-pop)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "M-C-l") 'mc/mark-all-like-this))
