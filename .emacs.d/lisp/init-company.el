(use-package company
  :ensure t
  :diminish company-mode
  ;; :bind ("C-." . company-complete-common)
  ;; :init
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-echo-delay 0)
  (setq company-idle-delay 0.2)
  (setq company-minimum-prefix-length 2)
  (setq company-require-match nil)
  (setq company-selection-wrap-around t)
  (setq company-selection-wrap-around t) ; loop over candidates
  (setq company-show-numbers t)
  (setq company-tooltip-align-annotations t)
  (setq company-tooltip-flip-when-above t)
  (setq company-tooltip-limit 10)
  (setq company-transformers '(company-sort-by-occurrence)) ; weight by frequency

  (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "S-TAB") 'company-select-previous)
  (define-key company-active-map (kbd "<backtab>") 'company-select-previous)

  )

(use-package company-try-hard
  :ensure t
  :after company
  :config
  (progn
    (global-set-key (kbd "C-<tab>") #'company-try-hard)
    (define-key company-active-map (kbd "C-<tab>") #'company-try-hard))
  )

;; Add backend for math characters
(use-package company-math
  :ensure t
  :defer t
  :after company
  :init
  (progn
    (add-to-list 'company-backends 'company-math-symbols-unicode)
    (add-to-list 'company-backends 'company-math-symbols-latex))
  )

(use-package company-quickhelp
  :ensure t
  :init (add-hook 'company-mode-hook #'company-quickhelp-mode)
  :config (setq company-quickhelp-delay 0.1)
  )

(use-package company-shell
  :ensure t
  :defer t
  :after company
  :init (add-to-list 'company-backends 'company-shell)
  )

(use-package company-statistics
  :ensure t
  :after company
  :config
  ;; (company-statistics-mode 1)
  (add-hook 'after-init-hook 'company-statistics-mode)
  )

(provide 'init-company)
