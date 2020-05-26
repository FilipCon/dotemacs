;;; -*- lexical-binding: t -*-
(setq-default
 vc-follow-symlinks t
 ;; Save clipboard contents into kill-ring before replacing them
 save-interprogram-paste-before-kill t
 fill-column 80
 sentence-end-double-space nil
 word-wrap t
 indent-tabs-mode nil
 require-final-newline t
 tab-always-indent t
 tab-width 4
 ;; Wrapping
 truncate-lines t
 truncate-partial-width-windows 50)

;; ;; editor config
;; (use-package editorconfig
;;   :hook (prog-mode . editorconfig-mode))

;; fold/expand region
(use-package origami)
