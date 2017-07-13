(use-package visual-regexp
  :ensure t
;;  :bind (("M-5" . vr/replace)
;;         ("M-%" . vr/query-replace))
  )

(use-package re-builder
  :init
  (setq reb-re-syntax 'string)
  )

(provide 'init-regex)
