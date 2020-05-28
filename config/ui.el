;;; -*- lexical-binding: t -*-

(global-hl-line-mode t)
(global-visual-line-mode 1)

;; font size
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; show line number
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; theme
(use-package doom-themes
  :custom
  (doom-one-comment-bg nil)
  (doom-themes-enable-bold t)    ; if nil, bold is universally disabled
  (doom-themes-enable-italic t) ; if nil, italics is universally disabled
  :init
  (load-theme 'doom-one t) ;; load theme
  :config
  (doom-themes-visual-bell-config) ;; Enable flashing mode-line on errors
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; all the icons
(use-package all-the-icons
  :config
  ;; all-the-icons doesn't work without font-lock+
  ;; And font-lock+ doesn't have autoloads
  (use-package font-lock+
    :straight (:host github :repo "emacsmirror/font-lock-plus")
    :config (require 'font-lock+)))

(use-package all-the-icons-ibuffer
  :after all-the-icons
  :hook (ibuffer-mode . all-the-icons-ibuffer-mode))

;; show key bind
(use-package which-key
  :init (which-key-mode))

;; org bullets
(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

;; centaur tabs
(use-package centaur-tabs
  :init
  (centaur-tabs-mode t)
  :config
  (setq centaur-tabs-style "bar"
        centaur-tabs-height 32
        centaur-tabs-set-icons t
        centaur-tabs-set-modified-marker t
        centaur-tabs-set-bar 'left)
  (centaur-tabs-headline-match)
  (setq centaur-tabs-gray-out-icons 'buffer)
  (setq uniquify-separator "/")
  (setq uniquify-buffer-name-style 'forward)
  (defun centaur-tabs-buffer-groups ()
    (list
     (cond
      ;; ((not (eq (file-remote-p (buffer-file-name)) nil))
      ;; "Remote")
      ((or (string-equal "*" (substring (buffer-name) 0 1))
           (memq major-mode '(magit-process-mode
                              magit-status-mode
                              magit-diff-mode
                              magit-log-mode
                              magit-file-mode
                              magit-blob-mode
                              magit-blame-mode
                              )))
       "Emacs")
      ((derived-mode-p 'prog-mode)
       "Editing")
      ((derived-mode-p 'dired-mode)
       "Dired")
      ((memq major-mode '(helpful-mode
                          help-mode))
       "Help")
      ((memq major-mode '(org-mode
                          org-agenda-clockreport-mode
                          org-src-mode
                          org-agenda-mode
                          org-beamer-mode
                          org-indent-mode
                          org-bullets-mode
                          org-cdlatex-mode
                          org-agenda-log-mode
                          diary-mode))
       "OrgMode")
      (t
       (centaur-tabs-get-group-name (current-buffer))))))
  :hook
  (dashboard-mode . centaur-tabs-local-mode)
  (term-mode . centaur-tabs-local-mode)
  (calendar-mode . centaur-tabs-local-mode)
  (org-agenda-mode . centaur-tabs-local-mode)
  (helpful-mode . centaur-tabs-local-mode)
  :bind
  ("C-s--" . centaur-tabs-backward)
  ("C-s-=" . centaur-tabs-forward)
  ("C-c t s" . centaur-tabs-counsel-switch-group)
  ("C-c t p" . centaur-tabs-group-by-projectile-project)
  ("C-c t g" . centaur-tabs-group-buffer-groups))

;; tildes in EOF like vim
(use-package vi-tilde-fringe
  :init
  (add-hook 'prog-mode-hook 'vi-tilde-fringe-mode)
  (add-hook 'org-mode-hook 'vi-tilde-fringe-mode))

;; ;; highlight indent
;; (use-package highlight-indent-guides
;;   :hook (prog-mode . highlight-indent-guides-mode)
;;   :config
;;   (setq highlight-indent-guides-method 'character))

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
