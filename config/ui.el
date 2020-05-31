;;; -*- lexical-binding: t -*-

;; highlight current line
(global-hl-line-mode t)
(global-visual-line-mode 1)

;; show line number
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; font size
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; all the icons
(use-package all-the-icons)

(use-package all-the-icons-ibuffer
  :after all-the-icons
  :hook (ibuffer-mode . all-the-icons-ibuffer-mode))

;; org bullets
(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

;; tildes in EOF like vim
(use-package vi-tilde-fringe
  :init
  (add-hook 'prog-mode-hook 'vi-tilde-fringe-mode)
  (add-hook 'org-mode-hook 'vi-tilde-fringe-mode))

;; highlight indent
(use-package highlight-indent-guides
  :bind ("<f12>" . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character))

;; fill column indicator
(use-package hl-fill-column
  :hook (prog-mode . hl-fill-column-mode))

(use-package hl-todo
  :hook (prog-mode . hl-todo-mode)
  :config
  (setq hl-todo-highlight-punctuation ":")
  (setq hl-todo-keyword-faces
      '(("TODO"   . "#FF0000")
        ("FIXME"  . "#FF0000")
        ("DEBUG"  . "#A020F0")
        ("GOTCHA" . "#FF4500")
        ("STUB"   . "#1E90FF"))))

(use-package whitespace
  :bind ("<f11>" . global-whitespace-mode)
  :config
  (setq whitespace-line-column nil)
  (setq whitespace-style
      '(face indentation tabs tab-mark spaces space-mark newline
             trailing))
  (whitespace-mode -1))
