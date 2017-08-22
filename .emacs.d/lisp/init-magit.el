;;; package -- Magit configuration
;;; Commentary:

;;; Code:
(use-package magit
  :bind
  (("C-c g" . magit-status)
   ("C-c C-g l" . magit-file-log)
   ("C-c f" . magit-grep))
;;  :init
;;  (progn
;;    (use-package magit-blame)
;;    (bind-key "C-c C-a" 'magit-just-amend magit-mode-map))
;;  :config
  )

(provide 'init-magit)
;;; init-magit ends here
