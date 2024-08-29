(use-package python
  :bind (:map python-mode-map
              ("C-c M-j" . run-python) ;; "jack-in"
              ("C-c C-k" . python-shell-send-buffer)
              ("C-c C-c" . python-shell-send-defun)
              ("C-c C-p" . python-shell-send-defun)
              ("C-x C-e" . python-shell-send-statement))
  :custom
  (python-indent-guess-indent-offset-verbose nil)
  (python-check-command "poetry run pyright")
  (python-indent-offset 4)
  :config
  (add-hook 'python-mode-hook (lambda () (electric-indent-local-mode -1)))
  (add-to-list 'compilation-error-regexp-alist-alist
               '(pyright "^[[:blank:]]+\\(.+\\):\\([0-9]+\\):\\([0-9]+\\).*$" 1 2 3))
  (add-to-list 'python-shell-completion-native-disabled-interpreters "ipython")
  (add-to-list 'compilation-error-regexp-alist 'pyright))

;;; Use poetry to manage packages and when to switch to virtualenvs
;;; See https://python-poetry.org/ for more info
;;; See https://python-poetry.org/docs/managing-environments/ for virtual envs management
(use-package poetry
  :config
  (poetry-tracking-mode)
  (setq poetry-tracking-strategy 'switch-buffer)
  (setenv "WORKON_HOME" (expand-file-name "~/.cache/pypoetry/virtualenvs")))

(use-package python-pytest
  :bind (:map python-mode-map
              ("C-c C-t n" . python-pytest-file-dwim)
              ("C-c C-t t" . python-pytest-function-dwim)
              ("C-c C-t s" . python-pytest-dispatch))
  :custom
  (python-pytest-arguments
   '(;;"--v"            ;; show verbose output
     "--color"        ;; colored output in the buffer
     "--failed-first" ;; run the previous failed tests first
     "--maxfail=5"    ;; exit in 5 continuous failures in a run
     )))

(use-package pet
  :config
  (add-hook 'python-base-mode-hook 'pet-mode -10)
  (add-hook 'pet-mode-hook
            (lambda ()
              (setq-local python-shell-interpreter (pet-executable-find "ipython")
                          python-shell-interpreter-args "-i --simple-prompt"
                          python-shell-virtualenv-root (pet-virtualenv-root)))))

(use-package python-black)

;; Buffer formatting on save
;; (use-package yapfify
;;   :diminish yapf-mode
;;   :ensure t
;;   :defer t
;;   :hook (python-mode . yapf-mode))

;; numpy docstring for python
(use-package numpydoc
  :custom
  (numpydoc-insert-examples-block nil)
  (numpydoc-template-long nil)
  :bind (:map python-mode-map
              ("C-c C-n" . numpydoc-generate)))

;; Debugger
(use-package dap-mode
  :config
  (dap-auto-configure-mode))

;;; Dependency: pyright
(use-package lsp-pyright
  :config
  :custom
  ;; (lsp-pyright-disable-language-service nil)
  (lsp-pyright-disable-organize-imports nil)
  (lsp-pyright-auto-import-completions t)
  (lsp-pyright-use-library-code-for-types nil)
  (lsp-pyright-diagnostic-mode "openFilesOnly")
  (lsp-pyright-venv-path (expand-file-name "~/.cache/pypoetry/virtualenvs")))
