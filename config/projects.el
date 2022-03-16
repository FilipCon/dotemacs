;;; -*- lexical-binding: t -*-

(use-package project
  :bind ("C-`" . project-eshell)
  :config
  (setq project-vc-ignores (append ignored-files ignored-directories)))

(use-package projectile
  :bind-keymap ("C-c p" . projectile-command-map)
  :config
  (add-to-list 'projectile-globally-ignored-directories ignored-directories)
  (projectile-register-project-type 'cmake '("CMakeLists.txt")
                                    :project-file "CMakeLists.txt"
                                    :test "ctest"
                                    :compilation-dir "build"
                                    :configure "cmake %s -B %s -DCMAKE_INSTALL_PREFIX=../install"
                                    :compile "cmake --build . -j6"
                                    :install "cmake --install ."
                                    :package "cmake --build . --target package"))
