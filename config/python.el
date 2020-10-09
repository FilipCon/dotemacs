;;; -*- lexical-binding: t -*-

(setq python-indent-offset 4
      python-shell-interpreter "ipython3"
      python-shell-interpreter-args "-i --simple-prompt --pprint"
      elpy-rpc-python-command "python3"
      python-shell-prompt-detect-failure-warning nil)

(defun ds/python-shell-send-snippet ()
  (interactive)
  (save-excursion
   (search-backward "##")
   (end-of-line)
   (set-mark-command nil)
   (search-forward "##")
   (call-interactively 'python-shell-send-region)
   (deactivate-mark)))

(defun ds/python-hook ()
  (flyspell-prog-mode)
  (local-set-key (kbd "C-c C-g") 'ds/python-shell-send-snippet))
(add-hook 'python-mode-hook 'ds/python-hook)

;; jupyter
(use-package ein
  :config
  (setq ein:use-auto-complete-superpack t
        ein:output-type-preference '(emacs-lisp svg png jpeg html
                                                text latex javascript)))
