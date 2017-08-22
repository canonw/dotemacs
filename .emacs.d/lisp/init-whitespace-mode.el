(use-package whitespace
  ;; :bind (("C-c T w" . whitespace-mode))
  ;; ;; Will turn on only if needed
  ;; :init (dolist (hook '(prog-mode-hook
  ;;                       text-mode-hook
  ;;                       conf-mode-hook))
  ;;  (add-hook hook #'whitespace-mode))
  :config
  (progn
    (setq whitespace-line-column nil)
    (setq whitespace-style (quote (spaces tabs newline space-mark tab-mark newline-mark)))
    (setq whitespace-display-mappings
          '(
            (space-mark 32 [183] [46])    ; 32 SPACE, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
            (newline-mark 10 [182 10])    ; 10 LINE FEED
            (tab-mark 9 [9655 9] [92 9])  ; 9 TAB, 9655 WHITE RIGHT-POINTING TRIANGLE 「▷」
            )
          )
    )
  ;; :diminish whitespace-mode
  )

(provide 'init-whitespace-mode)
