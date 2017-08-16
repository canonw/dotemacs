(use-package json-mode
  :mode ("\\.json\\'" . json-mode)
  ;; :bind (("C-c C-f" . json-pretty-print-buffer)
  ;;        ;; ("C-c C-q" . jq-interactively)
  ;;        ;; ("C-c C-S-F" . json-pretty-print-buffer-ordered)
  ;;        )
  :config
  (define-key json-mode-map (kbd "C-c C-q") 'jq-interactively)
  (define-key json-mode-map (kbd "C-c C-f") 'json-pretty-print-buffer)
  (define-key json-mode-map (kbd "C-c C-S-f") 'json-pretty-print-buffer-ordered)
  )

(use-package jq-mode
  :after json-mode
  :mode ("\\.jq\\'" . jq-mode)
  :config
  (if *win64*
      (custom-set-variables
       '(jq-interactive-command "C:/ProgramData/chocolatey/bin/jq.exe")
       )
    ))

(provide 'init-json-mode)
