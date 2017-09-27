;; highlight matching parentheses
(use-package paren
  :init
  (add-hook 'prog-mode-hook #'show-paren-mode)
  (show-paren-mode)
  (setq show-paren-delay 1)
  (set-face-background 'show-paren-match (face-background 'default))
  (if (eq (frame-parameter nil 'background-mode) 'dark)
      (set-face-foreground 'show-paren-match "red")
    (set-face-foreground 'show-paren-match "black"))
  (set-face-attribute 'show-paren-match nil :weight 'extra-bold)
  )

(use-package smartparens
  :init
  (add-hook 'prog-mode-hook #'smartparens-mode)
  :config
  (use-package evil-smartparens)
  ;; :bind
  ;; (("C-M-k" . sp-kill-sexp-with-a-twist-of-lime)
  ;;  ("C-M-f" . sp-forward-sexp)
  ;;  ("C-M-b" . sp-backward-sexp)
  ;;  ("C-M-n" . sp-up-sexp)
  ;;  ("C-M-d" . sp-down-sexp)
  ;;  ("C-M-u" . sp-backward-up-sexp)
  ;;  ("C-M-p" . sp-backward-down-sexp)
  ;;  ("C-M-w" . sp-copy-sexp)
  ;;  ("M-s" . sp-splice-sexp)
  ;;  ("M-r" . sp-splice-sexp-killing-around)
  ;;  ("C-)" . sp-forward-slurp-sexp)
  ;;  ("C-}" . sp-forward-barf-sexp)
  ;;  ("C-(" . sp-backward-slurp-sexp)
  ;;  ("C-{" . sp-backward-barf-sexp)
  ;;  ("M-S" . sp-split-sexp)
  ;;  ("M-J" . sp-join-sexp)
  ;;  ("C-M-t" . sp-transpose-sexp))
  )

(use-package rainbow-delimiters
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  )

(provide 'init-parens)
;;; init-parens ends here
