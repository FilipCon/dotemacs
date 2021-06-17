;;; -*- lexical-binding: t -*-

(load (concat (file-name-directory user-init-file) "gcal.el"))

(use-package org
  :config
  (add-hook 'org-mode 'org-indent-mode)
  (setq org-ellipsis " ▾"
        org-directory "~/notes"
        ;; org-agenda-start-with-log-mode t
        org-agenda-span 10
        org-agenda-start-on-weekday nil
        org-agenda-start-day "0d"
        org-log-done 'time
        org-todo-keywords '((sequence "TODO" "PROG" "BLOK" "DONE"))
        org-support-shift-select t
        org-hide-emphasis-markers nil
        org-hide-leading-stars t
        org-confirm-babel-evaluate nil
        org-outline-path-complete-in-steps nil
        org-src-fontify-natively t
        org-src-tab-acts-natively nil
        org-babel-hash-show-time t
        org-src-preserve-indentation nil
        org-startup-with-inline-images t
        org-clock-display-default-range 'untilnow
        org-clock-into-drawer nil
        org-export-babel-evaluate nil
        org-image-actual-width nil
        org-html-htmlize-output-type 'css
        org-table-convert-region-max-lines 999
        ;; org-edit-src-content-indentation 2
        ;; org-hide-block-startup nil
        ;; org-cycle-separator-lines 2
        org-startup-folded 'showall)
  (set-company-backend! '(org-journal-mode) 'company-capf 'company-dabbrev)
  ;; keys
  (global-set-key (kbd "C-c o c") 'org-capture)
  (global-set-key (kbd "C-c o a") 'org-agenda)
  (global-set-key (kbd "C-c o p") 'org-projectile-project-todo-completing-read))

(use-package org-super-agenda
  :config
  (org-super-agenda-mode))

;; org bullets
(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

;; task timer
(use-package org-pomodoro)

;; jira
(use-package ox-jira)

;; projectile todos
(use-package org-projectile
  :after (org projectile)
  :config
  (setq org-projectile-projects-file "~/notes/org/projects.org")
  (push (org-projectile-project-todo-entry) org-capture-templates)
  ;; org files
  (setq org-agenda-files '("~/notes/org/todos.org"
                          "~/notes/org/gcal.org"
                          "~/notes/org/notes.org"
                          "~/notes/org/links.org"
                          "~/notes/org/projects.org")))

;; google calendar
(use-package org-gcal
  :straight
  (:type git :host github :repo "kidd/org-gcal.el")
  :defines (my/org-gcal-client-id
            my/org-gcal-client-secret)
  :hook ((org-agenda-mode . org-gcal-sync)
         (org-capture-after-finalize . org-gcal-sync))
  :config
  (setq org-gcal-client-id my/org-gcal-client-id
        org-gcal-client-secret my/org-gcal-client-secret
        org-gcal-fetch-file-alist '(("filipconstantinos@gmail.com" .  "~/notes/org/gcal.org")
                                    ("konstantinos.fil@pixelated-noise.com" .  "~/notes/org/gcal.org"))))

(setq org-capture-templates
      '(("a" "Appointment" entry (file  "~/notes/org/gcal.org" )
         "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
        ("l" "Link" entry (file+headline "~/notes/org/links.org" "Links")
         "* %? %^L %^g" :prepend t)
        ("t" "To Do Item" entry (file+headline "~/notes/org/todos.org" "ToDos")
         "* TODO %?\n%u" :prepend t)
        ("n" "Note" entry (file+headline "~/notes/org/todos.org" "Note space")
         "* %?\n%u" :prepend t)))
