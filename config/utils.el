;;; -*- lexical-binding: t -*-

;; move between recently visited
(global-set-key (kbd "C-M-,") 'previous-buffer)
(global-set-key (kbd "C-M-.") 'next-buffer)

;; move cursor to other buffers
(global-set-key (kbd "C-c c p") 'windmove-up)
(global-set-key (kbd "C-c c n") 'windmove-down)
(global-set-key (kbd "C-c c b") 'windmove-left)
(global-set-key (kbd "C-c c f") 'windmove-right)

;; remap kill buffer
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; remap key for ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; restore most recently killed buffer
(global-set-key (kbd "C-S-t") 'recentf-open-most-recent-file)

;; show in-buffer previous candidates
(use-package browse-kill-ring
  :config
  (browse-kill-ring-default-keybindings))

;; describe functionalities in major modes
(use-package discover-my-major)

;; replacement for kill-ring-save
(use-package easy-kill
  :config
  (global-set-key [remap kill-ring-save] 'easy-kill))

;; ;; editorconfig plugin for code format style
;; (use-package editorconfig
;;   :config
;;   (editorconfig-mode 1)
;;   (setq editorconfig-trim-whitespaces-mode
;;       'ws-butler-mode))

;; visualize regexp
(use-package visual-regexp)

;; unfill paragraph, etc
(use-package unfill)

;; collection of utilities
(use-package crux
  :bind (("C-x 4 t". crux-transpose-windows)
         ("C-c d" . crux-duplicate-current-line-or-region)))

;; easy comment/uncomment
(use-package evil-nerd-commenter
  :bind ("C-;" . evilnc-comment-or-uncomment-lines))

;; global search tool
(use-package ag)

;; diff files
(use-package vdiff)

;; move like a ninja! swoosh!
(use-package avy
  :config
  (global-set-key (kbd "C-'") 'avy-goto-char)
  (global-set-key (kbd "C-\"") 'avy-goto-char-2))

;; writable grep
(use-package wgrep)

;; Workaround with minified source files
(use-package so-long
  :hook (after-init . global-so-long-mode))

;; Update buffer whenever file changes
(use-package autorevert
  :custom
  (auto-revert-interval 3)
  (auto-revert-verbose nil)
  (auto-revert-remote-files t)
  (auto-revert-check-vc-info t)
  (global-auto-revert-non-file-buffers t)
  :hook (after-init . global-auto-revert-mode))

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
  :config
  (global-set-key (kbd "C-/") 'undo-fu-only-undo)
  (global-set-key (kbd "C-?")  'undo-fu-only-redo))

;; move buffers
(use-package buffer-move
  :bind (("C-c b p" . buf-move-up)
         ("C-c b n" . buf-move-down)
         ("C-c b b" . buf-move-left)
         ("C-c b f" . buf-move-right)))

;; move line/region
(use-package move-text
  :config
  (global-set-key (kbd "M-p") 'move-text-up)
  (global-set-key (kbd "M-n") 'move-text-down))

;; expand region vim style
(use-package expand-region
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

;; Free hands
(use-package auto-package-update
  :custom
  (auto-package-update-delete-old-versions t))

;; ;; Write documentation comment in an easy way
;; (use-package separedit
;;   :custom
;;   (separedit-remove-trailing-spaces-in-comment t)
;;   (separedit-continue-fill-column t)
;;   (separedit-buffer-creation-hook #'auto-fill-mode)
;;   :bind (:map prog-mode-map
;;          ("C-c '" . separedit)))

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

;; documentation
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; Mini-Buffer Actions
(use-package embark)

(use-package consult
  :after (projectile)
  :bind  (("C-h a" . consult-apropos)
          ("C-x b" . consult-buffer)
          ("C-x 4 b" . consult-buffer-other-window)
          ("C-x 5 b" . consult-buffer-other-frame)
          ("M-g M-g" . consult-goto-line))
  :config
  (setq-default consult-project-root-function #'projectile-project-root)
    ;; Replace functions (consult-multi-occur is a drop-in replacement)
  (fset 'multi-occur #'consult-multi-occur))

(use-package embark-consult
  :after (consult embark)
  :hook (embark-collect . embark-consult-preview-minor-mode))
