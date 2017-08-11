(use-package recentf
  :bind ("C-c r" . recentf-open-files)
  :config
  (setq	recentf-max-saved-items 500
        recentf-max-menu-items 15
	recentf-exclude '("/tmp/" "/ssh:" "ido.last" "var")
        ;; disable recentf-cleanup on Emacs start, because it can cause
        ;; problems with remote files
        recentf-auto-cleanup 'never
	;;recentf-save-file (expand-file-name "recentf" (savefile-dir))
	)
  )
(add-hook 'after-init-hook (lambda () (recentf-mode +1)))
(provide 'init-recentf)
