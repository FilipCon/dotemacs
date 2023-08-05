;; core settings
(setq ring-bell-function 'ignore        ; don't beep
      x-gtk-use-system-tooltips nil     ; no gui popups
      use-dialog-box nil                ; no gui popups dammit!
      echo-keystrokes 0.5               ; echo keystrokes faster
      confirm-kill-processes nil        ; just kill the process
      disabled-command-function nil     ; enable all commands
      vc-follow-symlinks t              ; follow link in vc files
      compilation-ask-about-save nil    ; auto save before compilation
      compilation-scroll-output t       ; follow Output in compilation buffer
      reb-re-syntax 'string             ; emacs regex syntax
      save-interprogram-paste-before-kill t ; save existing clipboard to kill ring
      sentence-end-double-space nil         ; single space ends sentence
      tab-always-indent 'complete           ; TAB indent or complete
      initial-scratch-message ""            ; empty scratch buffer
      eldoc-echo-area-use-multiline-p nil   ; no multiline eldoc
      undo-no-redo t                        ; don't go through redo retries
      global-auto-revert-non-file-buffers t ; revert other buffers
      initial-major-mode 'fundamental-mode) ; scratch buffer's default mode

(setq enable-local-variables :all)      ; WARNING don't ask me about .dir-locals - risky

;; global defaults
(setq-default
 fill-column 80                         ; 80 char rule
 word-wrap t                            ; wrap words
 indent-tabs-mode nil                   ; no tabs, only spaces
 require-final-newline t                ; always end with empty line
 tab-width 4)                           ; tab = 4 spaces

;; tramp + eshell
(require 'esh-module)
(add-to-list 'eshell-modules-list 'eshell-tramp)

;; core modes
(menu-bar-mode -1)                      ; menu-bar is gone
(tool-bar-mode -1)                      ; tool-bar is gone
(tooltip-mode -1)                       ; no popups ffs
(scroll-bar-mode -1)                    ; scroll-bar is gone
(blink-cursor-mode 0)                   ; stop blinking on me!
(show-paren-mode t)                     ; highlight matching parens
(column-number-mode t)                  ; show column numbers
(global-subword-mode t)                 ; move cursor within subwords
(normal-erase-is-backspace-mode t)      ; forward DELETE
(delete-selection-mode 1)               ; typing erases selection
(winner-mode t)                         ; retrieve closed windows/buffers
(save-place-mode t)                     ; save place in files
(desktop-save-mode t)                   ; save desktop
(global-so-long-mode t)                 ; long lines make emacs slow
(global-hl-line-mode t)                 ; highlight current line
(global-visual-line-mode nil)           ; disable visual line editting
(global-auto-revert-mode t)             ; auto refresh buffers
(global-eldoc-mode t)                   ; echo area doc
(global-hi-lock-mode t)                 ; highlight symbols
(electric-pair-mode t)                  ; matching delimiters
(fringe-mode 0)                         ; disable fringes

;; show line number in selected modes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'text-mode-hook 'display-line-numbers-mode)
(add-hook 'LaTeX-mode-hook 'display-line-numbers-mode)
(add-hook 'conf-mode-hook 'display-line-numbers-mode)

;; Scrolling
(setq scroll-conservatively 101         ; don't recenter cursor
      scroll-margin 1
      scroll-preserve-screen-position 1
      auto-window-vscroll nil
      mouse-wheel-progressive-speed nil
      mouse-wheel-scroll-amount '(2 ((shift) . hscroll))
      mouse-wheel-scroll-amount-horizontal 2)

;; remove hscroll-margin in shells, otherwise it causes jumpiness
(add-hook 'eshell-mode-hook (lambda () (setq hscroll-margin 0)))
(add-hook 'term-mode-hook (lambda () (setq hscroll-margin 0)))

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
(setq history-length 1000
      history-delete-duplicates t
      savehist-save-minibuffer-history t
      savehist-additional-variables '(search-ring regexp-search-ring)
      recentf-max-saved-items 100
      recentf-max-menu-items 100)
(savehist-mode 1)
(recentf-mode 1)

;; fonts
(set-face-attribute 'default nil
                    :font "SourceCodePro 13"
                    :weight 'medium)

(set-face-attribute 'variable-pitch nil
                    :font "DejaVuSans 14"
                    :weight 'medium)

(set-face-attribute 'fixed-pitch nil
                    :font "SourceCodePro 13"
                    :weight 'medium)
;; for emacs client
(add-to-list 'default-frame-alist '(font . "SourceCodePro 13"))
