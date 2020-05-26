;;; -*- lexical-binding: t -*-

;; multiple cursors
(use-package multiple-cursors
  :config
  (global-set-key (kbd "M-C->") 'mc/edit-lines)
  (global-set-key (kbd "C-.") 'mc/mark-pop)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "M-C-l") 'mc/mark-all-like-this))


;; (straight-use-package
;;  '(region-occurrences-highlighter
;;    :repo "alvarogonzalezsotillo/region-occurrences-highlighter"
;;    :fetcher github))
;; (add-hook 'prog-mode-hook 'region-occurrences-highlighter-mode)
