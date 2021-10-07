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
  (global-set-key (kbd "C-x M-r") 'selectrum-repeat)
  (setq selectrum-fix-minibuffer-height t))

;; selectrum support
(use-package selectrum-prescient
  :after (selectrum prescient)
  :config
  (selectrum-prescient-mode 1)
  (prescient-persist-mode 1))

;; completion style
(use-package orderless
  :config
  (setq completion-styles '(orderless))
  (setq selectrum-refine-candidates-function #'orderless-filter)
  (setq selectrum-highlight-candidates-function #'orderless-highlight-matches)
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
  :bind
  ("C-c a" . embark-act)
  :config
  (setq embark-action-indicator
      (lambda (map _target)
        (which-key--show-keymap "Embark" map nil nil 'no-paging)
        #'which-key--hide-popup-ignore-command)
      embark-become-indicator embark-action-indicator))

;; enhanced commands on mini-buffer
(use-package consult
  :bind (("C-s" . consult-line)
         ("C-x C-r" . consult-recent-file)
         ([remap yank-pop] . consult-yank-pop)
         ([remap goto-line] . consult-goto-line)
         ([remap imenu] . consult-imenu))
  :config
  (setq-default consult-project-root-function #'projectile-project-root)
  (fset 'multi-occur #'consult-multi-occur))

(use-package embark-consult
  :after (consult embark)
  :hook (embark-collect . embark-consult-preview-minor-mode))

