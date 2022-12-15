;; globally ignored files and directories
(defvar ignored-directories
  '("node_modules" ".shadow-cljs" ".lsp" ".cpcache" ".clj-kondo" "tmp" "build"
    "target" ".git" "log"))

(defvar ignored-files
  '("*.elc" "*.pyc" "*.o" "*.so" "*.ipynb" "*.svg"))

(use-package project
  :straight (:type built-in)
  :config
  (setq project-vc-ignores (append ignored-files ignored-directories)))

(use-package ibuffer-project
  :config
  (add-hook
   'ibuffer-hook
   (lambda ()
     (setq ibuffer-filter-groups (ibuffer-project-generate-filter-groups))
     (unless (eq ibuffer-sorting-mode 'project-file-relative)
       (ibuffer-do-sort-by-project-file-relative)))))
