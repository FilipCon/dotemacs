(defun fill-to-end ()
  "Fill with `-' until fill column."
  (interactive)
  (save-excursion
    (end-of-line)
    (while (< (current-column) 80)
      (insert-char ?-))))
(global-set-key (kbd "<f8>") 'fill-to-end)

(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))
(global-set-key (kbd "C-c d") #'duplicate-current-line-or-region)

;; -----------------------------------------------------------------------------

;; tld
(use-package tldr)

;; jump
(use-package avy
  :bind ("M-j" . avy-goto-char-timer)
  :config
  (setq avy-timeout-seconds 100000))

;; indentation tools
(use-package indent-tools)

;; highlight specific words
(use-package hl-todo
  :hook ((prog-mode text-mode) . hl-todo-mode))

;; unfill paragraphs
(use-package unfill)

;; easy comment/uncomment
(use-package evil-nerd-commenter
  :bind ("C-;" . evilnc-comment-or-uncomment-lines))

;; show available keybindings
(use-package which-key
  :init (which-key-mode 1))

;; delete trailing whitespace and untabify in edited regions only
(use-package ws-butler
  :config
  (ws-butler-global-mode 1)
  (setq ws-butler-convert-leading-tabs-or-spaces t))

;; move line/region
(use-package move-text
  :bind (("M-p" . move-text-up)
         ("M-n" . move-text-down)))

;; search tool
(use-package deadgrep
  :config
  (advice-add 'project-find-regexp :override #'deadgrep))

;; sexp editing
(use-package paredit
  :config
  (put 'paredit-forward-delete 'delete-selection 'supersede)
  (put 'paredit-backward-delete 'delete-selection 'supersede)
  (unbind-key "M-?" paredit-mode-map)
  (unbind-key "RET" paredit-mode-map)
  :bind ("C-S-p" . paredit-mode)
  :bind (:map paredit-mode-map
              ("M-[" . paredit-wrap-square)
              ("M-{" . paredit-wrap-curly)
              ("C-0" . paredit-forward-slurp-sexp)
              ("C-9" . paredit-forward-barf-sexp)
              ("C-M-9" . paredit-backward-slurp-sexp)
              ("C-M-0" . paredit-backward-barf-sexp))
  :hook ((clojure-mode cider-repl-mode lisp-mode emacs-lisp-mode) . paredit-mode))

;; isearch
(use-package isearch
  :straight (:type built-in)
  :bind (:map isearch-mode-map
              ("C-n" . isearch-repeat-forward)
              ("C-p" . isearch-repeat-backward))
  :config
  (setq search-whitespace-regexp ".*?"
        isearch-lazy-count t
        lazy-count-prefix-format "(%s/%s) "
        isearch-allow-motion t
        isearch-wrap-pause 'no
        isearch-repeat-on-direction-change t
        isearch-yank-on-move 'shift
        isearch-allow-scroll 'unlimited))

;; editable grep buffers
(use-package wgrep)

;; rainbow-delimiters
(use-package rainbow-delimiters
  :hook ((prog-mode cider-repl-mode LaTeX-mode) . rainbow-delimiters-mode))

;; highlight symbol
(use-package highlight-symbol
  :custom-face
  (highlight-symbol-face ((t (:inherit bold :foreground "white" :background "dodger blue"))))
  :hook (prog-mode . highlight-symbol-mode)
  :config
  (setq highlight-symbol-idle-delay 0.5
        highlight-symbol-highlight-single-occurrence nil)
  :bind (("<f7>" . highlight-symbol-nav-mode)
         ("C-c n" . highlight-symbol-next)
         ("C-c p" . highlight-symbol-prev)))

;; multiple cursors
(use-package multiple-cursors
  :bind (("M-C->" . mc/edit-lines)
         ("C-|" . mc/mark-pop)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c M-m" . mc/mark-all-like-this)
         ("C-c m" . mc/mark-all-like-this-dwim))
  :custom
  (mc/always-run-for-all t)
  (mc/always-repeat-command t))

;; sneaky garbage collector
(use-package gcmh-mode
  :commands (gcmh-mode)
  :straight (:host github :repo "emacsmirror/gcmh")
  :init
  (gcmh-mode 1))

(use-package restart-emacs)
