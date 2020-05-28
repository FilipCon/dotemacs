;;; -*- lexical-binding: t -*-

;; ivy
(use-package ivy
  :config
  (setq ivy-display-style 'fancy
        ivy-count-format "" ;
        ivy-initial-inputs-alist nil ; remove initial ^ input.
        ivy-extra-directories nil ; remove . and .. directory.)
        ivy-use-virtual-buffers t
        ivy-case-fold-search-default t)
  ;; Counsel changes a lot of ivy's state at startup; to control for that, we
  ;; need to load it as early as possible. Some packages (like `ivy-prescient')
  ;; require this.
  (require 'counsel nil t)
  (setq ivy-re-builders-alist
        '((swiper . ivy--regex-plus)
          (t . ivy--regex-ignore-order)))
  :hook (after-init . ivy-mode))

;; sort completions
(use-package ivy-prescient
  :hook ((ivy-mode . ivy-prescient-mode)
         (ivy-prescient-mode . prescient-persist-mode))
  :config
  (setq prescient-filter-method
        '(literal regexp initialis))
  (setq ivy-prescient-sort-commands
        '(not swiper swiper-isearch ivy-switch-buffer counsel-grep
              counsel-git-grep counsel-ag counsel-rg counsel-imenu
              counsel-yank-pop counsel-recentf counsel-buffer-or-recentf)
        ivy-prescient-retain-classic-highlighting t)
  (setq prescient-save-file (concat user-emacs-directory ".cache/prescient-save.el")))

;; remember last commands
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
  :hook (ivy-mode . counsel-mode)
  :config
  (setq-default counsel-mode-override-describe-bindings t)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-s-s") 'counsel-rg))

(use-package flx)
