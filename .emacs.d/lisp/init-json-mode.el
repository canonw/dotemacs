(use-package json-mode
  :defer t
  :mode ("\\.json\\'" . json-mode)
  :bind (("C-c C-q" . jq-interactively))
  )

(use-package jq-mode
  :after json-mode
  :mode ("\\.jq\\'" . jq-mode)
  ;; :config
  ;; (custom-set-variables
  ;;  '(jq-interactive-command "C:/ProgramData/chocolatey/bin/jq.exe")
  ;;  )
  )

(provide 'init-json-mode)
