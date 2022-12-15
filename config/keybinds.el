;; font size
(global-set-key (kbd "C-=") (lambda () (interactive) (text-scale-increase 0.5)))
(global-set-key (kbd "C--") (lambda () (interactive) (text-scale-decrease 0.5)))

;; eval elisp buffer
(define-key emacs-lisp-mode-map (kbd "C-c C-k") 'eval-buffer)
(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-defun)
(define-key emacs-lisp-mode-map (kbd "C-c C-e") 'eval-last-sexp)

;; move between recently visited
(global-set-key (kbd "C-M--") 'previous-buffer)
(global-set-key (kbd "C-M-=") 'next-buffer)

;; remap default keys
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; ;; undo/redo
;; (global-set-key (kbd "C-/") 'undo)
;; (global-set-key (kbd "C-?") 'undo-redo)

;; show whitespaces
(global-set-key (kbd "<f11>") 'global-whitespace-mode)

;; show column indicator
(global-set-key (kbd "<f12>") 'display-fill-column-indicator-mode)

;; stop minimizing, its annoying
(global-unset-key (kbd "C-z"))

;; highlight symbols
(global-set-key (kbd "C-M-;") 'hi-lock-face-symbol-at-point)
(global-set-key (kbd "C-M-'") (lambda () (interactive) (hi-lock-unface-buffer t)))

;; kill sexp
(global-set-key (kbd "C-M-<backspace>") #'backward-kill-sexp)
