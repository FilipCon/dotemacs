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
(setq mouse-wheel-progressive-speed nil
      hscroll-margin 2
      hscroll-step 1
      ;; Emacs spends too much effort recentering the screen if you scroll the
      ;; cursor more than N lines past window edges (where N is the settings of
      ;; `scroll-conservatively'). This is especially slow in larger files
      ;; during large-scale scrolling commands. If kept over 100, the window is
      ;; never automatically recentered.
      scroll-conservatively 101
      scroll-margin 0
      scroll-preserve-screen-position t
      ;; Reduce cursor lag by a tiny bit by not auto-adjusting `window-vscroll'
      ;; for tall lines.
      auto-window-vscroll nil
      ;; mouse
      mouse-wheel-scroll-amount '(5 ((shift) . 2))
      mouse-wheel-progressive-speed nil)  ; don't accelerate scrolling

;; Remove hscroll-margin in shells, otherwise it causes jumpiness
(add-hook 'eshell-mode-hook (lambda() (setq hscroll-margin 0)))
(add-hook 'term-mode-hook (lambda() (setq hscroll-margin 0)))

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
