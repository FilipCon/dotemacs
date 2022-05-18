;;; -*- lexical-binding: t -*-

(use-package flymake
  :straight (:type built-in)
  :config
  (define-fringe-bitmap 'fringe-indicator
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
  (setq flymake-fringe-indicator-position 'right-fringe
        flymake-error-bitmap '(fringe-indicator compilation-error)
        flymake-warning-bitmap '(fringe-indicator compilation-warning)
        flymake-note-bitmap '(fringe-indicator compilation-info)))
