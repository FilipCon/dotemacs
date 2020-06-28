;;; -*- lexical-binding: t -*-

;; move like a ninja! swoosh!
(use-package avy
  :config
  (global-set-key (kbd "M-g e") 'avy-goto-word-0)
  (global-set-key (kbd "M-g w") 'avy-goto-word-1)
  (global-set-key (kbd "M-g f") 'avy-goto-line)
  (global-set-key (kbd "C-'") 'avy-goto-char-2)
  (global-set-key (kbd "C-\"") 'avy-goto-char))

;; writable grep
(use-package wgrep)

;; Workaround with minified source files
(use-package so-long
  :when (>= emacs-major-version 27)
  :hook (after-init . global-so-long-mode))

;; Back to the previous position
(use-package saveplace
  :hook (after-init . save-place-mode))

;; Update buffer whenever file changes
;; Also revert dired buffer.
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
  :bind ("M-/" . hippie-expand)
  :config
  ;; hippie expand is dabbrev expand on steroids
  (setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                           try-expand-dabbrev-all-buffers
                                           try-expand-dabbrev-from-kill
                                           try-complete-file-name-partially
                                           try-complete-file-name
                                           try-expand-all-abbrevs
                                           try-expand-list
                                           try-expand-line
                                           try-complete-lisp-symbol-partially
                                           try-complete-lisp-symbol)))

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
  :hook (after-init . ws-butler-global-mode)
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

;; Buffer manager
(use-package ibuffer
  :commands (ibuffer-switch-to-saved-filter-groups)
  :hook ((ibuffer-mode . ibuffer-auto-mode)
         (ibuffer-mode . (lambda ()
                           (ibuffer-switch-to-saved-filter-groups "Default"))))
  :custom
  (ibuffer-expert t)
  (ibuffer-movement-cycle nil)
  (ibuffer-show-empty-filter-groups nil)
  (ibuffer-saved-filter-groups
   '(("Default"
      ("Emacs" (or (name . "\\*scratch\\*")
                   (name . "\\*dashboard\\*")
                   (name . "\\*compilation\\*")
                   (name . "\\*Backtrace\\*")
                   (name . "\\*Packages\\*")
                   (name . "\\*Messages\\*")
                   (name . "\\*Customize\\*")))
      ("Programming" (or (derived-mode . prog-mode)
                         (mode . makefile-mode)
                         (mode . cmake-mode)))
      ("Text" (or (mode . org-mode)
                  (mode . markdown-mode)
                  (mode . gfm-mode)
                  (mode . rst-mode)
                  (mode . text-mode)))
      ("Term" (or (mode . vterm-mode)
                  (mode . term-mode)
                  (mode . shell-mode)
                  (mode . eshell-mode)))
      ("Config" (or (mode . yaml-mode)
                    (mode . toml-mode)
                    (mode . conf-mode)))
      ("Mail" (or (mode . message-mode)
                  (mode . bbdb-mode)
                  (mode . mail-mode)
                  (mode . mu4e-compose-mode)))
      ("Images" (or (mode . image-mode)
                    (mode . image-dired-display-image-mode)
                    (mode . image-dired-thumbnail-mode)))
      ("Dired" (mode . dired-mode))
      ("Magit" (name . "magit"))
      ("Help" (or (name . "\\*Help\\*")
                  (name . "\\*Apropos\\*")
                  (name . "\\*info\\*"))))
     ))
  )

;; Recently opened files
(use-package recentf
  :after no-littering
  :hook ((after-init . recentf-mode)
         (focus-out-hook . (recentf-save-list recentf-cleanup)))
  :custom
  (recentf-max-saved-items 300)
  (recentf-auto-cleanup 'never)
  (recentf-exclude `(,(expand-file-name package-user-dir)
                     ,no-littering-var-directory
                     ,no-littering-etc-directory
                     ".cache"
                     "cache"
                     "^/tmp/"
                     "/ssh:"
                     "/su\\(do\\)?:"
                     "^/usr/include/"
                     "COMMIT_EDITMSG\\'")))

;; Free hands
(use-package auto-package-update
  :defer t
  :custom
  (auto-package-update-delete-old-versions t))

;; Write documentation comment in an easy way
(use-package separedit
  :custom
  (separedit-default-mode 'markdown-mode)
  (separedit-remove-trailing-spaces-in-comment t)
  (separedit-continue-fill-column t)
  (separedit-buffer-creation-hook #'auto-fill-mode)
  :bind (:map prog-mode-map
         ("C-c '" . separedit)))
