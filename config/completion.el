;;; -*- lexical-binding: t -*-

(use-package company
  :custom
  (company-require-match nil)
  (company-minimum-prefix-length 1)
  (company-idle-delay nil)
  (company-tooltip-align-annotation t)
  (company-frontends '(company-pseudo-tooltip-frontend
		               company-echo-metadata-frontend))
  :commands (company-mode global-company-mode company-complete
                          company-complete-common company-manual-begin
                          company-grab-line)
  :bind (
         :map company-active-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous))
  :hook ((prog-mode . company-mode)
         (comint-mode . company-mode)))

(use-package company-quickhelp
  :after company
  :commands (company-quickhelp-mode)
  :init
  (company-quickhelp-mode t)
  (use-package pos-tip
    :commands (pos-tip-show)))


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
