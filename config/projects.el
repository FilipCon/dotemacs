;;; -*- lexical-binding: t -*-

(use-package projectile
  :config
  :bind-keymap ("C-c p" . projectile-command-map)
  :bind (("C-`" . projectile-run-eshell))
  :config
  (projectile-mode 1)
  (setq projectile-globally-ignored-files '(".DS_Store" "Icon" "TAGS")
        projectile-globally-ignored-file-suffixes '(".elc" ".pyc" ".o" ".so")
        projectile-ignored-projects '("~/" "/tmp"))
  (setq projectile-globally-ignored-directories
        (append projectile-globally-ignored-directories
                '(".shadow-cljs" "node_modules" ".lsp" ".cpcache" ".clj-kondo")))
  (projectile-register-project-type 'cmake '("CMakeLists.txt")
                                  :project-file "CMakeLists.txt"
                                  :compilation-dir "build"
                                  :configure "cmake %s -B %s"
                                  :compile "cmake --build . -j6"
                                  :test "ctest"
                                  :install "cmake --build . --target install"
                                  :package "cmake --build . --target package"))
