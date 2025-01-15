;; minibuffer completion system
(use-package vertico
  :init
  (vertico-mode)
  :config
  (defun +completion-category-highlight-files (cand)
    (let ((len (length cand)))
      (when (and (> len 0)
                 (eq (aref cand (1- len)) ?/))
        (add-face-text-property 0 len 'dired-directory 'append cand)))
    cand)

  (defvar +completion-category-hl-func-overrides
    `((file . ,#'+completion-category-highlight-files))
    "Alist mapping category to highlight functions.")

  (advice-add #'vertico--arrange-candidates :around
              (defun vertico-format-candidates+ (func)
                (let ((hl-func (or (alist-get (vertico--metadata-get 'category)
                                              +completion-category-hl-func-overrides)
                                   #'identity)))
                  (cl-letf* (((symbol-function 'actual-vertico-format-candidate)
                              (symbol-function #'vertico--format-candidate))
                             ((symbol-function #'vertico--format-candidate)
                              (lambda (cand &rest args)
                                (apply #'actual-vertico-format-candidate
                                       (funcall hl-func cand) args))))
                    (funcall func))))))

;; completion style
(use-package orderless
  :init
  (setq completion-styles '(orderless partial-completion basic)
        completion-category-defaults nil
        orderless-component-separator "[ -]"
        completion-category-overrides '((file (styles . (partial-completion)))
                                        (eglot (styles . (orderless flex))))))

;; mini-buffer annotations
(use-package marginalia
  :config
  (marginalia-mode))

;; enhanced commands on mini-buffer
(use-package consult
  :bind (("M-C-s" . consult-line)))

;; mini-buffer actions
(use-package embark
  :bind ("C-," . embark-act))
