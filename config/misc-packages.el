;;; -*- lexical-binding: t -*-

;; fold/expand region
(use-package origami
  :hook (prog-mode . origami-mode))

;; restart emacs
(use-package restart-emacs)

;; show key bind
(use-package which-key
  :init (which-key-mode))

;; delete trailing whitespace and untabify in edited regions only
(use-package ws-butler
  :hook (prog-mode . ws-butler-mode)
  :config
  (setq ws-butler-convert-leading-tabs-or-spaces t)
  (setq ws-butler-keep-whitespace-before-point nil))

;; undo-tree
(use-package undo-tree
  :config
  (global-undo-tree-mode 1)
  (global-set-key (kbd "C-/") 'undo)
  (global-set-key (kbd "C-S-/") 'undo-tree-redo))

;; move buffers
(use-package buffer-move
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

;; expand region vim style
(use-package expand-region
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

;; evil-jumper is awesome!
(use-package evil
  :config
  (global-set-key (kbd "C-M--") 'evil-jump-backward)
  (global-set-key (kbd "C-M-=") 'evil-jump-forward))
