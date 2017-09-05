;;; package -- Magit configuration
;;; Commentary:

;;; Code:
(use-package magit
  :ensure t
  :defer t
  :bind
   (("C-c g s" . magit-status)
    ("C-c C-g l" . magit-file-log)
    ("C-c g f" . magit-grep))
  :init
  (progn
    (bind-key "C-c C-a" 'magit-just-amend magit-mode-map))
  :config
  (if (eq *win64* t)                    ; Fix git lookup.  https://github.com/purcell/emacs.d/issues/425
      (setq magit-git-executable (executable-find "git")))
  )

;; (use-package magit-blame
;;  :after magit)

(provide 'init-magit)
;;; init-magit ends here
