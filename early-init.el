;;; -*- lexical-binding: t -*-

;; make startup faster
(setq gc-cons-threshold most-positive-fixnum ; turn off gc
      gc-cons-percentage 0.6            ; increase heap portion for allocation
      native-comp-deferred-compilation nil ; prevent runtime compilation
      package-enable-at-startup nil        ; don't auto-initialize!
      package--init-file-ensured t ; don't add `custom-set-variables' block to init.el!
      load-prefer-newer t          ; prioritize non-byte-compiled source files
      default-input-method nil)

