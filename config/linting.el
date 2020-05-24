;;; -*- lexical-binding: t -*-

(use-package flycheck
  :init
  (define-fringe-bitmap 'flycheck-fringe-indicator
    (vector #b0000000000000000
        #b0000000000000000
        #b0000000000000000
        #b0000000000000000
        #b0000000000000000
        #b1111111111111111
        #b1111111111111111
        #b1111111111111111
        #b1111111111111111
        #b1111111111111111
        #b1111111111111111
        #b0000000000000000
        #b0000000000000000
        #b0000000000000000
        #b0000000000000000
        #b0000000000000000
        #b0000000000000000) nil 16)
  :custom (flycheck-indication-mode 'right-fringe)
  :hook (prog-mode . global-flycheck-mode)
  :config
  (flycheck-define-error-level 'error
                   :severity 2
                   :overlay-category 'flycheck-error-overlay
                   :fringe-bitmap 'flycheck-fringe-indicator
                   :fringe-face 'flycheck-fringe-error)
  (flycheck-define-error-level 'warning
                   :severity 1
                   :overlay-category 'flycheck-warning-overlay

                   :fringe-bitmap 'flycheck-fringe-indicator
                   :fringe-face 'flycheck-fringe-warning)
  (flycheck-define-error-level 'info
                   :severity 0
                   :overlay-category 'flycheck-info-overlay
                   :fringe-bitmap 'flycheck-fringe-indicator
                   :fringe-face 'flycheck-fringe-info))

;; linter for the metadata in Emacs Lisp files which are intended to be packages.
(use-package package-lint
  :commands (package-lint-current-buffer))

;; (use-package flycheck-clang-analyzer
;;   :after flycheck
;;   :config (flycheck-clang-analyzer-setup))

;; languagetool
(use-package langtool
  :config
  (setq langtool-java-classpath
        "/home/filipkon/Software/languagetool/*")
  :bind ("C-c b l" . langtool-check-buffer))

;; define word
(use-package define-word)

;;synonyms
(use-package synosaurus)

;; save word to dictionary
(defun ds/save-to-dictionary ()
  (interactive)
  (let ((current-location (point))
        (word (flyspell-get-word)))
    (when (consp word)
      (flyspell-do-correct 'save nil (car word)
                           current-location (cadr word) (caddr word)
                           current-location))))
;; (global-set-key [f1] 'ds/save-to-dictionary)
(global-set-key (kbd "C-c b s") 'flyspell-buffer)
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; change dictionary toggle
(lexical-let ((dictionaries '("en" "el")))
             (rplacd (last dictionaries) dictionaries)
             (defun ds/ispell-change-to-next-dictionary ()
               (interactive)
               (ispell-change-dictionary (pop dictionaries))))
;; (global-set-key [f2] 'ds/ispell-change-to-next-dictionary)

;; remove binding. use it as toggle comment/uncomment region/line
(define-key flyspell-mode-map (kbd "C-;") nil)
