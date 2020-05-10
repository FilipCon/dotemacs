;;; -*- lexical-binding: t -*-

(global-hl-line-mode t)

(global-visual-line-mode 1)
(global-display-line-numbers-mode 1)


;; (setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
;; (fringe-mode 8)

; Git Gutter
 ;;Git gutter is great for giving visual feedback on changes, but it doesn't play well
 ;;with org-mode using org-indent. So I don't use it globally.
 (use-package git-gutter
   :defer t
   :hook ((markdown-mode . git-gutter-mode)
          (prog-mode . git-gutter-mode)
          (conf-mode . git-gutter-mode)
          (org-mode . git-gutter-mode))
   :config
   (setq git-gutter:disabled-modes '(org-mode asm-mode image-mode)
         git-gutter:update-interval 1
         git-gutter:window-width 2
         git-gutter:ask-p nil))

 (use-package git-gutter-fringe
    :commands git-gutter-mode
    ;; :diminish git-gutter-mode
    :after git-gutter
    :demand fringe-helper
    :init
       (progn
       (when (display-graphic-p)
         (with-eval-after-load 'git-gutter
           (require 'git-gutter-fringe)))
       (setq git-gutter-fr:side 'left-fringe))
    :config
    ;; subtle diff indicators in the fringe
    ;; places the git gutter outside the margins.
    (setq-default fringes-outside-margins t)
    ;; thin fringe bitmaps
    (define-fringe-bitmap 'git-gutter-fr:added   [224]
      nil nil '(center repeated))
    (define-fringe-bitmap 'git-gutter-fr:modified   [224]
      nil nil '(center repeated))
    (define-fringe-bitmap 'git-gutter-fr:deleted   [128 192 224 240]
      nil nil 'bottom))


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
    (doom-themes-neotree-config) ;; Enable custom neotree theme
    (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
    (doom-themes-treemacs-config)
    (doom-themes-org-config)) ;; Corrects (and improves) org-mode's native fontification.


(use-package all-the-icons
  :config
  ;; all-the-icons doesn't work without font-lock+
  ;; And font-lock+ doesn't have autoloads
  (use-package font-lock+
    :straight (:host github :repo "emacsmirror/font-lock-plus")
    :config (require 'font-lock+)))

(use-package which-key
  :init (which-key-mode))

(use-package company-box
  :after (company all-the-icons)
  :hook (company-mode . company-box-mode)
  :config
  (setq
   company-box-show-single-candidate t
   company-box-icons-elisp
   (list (all-the-icons-material "functions"                  :height 0.8 :face 'all-the-icons-red)
         (all-the-icons-material "check_circle"               :height 0.8 :face 'all-the-icons-blue)
         (all-the-icons-material "stars"                      :height 0.8 :face 'all-the-icons-orange)
         (all-the-icons-material "format_paint" :height 0.8 :face 'all-the-icons-pink))
   company-box-icons-lsp
   `((1  . ,(all-the-icons-material "text_fields"              :height 0.8 :face 'all-the-icons-green)) ; text
     (2  . ,(all-the-icons-material "functions"                :height 0.8 :face 'all-the-icons-red))   ; method
     (3  . ,(all-the-icons-material "functions"                :height 0.8 :face 'all-the-icons-red))   ; function
     (4  . ,(all-the-icons-material "functions"                :height 0.8 :face 'all-the-icons-red))   ; constructor
     (5  . ,(all-the-icons-material "functions"                :height 0.8 :face 'all-the-icons-red))   ; field
     (6  . ,(all-the-icons-material "adjust"                   :height 0.8 :face 'all-the-icons-blue))  ; variable
     (7  . ,(all-the-icons-material "class"                    :height 0.8 :face 'all-the-icons-red))   ; class
     (8  . ,(all-the-icons-material "settings_input_component" :height 0.8 :face 'all-the-icons-red))   ; interface
     (9  . ,(all-the-icons-material "view_module"              :height 0.8 :face 'all-the-icons-red))   ; module
     (10 . ,(all-the-icons-material "settings"                 :height 0.8 :face 'all-the-icons-red))   ; property
     (11 . ,(all-the-icons-material "straighten"               :height 0.8 :face 'all-the-icons-red))   ; unit
     (12 . ,(all-the-icons-material "filter_1"                 :height 0.8 :face 'all-the-icons-red))   ; value
     (13 . ,(all-the-icons-material "plus_one"                 :height 0.8 :face 'all-the-icons-red))   ; enum
     (14 . ,(all-the-icons-material "filter_center_focus"      :height 0.8 :face 'all-the-icons-red))   ; keyword
     (15 . ,(all-the-icons-material "short_text"               :height 0.8 :face 'all-the-icons-red))   ; snippet
     (16 . ,(all-the-icons-material "color_lens"               :height 0.8 :face 'all-the-icons-red))   ; color
     (17 . ,(all-the-icons-material "insert_drive_file"        :height 0.8 :face 'all-the-icons-red))   ; file
     (18 . ,(all-the-icons-material "collections_bookmark"     :height 0.8 :face 'all-the-icons-red))   ; reference
     (19 . ,(all-the-icons-material "folder"                   :height 0.8 :face 'all-the-icons-red))   ; folder
     (20 . ,(all-the-icons-material "people"                   :height 0.8 :face 'all-the-icons-red))   ; enumMember
     (21 . ,(all-the-icons-material "pause_circle_filled"      :height 0.8 :face 'all-the-icons-red))   ; constant
     (22 . ,(all-the-icons-material "streetview"               :height 0.8 :face 'all-the-icons-red))   ; struct
     (23 . ,(all-the-icons-material "event"                    :height 0.8 :face 'all-the-icons-red))   ; event
     (24 . ,(all-the-icons-material "control_point"            :height 0.8 :face 'all-the-icons-red))   ; operator
     (25 . ,(all-the-icons-material "class" :height 0.8 :face 'all-the-icons-red))))
  )

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
      centaur-tabs-set-bar 'under
      x-underline-at-descent-line t)
   (centaur-tabs-headline-match)
   (setq centaur-tabs-gray-out-icons 'buffer)
   ;; (centaur-tabs-enable-buffer-reordering)
   ;; (setq centaur-tabs-adjust-buffer-order t)
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
   ("C-<prior>" . centaur-tabs-backward)
   ("C-<next>" . centaur-tabs-forward)
   ("C-c t s" . centaur-tabs-counsel-switch-group)
   ("C-c t p" . centaur-tabs-group-by-projectile-project)
   ("C-c t g" . centaur-tabs-group-buffer-groups))
