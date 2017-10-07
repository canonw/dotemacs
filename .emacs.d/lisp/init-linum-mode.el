; http://stackoverflow.com/questions/3875213/
; https://www.emacswiki.org/emacs/LineNumbers
; https://www.emacswiki.org/emacs/linum-off.el
(use-package linum-relative
  :ensure t)

(use-package linum
  :init (dolist (hook '(prog-mode-hook
                        text-mode-hook
                        conf-mode-hook))
          (add-hook hook #'linum-relative-mode))
  :config
  (use-package linum-off)
  (when (and *emacs24* (> emacs-minor-version 4))
    (use-package hlinum
      :ensure t)
    (hlinum-activate))
  (linum-delete-overlays)              ; Speedup overall performance
  (setq linum-eager t)
  (progn
    (set-face-attribute 'linum nil
                        :background (face-attribute 'default :background)
                        :foreground (face-attribute 'font-lock-comment-face :foreground))
    (defface linum-current-line-face
      `((t :background "gray30" :foreground "gold"))
      "Face for the currently active Line number")
    (defvar my-linum-current-line-number 0)
    (defun get-linum-format-string ()
      (setq-local my-linum-format-string
                  (let ((w (length (number-to-string
                                    (count-lines (point-min) (point-max))))))
                    (concat "%" (number-to-string w) "d|"))))
    (add-hook 'linum-before-numbering-hook 'get-linum-format-string)
    (defun my-linum-format (line-number)
      (propertize (format my-linum-format-string line-number) 'face
                  (if (eq line-number my-linum-current-line-number)
                      'linum-current-line-face
                    'linum)))
    (setq linum-format 'my-linum-format)
    (defadvice linum-update (around my-linum-update)
      (let ((my-linum-current-line-number (line-number-at-pos)))
        ad-do-it))
    (ad-activate 'linum-update)
    )
  )

(provide 'init-linum-mode)
