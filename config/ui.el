;;; -*- lexical-binding: t -*-

;; highlight current line
(global-hl-line-mode t)
(global-visual-line-mode 1)

;; show line number in selected modes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'text-mode-hook 'display-line-numbers-mode)
(add-hook 'LaTeX-mode-hook 'display-line-numbers-mode)
(add-hook 'conf-mode-hook 'display-line-numbers-mode)

;; font size
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(use-package doom-modeline
  :hook (after-init . doom-modeline-init))

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

(use-package hl-todo
  :hook ((prog-mode text-mode) . hl-todo-mode)
  :config
  (setq hl-todo-highlight-punctuation ":")
  (setq hl-todo-keyword-faces
      '(("TODO"   . "#FF0000")
        ("FIXME"  . "#FF0000")
        ("DEBUG"  . "#A020F0")
        ("GOTCHA" . "#FF4500")
        ("WARNING". "#FFE600")
        ("CITE". "#FFE600")
        ("NOTE"   . "#66CD00")
        ("STUB"   . "#1E90FF"))))

(use-package whitespace
  :commands whitespace-mode
  :bind ("<f11>" . global-whitespace-mode)
  :config
  (setq whitespace-line-column nil)
  (setq whitespace-style
        '(face indentation tabs tab-mark spaces space-mark
               newline trailing)))
