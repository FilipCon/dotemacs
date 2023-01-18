(use-package exec-path-from-shell
  :init
  (when (display-graphic-p)
    (exec-path-from-shell-copy-env "LD_LIBRARY_PATH")
    (exec-path-from-shell-initialize))
  :config
  (setq exec-path-from-shell-check-startup-files nil)
  (setq exec-path-from-shell-variables
        '("PATH" "MANPATH" "SSH_AUTH_SOCK")))

;; vterm
(use-package vterm
  :bind (:map project-prefix-map
              ("t" . project-vterm))
  :preface
  (defun project-vterm ()
    (interactive)
    (defvar vterm-buffer-name)
    (let* ((default-directory (project-root (project-current t)))
           (vterm-buffer-name (project-prefixed-buffer-name "vterm"))
           (vterm-buffer (get-buffer vterm-buffer-name)))
      (if (and vterm-buffer (not current-prefix-arg))
          (pop-to-buffer vterm-buffer (bound-and-true-p display-comint-buffer-action))
        (vterm))))
  :init
  (add-to-list 'project-switch-commands '(project-vterm "Vterm") t)
  (add-to-list 'project-kill-buffer-conditions '(major-mode . vterm-mode))
  :config
  (setq vterm-copy-exclude-prompt t
        vterm-max-scrollback 100000))
