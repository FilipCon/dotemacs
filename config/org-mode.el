(straight-override-recipe
 '(org :type git :host github :repo "emacsmirror/org" :no-build t))

(use-package org
  :hook(org-mode . org-indent-mode)
  :config
  (setq org-ellipsis " ▾"
        org-agenda-start-with-log-mode t
        org-log-done 'time
        org-log-into-drawer t
        org-hide-emphasis-markers t
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 2
        org-hide-block-startup nil
        org-src-preserve-indentation nil
        org-startup-folded 'content
        org-cycle-separator-lines 2))

(setq org-agenda-files (list "~/Documents/notes/orgfiles/todos.org"))

;; org bullets
(use-package org-superstar
  :after org
  :hook (org-mode . org-superstar-mode)
  :custom
  (org-superstar-remove-leading-stars t))

;; task timer
(use-package org-pomodoro)

;; ;; calendar
;; (use-package calfw)
;; (use-package calfw-org)
