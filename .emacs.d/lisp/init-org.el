(use-package org
  :ensure org-plus-contrib
  :pin org				; Fetch org package
  :bind (("C-c a" . org-agenda)
         ("C-c l" . org-store-link))
  :config
  (progn
    (setq org-agenda-files '("~/org/")
          org-hide-leading-stars t
          org-log-done 'time
          org-odd-levels-only t)
    )
  )

(use-package org-bullets
  :commands (org-bullets-mode)
  :init (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(provide 'init-org)
