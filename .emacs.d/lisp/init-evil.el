(use-package evil
  :init
  (progn
    ;; if we don't have this evil overwrites the cursor color
    (setq evil-default-cursor t)

    (setq evil-emacs-state-cursor '("red" box))
    (setq evil-normal-state-cursor '("green" box))
    (setq evil-visual-state-cursor '("orange" box))
    (setq evil-insert-state-cursor '("red" bar))
    (setq evil-replace-state-cursor '("red" bar))
    (setq evil-operator-state-cursor '("red" hollow))
    )
  (use-package evil-leader
    :init (global-evil-leader-mode)
    :config
    (setq evil-leader/leader ";")
    )
  :config
  (evil-mode 1)
  (use-package evil-surround)
  (global-evil-surround-mode 1)

  (evil-set-initial-state 'calendar-mode 'emacs)
  (evil-set-initial-state 'help-mode 'emacs)
  )
(provide 'init-evil)
