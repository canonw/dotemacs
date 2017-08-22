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
  :config
  (evil-mode 1)

  (use-package evil-leader
    :config
    (global-evil-leader-mode)
    (setq evil-leader/leader ";")
    )

  ;; (use-package evil-jumper
  ;;   :config
  ;;  (global-evil-jumper-mode))

  (use-package evil-surround
    :config
    (global-evil-surround-mode))

  (use-package evil-indent-textobject)

  (setq evil-want-fine-undo t)          ; Behave undo-tree

  (evil-set-initial-state 'calendar-mode 'emacs)
  (evil-set-initial-state 'help-mode 'emacs)
  (evil-set-initial-state 'dired-mode 'emacs)

  )
(use-package evil-magit
  :after evil
  )
(provide 'init-evil)
