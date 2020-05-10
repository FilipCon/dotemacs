;;; -*- lexical-binding: t -*-

(use-package dashboard
    :config
    (dashboard-setup-startup-hook)
    (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
    ;; Set the title
    (setq dashboard-banner-logo-title "Welcome to Emacs Dashboard")

    ;; Set the banner
    (setq dashboard-startup-banner 'logo)

    ;; Content is not centered by default. To center, set
    (setq dashboard-center-content t)

    ;; To disable shortcut "jump" indicators for each section, set
    (setq dashboard-show-shortcuts nil)
    (setq dashboard-items '((recents  . 5)
                            (bookmarks . 5)
                            (projects . 5)
                            (agenda . 5)
                            (registers . 5)))
    (setq dashboard-set-heading-icons t)
    (setq dashboard-set-file-icons t)
    (setq dashboard-set-navigator t)
    (setq dashboard-set-footer nil))
