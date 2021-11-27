;;; -*- lexical-binding: t -*-

(use-package org
  :hook ((org-mode . org-indent-mode)
         (org-mode . rainbow-delimiters-mode-disable))
  :config
  (require 'ob-clojure)
  (require 'ob-python)
  (setq org-ellipsis " ▾"
        org-directory "~/notes"
        org-agenda-span 10
        org-agenda-start-on-weekday nil
        org-agenda-start-day "0d"
        org-agenda-start-with-log-mode t
        org-log-done 'time
        org-log-into-drawer t
        org-startup-folded 'showall
        org-todo-keywords '("TODO" "NEXT" "DONE")
        org-src-fontify-natively t
        org-confirm-babel-evaluate nil
        org-babel-clojure-backend 'cider
        org-hide-leading-stars t
        org-hide-emphasis-markers t
        org-startup-with-inline-images t
        org-image-actual-width nil      ; use #+ATTR.* or fallback to original width

        ;; org-support-shift-select t
        ;; org-outline-path-complete-in-steps nil
        ;; org-src-tab-acts-natively nil
        ;; org-babel-hash-show-time t
        ;; org-src-preserve-indentation nil
        ;; org-clock-display-default-range 'untilnow
        ;; org-export-babel-evaluate nil
        ;; org-html-htmlize-output-type 'css
        ;; org-table-convert-region-max-lines 999
        ;; org-edit-src-content-indentation 2
        ;; org-hide-block-startup nil
        ;; org-cycle-separator-lines 2

        )
  (set-company-backend! '(org-journal-mode) 'company-capf 'company-dabbrev)
  ;; keys
  (global-set-key (kbd "C-c C-x C-k") 'org-clock-remove-overlays)
  (global-set-key (kbd "C-c o c") 'org-capture)
  (global-set-key (kbd "C-c o a") 'org-agenda)
  )

;; (setq org-capture-templates
;;       '(("l" "Link" entry (file+headline "~/notes/org/links.org" "Links")
;;          "* %? %^L %^g" :prepend t :kill-buffer t)
;;         ("t" "To Do Item" entry (file+headline "~/notes/org/todos.org" "ToDos")
;;          "* TODO %?\n%u" :prepend t :kill-buffer t)
;;         ("n" "Note" entry (file+headline "~/notes/org/todos.org" "Note space")
;;          "* %?\n%u" :prepend t :kill-buffer t)))

;; org bullets
(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("●" "◉" "•" )))

(use-package org-ql)
(use-package org-clock-export
  :straight (:host github :repo "legalnonsense/org-clock-export")
  :config
  (setq org-clock-export-files '("~/notes/org/baresquare/timesheet.org")
        org-clock-export-export-file-name "~/notes/org/baresquare/timesheet.csv"
        org-clock-export-data-format
        '("Name" "Konstantinos Filip"
          "Email" "konstantinos.fil@pixelated-noise.com"
          "Client" (or (org-entry-get (point) "CLIENT") "Vittle")
          "Project" (or (org-entry-get (point) "PROJECT") "FY21 - Backend Development")
          "Task" (or (org-entry-get (point) "TASK") "")
          "Description" (org-entry-get (point) "ITEM")
          "Billable" (or (org-entry-get (point) "BILLABLE") "")
          "Start Date" (concat start-day "/" start-month "/" start-year)
          "Start Time" (concat start-hour ":" start-minute ":00")
          "End Date" (concat end-day "/" end-month "/" end-year)
          "End Time" (concat end-hour ":" end-minute ":00")
          "Duration" (concat total-hours ":" total-minutes ":00")
          "Tags" (or (org-entry-get (point) "TAGS") "")
          "Amount" (or (org-entry-get (point) "AMOUNT") "")
          "Month" (concat start-month))))
