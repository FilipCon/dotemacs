;;; -*- lexical-binding: t -*-

(use-package company
  :commands company-complete-common company-manual-begin company-grab-line
  :init
  (setq company-idle-delay 0.25
        company-minimum-prefix-length 2
        company-tooltip-limit 14
        company-dabbrev-downcase nil
        company-tooltip-align-annotations t
        company-eclim-auto-save nil       ; Stop eclim auto save.
        company-require-match 'never
        company-global-modes
        '(not erc-mode message-mode help-mode gud-mode eshell-mode)
        company-backends  '(company-capf)
        company-frontends '(company-pseudo-tooltip-frontend
                            company-echo-metadata-frontend))
  :bind (
         :map company-active-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous))
  :hook (after-init . global-company-mode)
  :config
  ;; Enable downcase only when completing the completion.
  (defun jcs--company-complete-selection--advice-around (fn)
    "Advice execute around `company-complete-selection' command."
    (let ((company-dabbrev-downcase t))
      (call-interactively fn)))
  (advice-add 'company-complete-selection :around #'jcs--company-complete-selection--advice-around))

;; fuzzy auto complition
(use-package company-fuzzy
  :init
  (setq company-fuzzy-sorting-backend 'alphabetic)
  (setq company-fuzzy-prefix-ontop nil)
  (with-eval-after-load 'company
    (global-company-fuzzy-mode t)))

;; quick tips
(use-package company-quickhelp
  :after company
  :commands (company-quickhelp-mode)
  :init
  (company-quickhelp-mode t)
  (use-package pos-tip
    :commands (pos-tip-show)))

;; sort completions
(use-package company-prescient
  :hook (company-mode . company-prescient-mode)
  :config
  ;; NOTE prescient config duplicated with `ivy'
  (setq prescient-save-file (concat user-emacs-directory ".cache/prescient-save.el"))
  (prescient-persist-mode +1))

;; (use-package company-box
;;   :after (company all-the-icons)
;;   :hook (company-mode . company-box-mode)
  ;; :config
  ;; (setq company-box-show-single-candidate t
  ;;       company-box-backends-colors nil
  ;;       company-box-max-candidates 50
  ;;       company-box-icons-alist 'company-box-icons-all-the-icons
  ;;       company-box-icons-functions
  ;;       (cons #'+company-box-icons--elisp-fn
  ;;             (delq 'company-box-icons--elisp
  ;;                   company-box-icons-functions))
  ;;       company-box-icons-all-the-icons
  ;;       (let ((all-the-icons-scale-factor 0.8))
  ;;         `((Unknown       . ,(all-the-icons-material "find_in_page"             :face 'all-the-icons-purple))
  ;;           (Text          . ,(all-the-icons-material "text_fields"              :face 'all-the-icons-green))
  ;;           (Method        . ,(all-the-icons-material "functions"                :face 'all-the-icons-red))
  ;;           (Function      . ,(all-the-icons-material "functions"                :face 'all-the-icons-red))
  ;;           (Constructor   . ,(all-the-icons-material "functions"                :face 'all-the-icons-red))
  ;;           (Field         . ,(all-the-icons-material "functions"                :face 'all-the-icons-red))
  ;;           (Variable      . ,(all-the-icons-material "adjust"                   :face 'all-the-icons-blue))
  ;;           (Class         . ,(all-the-icons-material "class"                    :face 'all-the-icons-red))
  ;;           (Interface     . ,(all-the-icons-material "settings_input_component" :face 'all-the-icons-red))
  ;;           (Module        . ,(all-the-icons-material "view_module"              :face 'all-the-icons-red))
  ;;           (Property      . ,(all-the-icons-material "settings"                 :face 'all-the-icons-red))
  ;;           (Unit          . ,(all-the-icons-material "straighten"               :face 'all-the-icons-red))
  ;;           (Value         . ,(all-the-icons-material "filter_1"                 :face 'all-the-icons-red))
  ;;           (Enum          . ,(all-the-icons-material "plus_one"                 :face 'all-the-icons-red))
  ;;           (Keyword       . ,(all-the-icons-material "filter_center_focus"      :face 'all-the-icons-red))
  ;;           (Snippet       . ,(all-the-icons-material "short_text"               :face 'all-the-icons-red))
  ;;           (Color         . ,(all-the-icons-material "color_lens"               :face 'all-the-icons-red))
  ;;           (File          . ,(all-the-icons-material "insert_drive_file"        :face 'all-the-icons-red))
  ;;           (Reference     . ,(all-the-icons-material "collections_bookmark"     :face 'all-the-icons-red))
  ;;           (Folder        . ,(all-the-icons-material "folder"                   :face 'all-the-icons-red))
  ;;           (EnumMember    . ,(all-the-icons-material "people"                   :face 'all-the-icons-red))
  ;;           (Constant      . ,(all-the-icons-material "pause_circle_filled"      :face 'all-the-icons-red))
  ;;           (Struct        . ,(all-the-icons-material "streetview"               :face 'all-the-icons-red))
  ;;           (Event         . ,(all-the-icons-material "event"                    :face 'all-the-icons-red))
  ;;           (Operator      . ,(all-the-icons-material "control_point"            :face 'all-the-icons-red))
  ;;           (TypeParameter . ,(all-the-icons-material "class"                    :face 'all-the-icons-red))
  ;;           (Template      . ,(all-the-icons-material "short_text"               :face 'all-the-icons-green))
  ;;           (ElispFunction . ,(all-the-icons-material "functions"                :face 'all-the-icons-red))
  ;;           (ElispVariable . ,(all-the-icons-material "check_circle"             :face 'all-the-icons-blue))
  ;;           (ElispFeature  . ,(all-the-icons-material "stars"                    :face 'all-the-icons-orange))
  ;;           (ElispFace     . ,(all-the-icons-material "format_paint"             :face 'all-the-icons-pink)))))

  ;;   (defun +company-box-icons--elisp-fn (candidate)
  ;;   (when (derived-mode-p 'emacs-lisp-mode)
  ;;     (let ((sym (intern candidate)))
  ;;       (cond ((fboundp sym)  'ElispFunction)
  ;;             ((boundp sym)   'ElispVariable)
  ;;             ((featurep sym) 'ElispFeature)
  ;;             ((facep sym)    'ElispFace)))))

    ;; )

