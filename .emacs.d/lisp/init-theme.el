;; (use-package color-theme :disabled)
;; (use-package color-theme-sanityinc-tomorrow :disabled)
;; (use-package color-theme-sanityinc-solarized
;;   :after color-theme
;;   :disabled)
;; (use-package github-modern-theme :disabled)
(use-package base16-theme)
(use-package monokai-theme)
(use-package zenburn-theme)
(use-package theme-looper
 :config
 (theme-looper-set-theme-set '(zenburn monokai base16-default-dark base16-default-light base16-eighties base16-github base16-tomorrow-night base16-tomorrow))
 )

(theme-looper-enable-random-theme)

;; Use single theme
;; (add-hook 'after-init-hook (lambda () (load-theme 'sanityinc-solarized-dark nil nil)))
;; ;; Nice to tryout multiple themes
;; (add-hook 'after-init-hook (lambda () (load-theme 'sanityinc-tomorrow-eighties nil nil)
;;                              (load-theme 'sanityinc-solarized-light nil t)
;;                              (load-theme 'sanityinc-solarized-dark nil t)))
;; (add-hook 'text-mode-hook
;;           (lambda ()
;;             (set-frame-parameter (window-frame) 'background-mode 'light)
;;             (enable-theme 'sanityinc-solarized-light)))
;; (add-hook 'prog-mode-hook
;;           (lambda ()
;;             (set-frame-parameter (window-frame) 'background-mode 'dark)
;;             (load-theme 'sanityinc-solarized-dark)))

(provide 'init-theme)
