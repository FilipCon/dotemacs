;;; -*- lexical-binding: t -*-

;; sort completions
(use-package prescient
  :config
  (prescient-persist-mode 1)
  (setq-default prescient-filter-method
                '(literal regexp initialism)
                prescient-save-file
                (concat user-emacs-directory ".cache/prescient-save.el")))

;; ivy alternative
(use-package selectrum
  :config
  (selectrum-mode)
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
  :after (projectile)
  :bind (("C-s" . consult-line))
  :config
  (setq-default consult-project-root-function #'projectile-project-root)
  (fset 'multi-occur #'consult-multi-occur)
  ;; remap bindings
  (global-set-key [remap apropos] 'consult-apropos)
  (global-set-key [remap goto-line] 'consult-goto-line)
  (global-set-key [remap imenu] 'consult-imenu)
  (global-set-key [remap switch-to-buffer] 'consult-buffer)
  (global-set-key [remap switch-to-buffer-other-window] 'consult-buffer-other-window)
  (global-set-key [remap switch-to-buffer-other-frame] 'consult-buffer-other-frame)
  (global-set-key [remap man] 'consult-man)
  (global-set-key [remap yank-pop] 'consult-yank-pop)
  (global-set-key [remap locate] 'consult-locate)
  (global-set-key [remap recentf-open-files] 'consult-recent-file))

(use-package consult-flycheck
  :after (consult flycheck))

(use-package embark-consult
  :after (consult embark)
  :hook (embark-collect . embark-consult-preview-minor-mode))

