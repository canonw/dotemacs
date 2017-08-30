(use-package dired
  :ensure f                             ; Use local build
  :bind (:map dired-mode-map
              ("P" . peep-dired))
  :config
  (add-hook 'dired-mode-hook #'dired-hide-details-mode)
  (put 'dired-find-alternate-file 'disabled nil)
  (setq dired-use-ls-dired nil
        dired-dwim-target t
        dired-recursive-deletes 'always
        dired-recursive-copies 'always
        dired-auto-revert-buffer t)
  )

(use-package peep-dired
  :after dired
  :defer t
  :bind (:map peep-dired-mode-map
              ("n" . peep-dired-next-file)
              ("p" . peep-dired-prev-file)
              ("K" . peep-dired-kill-buffers-without-window)
              ("C-n" . dired-next-line)
              ("C-p" . dired-previous-line))
  :config
  (setq peep-dired-ignored-extensions '("mkv" "iso" "mp4" "mp3"))
  )

(use-package dired+
  :after dired
  :defer t
  ;; :config
  ;; (setq diredp-hide-details-initially-flag nil)
  ;; (set-face-foreground 'diredp-file-name nil)
  ;; ;; Keep dired buffers updated when the file system changes.
  ;; (setq global-auto-revert-non-file-buffers t)
  ;; (setq auto-revert-verbose nil)
  )

(use-package dired-details
  :after dired
  :defer t)
  
(use-package dired-sort
  :after dired
  :defer t)

(provide 'init-dired)
