(recentf-mode 1)
;; Maximum number of items
(setq recentf-max-saved-items 1000
      recentf-exclude '("/tmp/" "/ssh:"))

(global-set-key "\C-cr" 'recentf-open-files)

(provide 'init-recentf)
