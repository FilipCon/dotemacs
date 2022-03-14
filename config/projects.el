;;; -*- lexical-binding: t -*-

(use-package project
  :bind ("C-`" . project-eshell)
  :config
  (setq project-vc-ignores
        '("tmp" ".shadow-cljs" "node_modules"
          ".lsp" ".cpcache" ".clj-kondo"
          "*.elc" "*.pyc" "*.o" "*.so" "*.ipynb")))

(use-package projectile
  :config
  :bind-keymap ("C-c p" . projectile-command-map)
  :config
  (setq projectile-globally-ignored-files '(".DS_Store" "Icon" "TAGS" "package-lock.json")
        projectile-globally-ignored-file-suffixes '(".elc" ".pyc" ".o" ".so" "*.ipynb")
        projectile-ignored-projects '("~/" "/tmp"))
  (setq projectile-globally-ignored-directories
        (append projectile-globally-ignored-directories
                '(".shadow-cljs" "node_modules" ".lsp" ".cpcache" ".clj-kondo")))
  (projectile-register-project-type 'cmake '("CMakeLists.txt")
                                    :project-file "CMakeLists.txt"
                                    :test "ctest"
                                    :compilation-dir "build"
                                    :configure "cmake %s -B %s -DCMAKE_INSTALL_PREFIX=../install"
                                    :compile "cmake --build . -j6"
                                    :install "cmake --install ."
                                    :package "cmake --build . --target package")
 )
