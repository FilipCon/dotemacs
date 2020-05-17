;;; -*- lexical-binding: t -*-

(setq ring-bell-function 'ignore        ; don't beep
      x-gtk-use-system-tooltips nil     ; no gui popups
      use-dialog-box nil                ; no gui popups dammit!
      echo-keystrokes 0.5               ; echo keystrokes faster
      confirm-kill-processes nil        ; just kill the process
      disabled-command-function nil)    ; enable all commands

(menu-bar-mode -1)                      ; menu-bar is gone
(tool-bar-mode -1)                      ; tool-bar is gone
(scroll-bar-mode -1)                    ; scroll-bar is gone
(blink-cursor-mode 0)                   ; stop blinking on me!
(show-paren-mode t)                     ; highlight matching parens
(column-number-mode t)                  ; show column numbers

;; Scrolling
(setq mouse-wheel-scroll-amount '(1)    ; scroll gentle
      mouse-wheel-progressive-speed nil ; don't accelerate
      scroll-conservatively 101         ; don't jump to the middle of screen
      hscroll-margin 1                  ; don't you scroll that early!
      hscroll-step 1                    ; but scroll just a bit
      scroll-preserve-screen-position t) ; try to keep cursor in its position

;; retrieve closed windows/buffers
(winner-mode t)

;; alias yes.no
(defalias 'yes-or-no-p 'y-or-n-p)

;; save desktop
(desktop-save-mode t)
(save-place-mode t)

;; Security hype
(setq gnutls-verify-error t
      tls-checktrust t)

;; Disk space is cheap. Save lots. (c) Sacha Chua
;; Backups
(setq backup-directory-alist '(("." . "~/.emacs.d/backups"))
      delete-old-versions -1
      version-control t
      vc-make-backup-files t
      auto-save-list-file-prefix "~/.emacs.d/autosave/"
      auto-save-file-name-transforms '((".*" "~/.emacs.d/autosave/" t)))

;; But don't create stupid lockfiles
(setq create-lockfiles nil)

;; History
(setq savehist-file "~/.emacs.d/savehist"
      history-length t
      history-delete-duplicates t
      savehist-save-minibuffer-history 1
      savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring)
      recentf-max-saved-items 50)
(savehist-mode 1)
(recentf-mode 1)

;; undo-tree
(use-package undo-tree
  :config
  ;;turn on everywhere
  (global-undo-tree-mode 1)
  (global-set-key (kbd "C-/") 'undo)
  (global-set-key (kbd "C-S-/") 'undo-tree-redo))

;; move buffers
(use-package buffer-move
  :bind (("C-c b P" . buf-move-up)
         ("C-c b N" . buf-move-down)
         ("C-c b B" . buf-move-left)
         ("C-c b F" . buf-move-right)))

;; transpose buffers horizontally
(use-package transpose-frame
  :bind ("C-c b t" . flop-frame))

;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph
(defun ds/unfill-paragraph (&optional region)
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive (progn (barf-if-buffer-read-only) '(t)))
  (let ((fill-column (point-max))
        ;; This would override `fill-column' if it's an integer.
        (emacs-lisp-docstring-fill-column t))
    (fill-paragraph nil region)))
(global-set-key (kbd "C-c b u") 'ds/unfill-paragraph)
