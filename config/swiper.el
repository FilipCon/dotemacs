;;; -*- lexical-binding: t -*-

(use-package ivy
  :config
  (setq-default ivy-use-virtual-buffers t
                ivy-count-format ""
                projectile-completion-system 'ivy
                ivy-initial-inputs-alist
                '((counsel-M-x . "^")
                  (man . "^")
                  (woman . "^")))
  ;; IDO-style directory navigation
  (define-key ivy-minibuffer-map (kbd "C-j") #'ivy-immediate-done)
  (define-key ivy-minibuffer-map (kbd "RET") #'ivy-alt-done)
  (defun ds/enable-ivy-flx-matching ()
    "Make `ivy' matching work more like IDO."
    (interactive)
    (require-package 'flx)
    (setq-default ivy-re-builders-alist
                  '((t . ivy--regex-fuzzy))))
  :hook (after-init .
                    (lambda ()
                      (when (bound-and-true-p ido-ubiquitous-mode)
                        (ido-ubiquitous-mode -1))
                      (when (bound-and-true-p ido-mode)
                        (ido-mode -1))
                      (ivy-mode 1))))

(use-package ivy-prescient
  :hook ((ivy-mode . ivy-prescient-mode)
         (ivy-prescient-mode . prescient-persist-mode))
  :config
  (setq prescient-filter-method
        '(literal regexp initialism))
  (setq ivy-prescient-sort-commands
        '(:not swiper swiper-isearch ivy-switch-buffer counsel-grep
               counsel-git-grep counsel-ag counsel-rg counsel-imenu
               counsel-yank-pop counsel-recentf counsel-buffer-or-recentf)
        ivy-prescient-retain-classic-highlighting t)
  (defun +ivy-prescient-non-fuzzy (str)
    (let ((prescient-filter-method '(literal regexp)))
      (ivy-prescient-re-builder str)))

  ;; NOTE prescient config duplicated with `company'
  (setq prescient-save-file (concat user-emacs-directory ".cache/prescient-save.el")))


(use-package amx
  :defer t
  :config
  (setq amx-save-file (concat user-emacs-directory ".cache/amx-items")))

(use-package swiper
  :after ivy
  :config
  (define-key ivy-mode-map (kbd "C-s") 'swiper))

(use-package counsel
  :after swiper
  :config
  (setq-default counsel-mode-override-describe-bindings t)
  :hook (after-init . counsel-mode))

