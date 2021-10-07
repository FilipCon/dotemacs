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
 truncate-partial-width-windows 50)

(setq compilation-ask-about-save nil) ; auto save before complilation
(setq compilation-scroll-output t) ; follow Output in compilation buffer
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

;; retrieve closed windows/buffers
(winner-mode t)

;; Save place in files
(save-place-mode 1)

;; alias yes.no
(defalias 'yes-or-no-p 'y-or-n-p)

;; save desktop
(desktop-save-mode t)
(save-place-mode t)

;; more useful frame title
(setq frame-title-format '((:eval (if (buffer-file-name)
                                 (abbreviate-file-name (buffer-file-name))
                               "%b"))))

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

;; Treats the `_' as a word constituent
(add-hook 'after-change-major-mode-hook
          (lambda ()
            (modify-syntax-entry ?_ "w")))

;; stop minimizing, its annoying
(global-unset-key [?\C-z])

(set-face-attribute 'default nil :height 140)
