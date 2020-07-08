;;; -*- lexical-binding: t -*-

;; debug adapter protocol
(use-package dap-mode
  :hook ((dap-mode . dap-ui-mode))
  :config
  (require 'dap-gdb-lldb) ; cc
  (require 'dap-lldb) ; cc
  (require 'dap-java) ;; java
  (require 'dap-python) ;; python
  (dap-auto-configure-mode))
