;;; -*- lexical-binding: t -*-

(setq ring-bell-function 'ignore        ; don't beep
      x-gtk-use-system-tooltips nil     ; no gui popups
      use-dialog-box nil                ; no gui popups dammit!
      echo-keystrokes 0.5               ; echo keystrokes faster
      confirm-kill-processes nil        ; just kill the process
      disabled-command-function nil)    ; enable all commands

(setq-default
 vc-follow-symlinks t
 save-interprogram-paste-before-kill t
 fill-column 80
 sentence-end-double-space nil
 word-wrap t
 indent-tabs-mode nil
 require-final-newline t
 tab-always-indent t
 tab-width 4
 truncate-lines t
 truncate-partial-width-windows 50
 message-log-max 16384
 gc-cons-percentage 0.1
 read-process-output-max (* 64 1024))

(require 'esh-module)
(add-to-list 'eshell-modules-list 'eshell-tramp)

(setq compilation-ask-about-save nil)   ; auto save before compilation
(setq compilation-scroll-output t)      ; follow Output in compilation buffer
(setq reb-re-syntax 'string)

(menu-bar-mode -1)                      ; menu-bar is gone
(tool-bar-mode -1)                      ; tool-bar is gone
(scroll-bar-mode -1)                    ; scroll-bar is gone
(blink-cursor-mode 0)                   ; stop blinking on me!
(show-paren-mode t)                     ; highlight matching parens
(column-number-mode t)                  ; show column numbers
(global-subword-mode t)
(normal-erase-is-backspace-mode 2)
(delete-selection-mode 1)
(winner-mode t)                         ; retrieve closed windows/buffers
(save-place-mode t)                     ; Save place in files
(desktop-save-mode t)                   ; save desktop
(global-so-long-mode t)                 ; long lines make emacs slow
(global-hl-line-mode t)                 ; highlight current line
(global-visual-line-mode t)

;; auto-revert mode
(global-auto-revert-mode t)
(setq auto-revert-interval 5
      auto-revert-verbose nil
      auto-revert-remote-files t
      auto-revert-check-vc-info t
      global-auto-revert-non-file-buffers nil)

;; show line number in selected modes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'text-mode-hook 'display-line-numbers-mode)
(add-hook 'LaTeX-mode-hook 'display-line-numbers-mode)
(add-hook 'conf-mode-hook 'display-line-numbers-mode)

;; Scrolling
(setq mouse-wheel-progressive-speed nil
      hscroll-margin 2
      hscroll-step 1
      scroll-conservatively 101
      scroll-margin 0
      scroll-preserve-screen-position t
      auto-window-vscroll nil
      mouse-wheel-scroll-amount '(5 ((shift) . 2))
      mouse-wheel-progressive-speed nil)

;; Remove hscroll-margin in shells, otherwise it causes jumpiness
(add-hook 'eshell-mode-hook (lambda() (setq hscroll-margin 0)))
(add-hook 'term-mode-hook (lambda() (setq hscroll-margin 0)))

;; alias yes.no
(defalias 'yes-or-no-p 'y-or-n-p)

;; more useful frame title
(setq frame-title-format '((:eval (if (buffer-file-name)
                                      (abbreviate-file-name (buffer-file-name))
                                    "%b"))))

;; Backups
(setq backup-directory-alist '(("." . "~/.emacs.d/backups"))
      delete-old-versions t
      version-control t
      vc-make-backup-files t
      auto-save-list-file-prefix "~/.emacs.d/autosave/"
      auto-save-file-name-transforms '((".*" "~/.emacs.d/autosave/" t)))

;; But don't create stupid lockfiles
(setq create-lockfiles nil)

;; History
(setq savehist-file "~/.emacs.d/savehist"
      history-length 1000
      history-delete-duplicates t
      savehist-save-minibuffer-history t
      savehist-additional-variables
      '(kill-ring search-ring regexp-search-ring)
      recentf-max-saved-items 50)
(savehist-mode 1)
(recentf-mode 1)

;; stop minimizing, its annoying
(global-unset-key [?\C-z])

;; default font size
(set-face-attribute 'default nil :height 140)
