(use-package markdown-mode
  :ensure t
  :defer t
  :mode (("\\.text\\'" . markdown-mode)
         ("\\.\\(m\\(ark\\)?down\\|md\\)$" . markdown-mode))
  )

(provide 'init-markdown)
