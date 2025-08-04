;; lsp
(use-package eglot
  :straight (:type built-in)
  :bind (("<f10>" . eglot)
         ("M-?" . xref-find-references))
  :bind (:map eglot-mode-map
              ("C-c l r" . eglot-rename)
              ("C-c l f" . eglot-format)
              ("C-<return>" . eglot-code-actions))
  :config
  (setq eglot-events-buffer-size 0
        eglot-connect-timeout 60
        eglot-extend-to-xref t
        ;; eglot-stay-out-of '(flymake eldoc)
        eglot-confirm-server-initiated-edits nil)
  (add-to-list 'eglot-server-programs
               '(web-mode . ("typescript-language-server" "--stdio")))
  ;; lsp optimizations
  (defun +eglot/lsp-init-optimizations ()
    (when (eglot-managed-p)
      (setq-local read-process-output-max (* 1024 1024))
      (setq-local gcmh-high-cons-threshold (* 2 (default-value 'gcmh-high-cons-threshold)))))
  (add-hook 'eglot-managed-mode-hook #'+eglot/lsp-init-optimizations))

;; https://www.ovistoica.com/blog/2024-7-05-modern-emacs-typescript-web-tsx-config

(use-package lsp-mode
  :diminish "LSP"
  :hook ((lsp-mode . lsp-diagnostics-mode)
         (lsp-mode . lsp-enable-which-key-integration)
         ((tsx-ts-mode
           typescript-ts-mode
           ;; clojure-mode
           ;; clojurescript-mode
           ;; clojurec-mode
           js-ts-mode) . lsp))
  :bind-keymap ("C-c l" . lsp-command-map)
  :bind (:map lsp-mode-map
              ("M-?" . lsp-find-references))
  :config
  (setq lsp-completion-provider :none)       ; Using Corfu as the provider
  (setq lsp-diagnostics-provider :flymake)
  (setq lsp-session-file (locate-user-emacs-file ".lsp-session"))
  (setq lsp-log-io nil)                      ; IMPORTANT! Use only for debugging! Drastically affects performance
  (setq lsp-keep-workspace-alive nil)        ; Close LSP server if all project buffers are closed
  (setq lsp-idle-delay 0.5)                  ; Debounce timer for `after-change-function'
  ;; core
  (setq lsp-enable-xref t)                   ; Use xref to find references
  (setq lsp-auto-configure t)                ; Used to decide between current active servers
  (setq lsp-eldoc-enable-hover t)          ; Display signature information in the echo area
  (setq lsp-enable-dap-auto-configure t)     ; Debug support
  (setq lsp-enable-file-watchers nil)
  (setq lsp-enable-folding nil)              ; disable folding
  (setq lsp-enable-imenu nil)
  (setq lsp-enable-indentation nil)          
  (setq lsp-enable-links nil)                ; No need since we have `browse-url'
  (setq lsp-enable-on-type-formatting nil)   
  (setq lsp-enable-suggest-server-download t) ; Useful prompt to download LSP providers
  (setq lsp-enable-symbol-highlighting nil) ; Shows usages of symbol at point in the current buffer
  (setq lsp-enable-text-document-color nil) ; This is Treesitter's job
  (setq lsp-enable-snippet nil)
  (setq lsp-ui-sideline-show-hover nil)      ; Sideline used only for diagnostics
  (setq lsp-ui-sideline-diagnostic-max-lines 20) ; 20 lines
  ;; completion
  (setq lsp-completion-enable t)
  (setq lsp-completion-enable-additional-text-edit nil) ; Ex: auto-insert an import for a completion candidate
  (setq lsp-enable-snippet t)                         ; Important to provide full JSX completion
  (setq lsp-completion-show-kind t)                   ; Optional
  ;; headerline
  (setq lsp-headerline-breadcrumb-enable nil)  ; Optional
  (setq lsp-headerline-breadcrumb-enable-diagnostics nil) ; Don't make them red, too noisy
  (setq lsp-headerline-breadcrumb-enable-symbol-numbers nil)
  (setq lsp-headerline-breadcrumb-icons-enable nil)
  ;; modeline
  (setq lsp-modeline-code-actions-enable t)
  (setq lsp-modeline-diagnostics-enable t)
  (setq lsp-modeline-workspace-status-enable t) ; Modeline displays "LSP" when lsp-mode is enabled
  (setq lsp-signature-doc-lines 1)                ; Don't raise the echo area. It's distracting
  (setq lsp-ui-doc-use-childframe t)              ; Show docs for symbol at point
  (setq lsp-ui-sideline-enable nil)               ; don't diplay errors and hints inline
  (setq lsp-eldoc-render-all nil)            ; This would be very useful if it would respect `lsp-signature-doc-lines', currently it's distracting
  ;; lens
  (setq lsp-lens-enable nil)                 ; Optional, I don't need it
  ;; semantic
  (setq lsp-semantic-tokens-enable nil)      ; Related to highlighting, and we defer to treesitter

  :preface
  (defun lsp-booster--advice-json-parse (old-fn &rest args)
    "Try to parse bytecode instead of json."
    (or
     (when (equal (following-char) ?#)

       (let ((bytecode (read (current-buffer))))
         (when (byte-code-function-p bytecode)
           (funcall bytecode))))
     (apply old-fn args)))
  (defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
    "Prepend emacs-lsp-booster command to lsp CMD."
    (let ((orig-result (funcall old-fn cmd test?)))
      (if (and (not test?)                             ;; for check lsp-server-present?
               (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
               lsp-use-plists
               (not (functionp 'json-rpc-connection))  ;; native json-rpc
               (executable-find "emacs-lsp-booster"))
          (progn
            (message "Using emacs-lsp-booster for %s!" orig-result)
            (cons "emacs-lsp-booster" orig-result))
        orig-result)))

  :init
  ;; (setq lsp-use-plists t)
  (advice-add (if (progn (require 'json)
                         (fboundp 'json-parse-buffer))
                  'json-parse-buffer
                'json-read)
              :around
              #'lsp-booster--advice-json-parse)
  (advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command))

(use-package lsp-ui
  :commands
  (lsp-ui-doc-show
   lsp-ui-doc-glance)
  :after (lsp-mode)
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-max-height 80
        lsp-ui-doc-max-width 100
        lsp-ui-doc-show-with-mouse nil
        lsp-ui-doc-show-with-cursor nil      ; Don't show doc when cursor is over symbol - too distracting
        lsp-ui-doc-include-signature t       ; Show signature
        lsp-ui-imenu-enable nil
        lsp-ui-sideline-ignore-duplicate t
        lsp-ui-doc-position 'top))

;; lsp optimizations
(defun +lsp/init-optimizations-h ()
  (when (bound-and-true-p lsp-mode)
    (setq-local read-process-output-max (* 1024 1024))
    (setq-local gcmh-high-cons-threshold (* 2 (default-value 'gcmh-high-cons-threshold)))))
(add-hook 'lsp-mode-hook #'+lsp/init-optimizations-h)

(use-package lsp-tailwindcss
  :straight '(lsp-tailwindcss :type git :host github :repo "merrickluo/lsp-tailwindcss")
  :init (setq lsp-tailwindcss-add-on-mode t)
  :config
  (dolist (tw-major-mode
           '(css-mode
             css-ts-mode
             typescript-mode
             typescript-ts-mode
             tsx-ts-mode
             js2-mode
             js-ts-mode))
    (add-to-list 'lsp-tailwindcss-major-modes tw-major-mode)))
