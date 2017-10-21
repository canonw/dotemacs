(use-package markdown-mode
  :ensure t
  :defer t
  :mode ("\\.text\\'" . markdown-mode)
  )

(use-package jekyll-modes
  :ensure t
  :defer t
  :mode
  (("\\.htm\(l\)?$" . jekyll-html-mode)
   ("\\.\\(m\\(ark\\)?down\\|md\\)$" . jekyll-markdown-mode))
  )

(provide 'init-markdown-mode)
