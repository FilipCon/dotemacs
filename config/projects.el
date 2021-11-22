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
  :bind (("C-`" . projectile-run-eshell))
  :config
  (projectile-mode 1)
  (setq projectile-globally-ignored-files '(".DS_Store" "Icon" "TAGS" "package-lock.json")
        projectile-globally-ignored-file-suffixes '(".elc" ".pyc" ".o" ".so" "*.ipynb")
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
                                    :package "cmake --build . --target package")
  (projectile-register-project-type 'clojure-cli '("deps.edn")
                                    :test-suffix "_test"
                                    :compile "clojure -M:"
                                    :test "clojure -M:"
                                    :run "clojure -X:")
  (projectile-register-project-type 'shadow-cljs '("shadow-cljs.edn")
                                    :test-suffix "_test"
                                    :compile "clojure -M:"
                                    :test "clojure -M:"
                                    :run "clojure -X:"))
