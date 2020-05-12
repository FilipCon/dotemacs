;;; -*- lexical-binding: t -*-

;; multiple cursors
(use-package multiple-cursors
  :ensure t
  :config
  (global-set-key (kbd "M-C->") 'mc/edit-lines)
  (global-set-key (kbd "C-.") 'mc/mark-pop)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "M-C-l") 'mc/mark-all-like-this) ;; todo find a way to toggle betwenn the three options
  ;; (global-set-key (kbd "M-C-l") 'mc/mark-all-words-like-this)
  ;; (global-set-key (kbd "M-C-l") 'mc/mark-all-words-like-this)
  )
