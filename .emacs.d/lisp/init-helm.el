(use-package helm
  :ensure t
  :diminish helm-mode
  :init
  (progn
    (require 'helm-config)
    (setq helm-candidate-number-limit 100)
    ;; From https://gist.github.com/antifuchs/9238468
    (setq helm-idle-delay 0.0           ; update fast sources immediately (doesn't).
          helm-input-idle-delay 0.01    ; this actually updates things relatively quickly.
          helm-yas-display-key-on-candidate t
          helm-quick-update t
          helm-M-x-requires-pattern nil
          helm-ff-skip-boring-files t)
    (helm-mode))
  ;; TODO: Review later
  ;; :config
  ;; (helm-autoresize-mode 1)
  ;; (setq helm-scroll-amount 6)
  ;; (setq helm-ff-file-name-history-use-recentf t)
  ;; (define-key global-map [remap jump-to-register]      'helm-register)
  ;; (define-key global-map [remap list-buffers]          'helm-buffers-list)
  ;; (define-key global-map [remap dabbrev-expand]        'helm-dabbrev)
:bind (("C-c h" . helm-mini)
         ("C-h a" . helm-apropos)
         ("C-x C-b" . helm-buffers-list)
         ;; ("C-x b" . helm-buffers-list)
         ("M-y" . helm-show-kill-ring)
         ("M-x" . helm-M-x)
         ;; ("C-SPC" . helm-dabbrev)
         ("C-x C-f" . helm-find-files)
         ("C-s" . helm-occur)
         ("C-x c o" . helm-occur)
         ("C-x c s" . helm-swoop)
         ("C-x c y" . helm-yas-complete)
         ("C-x c Y" . helm-yas-create-snippet-on-region)
         ("C-x c SPC" . helm-all-mark-rings)
         )
  )
(ido-mode -1) ;; Turn off ido mode in case I enabled it accidentally

(use-package helm-themes :ensure t :after helm :defer t)

(use-package helm-descbinds
  :after helm
  :defer t
  :bind (("C-h b" . helm-descbinds)
         ("C-h w" . helm-descbinds))
  )

(use-package helm-swoop
  :after helm
  :bind
  (
   ;; ("C-s" . helm-swoop)
   ;; ("M-i" . helm-swoop)
   ;; ("M-s s" . helm-swoop)
   ("C-c M-i" . helm-multi-swoop)
   ("C-x M-i" . helm-multi-swoop-all)
   )
  :config
  (progn
    (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
    (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)

    )
  )

(use-package helm-ag
  :ensure helm-ag
  :bind ("M-p" . helm-projectile-ag)
  :commands (helm-ag helm-projectile-ag)
  :init (setq helm-ag-insert-at-point 'symbol
	      ;; helm-ag-command-option "--path-to-ignore ~/.ignore"
              )
  )

(use-package helm-company
  :ensure t
  :after company
  :config
  (progn
    (define-key company-mode-map (kbd "C-:") 'helm-company)
    (define-key company-active-map (kbd "C-:") 'helm-company))
  )

(use-package helm-projectile
  :ensure t
  :bind ("M-t" . helm-projectile-find-file)
  :config
  (helm-projectile-on))

(use-package helm-c-yasnippet
  :ensure t
  :after yasnippet
  )
(provide 'init-helm)
