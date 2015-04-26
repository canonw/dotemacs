;; Move deleted files to OS trash
(setq delete-by-moving-to-trash t)

(eval-after-load 'dired
  '(progn
     (require 'dired+)
     (require 'dired-sort)
     (when (fboundp 'global-dired-hide-details-mode)
       (global-dired-hide-details-mode -1))
     (setq dired-recursive-deletes 'top)
     (define-key dired-mode-map [mouse-2] 'dired-find-file)))

(provide 'init-dired)
