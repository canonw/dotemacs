(use-package flycheck
  :ensure t
  :init
  ;; (add-hook 'prog-mode-hook (lambda () (flycheck-mode)))
  (add-hook 'after-init-hook #'global-flycheck-mode)
  )

(use-package flycheck-color-mode-line
  :ensure t
  :config
  (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)
  )

(use-package flycheck-pos-tip
  :ensure t
  :config
  (eval-after-load 'flycheck
    '(setq flycheck-display-errors-function #'flycheck-pos-tip-error-messages))
  )

(provide 'init-flycheck)
