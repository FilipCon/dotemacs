;;; -*- lexical-binding: t -*-

;; The markdown mode is awesome! unbeatable
(use-package markdown-mode
  :mode (("README\\(?:\\.md\\)?\\'" . gfm-mode)
         ("\\.md\\'" . gfm-mode)
         ("\\.markdown\\'" . gfm-mode))
  :init
  (advice-add #'markdown--command-map-prompt :override #'ignore)
  (advice-add #'markdown--style-map-prompt   :override #'ignore)
  :custom
  (markdown-gfm-additional-languages '("sh"))
  (markdown-open-command "xdg-open")
  (markdown-enable-math t)
  (markdown-command "pandoc")
  (markdown-header-scaling t)
  (markdown-enable-wiki-links t)
  (markdown-italic-underscore t)
  (markdown-asymmetric-header t)
  (markdown-gfm-uppercase-checkbox t)
  (markdown-fontify-code-blocks-natively t)
  :config
  (setq
   markdown-content-type "application/xhtml+xml"
   markdown-css-paths
   '("https://cdn.jsdelivr.net/npm/github-markdown-css/github-markdown.min.css"
     "https://cdn.jsdelivr.net/gh/highlightjs/cdn-release/build/styles/github.min.css")
   markdown-xhtml-header-content
   (concat
    "<meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>"
    "<style> body { box-sizing: border-box; max-width: 740px; width: 100%; margin: 40px auto; padding: 0 10px; } </style>"
    "<script id='MathJax-script' async src='https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js'></script>"
    "<script src='https://cdn.jsdelivr.net/gh/highlightjs/cdn-release/build/highlight.min.js'></script>"
    "<script>document.addEventListener('DOMContentLoaded', () => { document.body.classList.add('markdown-body');
document.querySelectorAll('pre[lang] > code').forEach((code) => { code.classList.add(code.parentElement.lang); });
document.querySelectorAll('pre > code').forEach((code) => { hljs.highlightBlock(code); }); });</script>")))
