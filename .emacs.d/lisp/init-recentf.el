(recentf-mode 1)
;; Maximum number of items
(setq recentf-max-saved-items 1000
      recentf-exclude '("/tmp/" "/ssh:"))

;; Ignore file list
(add-to-list 'recentf-exclude "\\ido.last\\'")

(provide 'init-recentf)
