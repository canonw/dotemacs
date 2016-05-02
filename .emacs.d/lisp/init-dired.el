(use-package dired
  :config
  (use-package dired+)
  (use-package dired-sort)
  (when (fboundp 'global-dired-hide-details-mode)
    (global-dired-hide-details-mode -1))
  (setq dired-recursive-deletes 'top)
  (define-key dired-mode-map [mouse-2] 'dired-find-file)
  )

(provide 'init-dired)
