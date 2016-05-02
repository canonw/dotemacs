;; http://stackoverflow.com/questions/3875213/
;; https://www.emacswiki.org/emacs/LineNumbers
;; https://www.emacswiki.org/emacs/linum-off.el

(use-package linum
  :config
  (use-package linum-off)
  (when (and *emacs24* (> emacs-minor-version 4))
    (use-package hlinum
      :ensure t)
    (hlinum-activate))
  ;; Speedup overall performance 
  (linum-delete-overlays)
  (setq linum-eager t)
  (progn
    (defface linum-leading-zero
       `((t :inherit 'linum
            :foreground ,(face-attribute 'linum :background nil t)))
       "Face for displaying leading zeroes for line numbers in display margin."
       :group 'linum)
     (defun linum-format-func (line)
       (let ((w (length
                 (number-to-string (count-lines (point-min) (point-max))))))
         (concat
          (propertize (make-string (- w (length (number-to-string line))) ?0)
                      'face 'linum-leading-zero)
          (propertize (number-to-string line) 'face 'linum)
          (propertize "\u2502" 'face 'linum))))`
     (setq linum-format 'linum-format-func)
     )
  )

(provide 'init-linum-mode)
