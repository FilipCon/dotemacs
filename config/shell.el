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

;; ;; eat terminal emulator

;; (use-package eat
;;   :straight
;;   (:type git
;;          :host codeberg
;;          :repo "akib/emacs-eat"
;;          :files ("*.el" ("term" "term/*.el") "*.texi"
;;                  "*.ti" ("terminfo/e" "terminfo/e/*")
;;                  ("terminfo/65" "terminfo/65/*")
;;                  ("integration" "integration/*")
;;                  (:exclude ".dir-locals.el" "*-tests.el")))
;;   :bind (:map project-prefix-map
;;               ("a" . project-eat))
;;   :preface
;;   (defun project-eat ()
;;     (interactive)
;;     (defvar eat-buffer-name)
;;     (let* ((default-directory (project-root (project-current t)))
;;            (eat-buffer-name (project-prefixed-buffer-name "eat"))
;;            (buffer (get-buffer eat-buffer-name)))
;;       (if (and buffer (not current-prefix-arg))
;;           (pop-to-buffer buffer (bound-and-true-p display-comint-buffer-action))
;;         (eat))))
;;   :init
;;   (add-to-list 'project-switch-commands '(project-eat "Eat") t)
;;   (add-to-list 'project-kill-buffer-conditions '(major-mode . eat-mode)))
