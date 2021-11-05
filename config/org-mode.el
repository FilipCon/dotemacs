;;; -*- lexical-binding: t -*-

(use-package org
  :hook (org-mode . org-indent-mode)
  :config
  (setq org-ellipsis " ▾"
        org-directory "~/notes"
        org-agenda-span 10
        org-agenda-start-on-weekday nil
        org-agenda-start-day "0d"
        org-agenda-start-with-log-mode t
        org-log-done 'time
        org-log-into-drawer t
        org-startup-folded 'showall)
  (set-company-backend! '(org-journal-mode) 'company-capf 'company-dabbrev)
  ;; keys
  (global-set-key (kbd "C-c o c") 'org-capture)
  (global-set-key (kbd "C-c o a") 'org-agenda))

;; (setq org-capture-templates
;;       '(("l" "Link" entry (file+headline "~/notes/org/links.org" "Links")
;;          "* %? %^L %^g" :prepend t :kill-buffer t)
;;         ("t" "To Do Item" entry (file+headline "~/notes/org/todos.org" "ToDos")
;;          "* TODO %?\n%u" :prepend t :kill-buffer t)
;;         ("n" "Note" entry (file+headline "~/notes/org/todos.org" "Note space")
;;          "* %?\n%u" :prepend t :kill-buffer t)))

;; org bullets
(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

(use-package org-ql)

(use-package org-clock-export
  :straight (:host github :repo "legalnonsense/org-clock-export")
  :config
  (setq org-clock-export-files '("~/notes/org/baresquare/timesheet.org")
        org-clock-export-export-file-name "~/notes/org/baresquare/timesheet.csv"
        org-clock-export-data-format '("Name" "Konstantinos Filip"
                                       "Email" "konstantinos.fil@pixelated-noise.com"
                                       "Client" (or (org-entry-get (point) "CLIENT") "")
                                       "Project" (or (org-entry-get (point) "PROJECT") "")
                                       "Task" (or (org-entry-get (point) "TASK") "")
                                       "Description" (org-entry-get (point) "ITEM")
                                       "Billable" (or (org-entry-get (point) "BILLABLE") "")
                                       "Start Date" (concat start-day "/" start-month "/" start-year)
                                       "Start Time" (concat start-hour ":" start-minute)
                                       "End Date" (concat end-day "/" end-month "/" end-year)
                                       "End Time" (concat end-hour ":" end-minute)
                                       "Duration" (concat total-hours ":" total-minutes)
                                       "Tags" (or (org-entry-get (point) "TAGS") "")
                                       "Amount" (or (org-entry-get (point) "AMOUNT") "")
                                       "Month" (concat start-month))))

;; (use-package org-super-agenda
;;   :config
;;   (org-super-agenda-mode))

;; ;; task timer
;; (use-package org-pomodoro)

;; ;; jira
;; (use-package ox-jira)
