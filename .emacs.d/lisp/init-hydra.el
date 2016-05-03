(use-package hydra
  :ensure t
  :init
  (defhydra hydra-zoom ()
    "zoom"
    ("+" text-scale-increase "in")
    ("-" text-scale-decrease "out")
    ("r" (text-scale-set 0) "reset" :bind nil)
    ("0" (text-scale-set 0) :bind nil :exit t)
    ("1" (text-scale-set 0) nil :bind nil :exit t))
  (defhydra hydra-toggle (:color blue :exit t)
    ("a" abbrev-mode "abbrev")
    ("f" auto-fill-mode "fill")
    ("d" toggle-debug-on-error "debug")
    ("l" linum-mode "linum")
    ("t" toggle-truncate-lines "truncate")
    ("w" whitespace-mode "whitespace")
    ("q" nil "quit"))
  (bind-keys ("C-; z" . hydra-zoom/body)
             ("C-; ;" . hydra-toggle/body))
  :config
  (setq hydra-is-helpful t)
  (setq hydra-lv t)
  )

(provide 'init-hydra)
