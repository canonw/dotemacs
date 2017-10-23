(use-package eclim
  :disabled (not (file-exists-p "~/.local/share/umake/ide/eclipse/eclim"))
  :init
  (progn
    (use-package eclimd)
    (add-hook 'java-mode-hook (lambda () (eclim-mode 1)))

    (add-hook 'eclim-mode-hook 'setup-eclim)
    (defun setup-eclim ()
      (progn
        (setq c-basic-offset 4)))

    (setq eclim-executable "~/.local/share/umake/ide/eclipse/eclim")
    (setq eclim-auto-save nil)
    (setq eclim-eclipse-dirs '("~/.local/share/umake/ide/eclipse"))
    (setq eclimd-default-workspace "~/eclim-workspace")

    (global-eclim-mode)
    (use-package eclimd)
    (use-package company-emacs-eclim
      :config
      (company-emacs-eclim-setup)
      )
    ;; temporarily switch to emacs mode for this eclim command (with evil mode)
    ;; (defadvice eclim-java-import-organize (around temporary-emacs-mode)
    ;;   (let ((evil-emacs-state))
    ;;     ad-do-it))
    ;; (ad-activate 'eclim-java-import-organize)

    )
  )

(provide 'init-java-mode)
