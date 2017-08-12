(use-package flyspell
  :ensure t
  :defer t
;;  :init
;;  (progn
;;    (add-hook 'prog-mode-hook 'flyspell-prog-mode)
;;    (add-hook 'text-mode-hook 'flyspell-mode)
;;    )
  :commands
  (flyspell-mode flyspell-prog-mode)
  :config
  (setq ispell-program-name (executable-find "aspell")
        ispell-extra-args '("--sug-mode=ultra"))
  )

(provide 'init-flyspell)
