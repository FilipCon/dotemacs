;;; -*- lexical-binding: t -*-

;; sort completions
(use-package prescient
  :config
  (prescient-persist-mode 1)
  (setq-default prescient-save-file
                (concat user-emacs-directory ".cache/prescient-save.el")))

;; ivy alternative
(use-package selectrum
  :config
  (selectrum-mode)
  (global-set-key (kbd "C-x M-r") 'selectrum-repeat) ; bug: don't use bind for some reason
  (setq selectrum-fix-minibuffer-height t))

;; selectrum support
(use-package selectrum-prescient
  :after (selectrum prescient)
  :config
  (selectrum-prescient-mode 1)          ; bug: don't use hooks
  (prescient-persist-mode 1))

;; completion style
(use-package orderless
  :config
  (defun orderless-highlight-matches+ (input cands)
    (let ((cands (if (eq 'file (completion-metadata-get
                                (completion-metadata
                                 input
                                 minibuffer-completion-table
                                 minibuffer-completion-predicate)
                                'category))
                     (cl-loop for cand in cands
                              for len = (length cand)
                              if (and (> len 0)
                                      (eq (aref cand (1- len)) ?/))
                              collect (progn (add-face-text-property
                                              0 (length cand)
                                              'dired-directory
                                              'append cand)
                                             cand)
                              else
                              collect cand)
                   cands)))
      (selectrum-prescient--highlight input cands)
      (orderless-highlight-matches input cands)))
  (setq completion-styles '(orderless))
  (setq selectrum-refine-candidates-function #'orderless-filter)
  (setq selectrum-highlight-candidates-function #'orderless-highlight-matches+)
  (setq orderless-component-separator "[ -]")
  (defun just-one-face (fn &rest args)
  (let ((orderless-match-faces [completions-common-part]))
    (apply fn args)))
  (advice-add 'company-capf--candidates :around #'just-one-face))

;; mini-buffer annotations (ivy-rich alternative)
(use-package marginalia
  :after selectrum
  :config
  (marginalia-mode)
  (setq-default marginalia-annotators '(marginalia-annotators-heavy)))

;; mini-buffer actions
(use-package embark
  :bind ("C-c a" . embark-act)
  :config
  (setq embark-action-indicator
      (lambda (map _target)
        (which-key--show-keymap "Embark" map nil nil 'no-paging)
        #'which-key--hide-popup-ignore-command)
      embark-become-indicator embark-action-indicator))

;; enhanced commands on mini-buffer
(use-package consult
  :commands (consult-customize)
  :bind (("C-s" . consult-line)
         ("C-x C-r" . consult-recent-file)
         ("C-x r g" . consult-ripgrep)
         ([remap yank-pop] . consult-yank-pop)
         ([remap goto-line] . consult-goto-line)
         ([remap imenu] . consult-imenu))
  :config
  (consult-customize
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-file consult--source-project-file consult--source-bookmark
   :preview-key (kbd "M-."))
  ;; (setq consult-preview-key (kbd "M-."))
  (setq consult-line-start-from-top t
        consult-project-root-function
        (lambda ()
          (when-let (project (project-current))
            (car (project-roots project)))))
  (fset 'multi-occur #'consult-multi-occur))

(use-package embark-consult
  :after (consult embark)
  :hook (embark-collect . embark-consult-preview-minor-mode))
