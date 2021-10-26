;;; -*- lexical-binding: t -*-

(use-package docker
  :bind ("C-c D" . docker))

(use-package dockerfile-mode
  :mode "Dockerfile\\'")
