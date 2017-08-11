(use-package evil
  :ensure t
  :config
  (evil-mode 1)

  (use-package evil-leader
    :config
    (global-evil-leader-mode))

  ;; (use-package evil-jumper
  ;;   :config
  ;;  (global-evil-jumper-mode))

  (use-package evil-surround
    :config
    (global-evil-surround-mode))

  (use-package evil-indent-textobject)
  )

(provide 'init-evil)
