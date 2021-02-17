;;; -*- lexical-binding: t -*-

;; ivy
(use-package ivy
  :bind
  ("C-r" . 'ivy-resume)
  :config
  (setq ivy-display-style 'fancy
        ivy-extra-directories nil
        ivy-initial-inputs-alist nil
        ivy-use-virtual-buffers t
        enable-recursive-minibuffers t
        ivy-wrap t)
  (setq ivy-re-builders-alist
        '((swiper . ivy--regex-plus)
          (t . ivy--regex-ignore-order)))
  :hook (after-init . ivy-mode))

;; sort completions
(use-package prescient
  :config
  (prescient-persist-mode 1)
  (setq-default prescient-filter-method
                '(literal regexp initialism)
                prescient-save-file
                (concat user-emacs-directory ".cache/prescient-save.el")))

(use-package ivy-prescient
  :after (ivy prescient)
  :config (setq ivy-prescient-retain-classic-highlighting t
                ivy-prescient-enable-filtering nil)
  (ivy-prescient-mode 1)
  (prescient-persist-mode 1))

(use-package ivy-rich
  :after ivy counsel
  :custom
  (ivy-virtual-abbreviate 'full)
  (ivy-rich-switch-buffer-align-virtual-buffer nil)
  (ivy-rich-path-style 'full)
  :config
  (ivy-rich-mode 1))

;; search tool
(use-package swiper
  :config
  (define-key ivy-mode-map (kbd "C-s") 'swiper-isearch)
  (define-key ivy-mode-map (kbd "C-M-s") 'swiper-isearch-thing-at-point))

;; counsel
(use-package counsel
  :config
  (counsel-mode 1))

;; ;; orderless completions for minibuffer and company
;; (use-package orderless
;;   :custom
;;   (completion-styles (list 'orderless))
;;   :config
;;   (setq orderless-component-separator "[ &]")
;;   (defun just-one-face (fn &rest args)
;;   (let ((orderless-match-faces [completions-common-part]))
;;     (apply fn args)))
;;   (advice-add 'company-capf--candidates :around #'just-one-face))
