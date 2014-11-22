; ~/.emacs.d/my-noexternals.el

;; Set UTF-8 as default
(set-language-environment "UTF-8")

;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen 1)

;; Enable transient mark mode
(transient-mark-mode 1)

;; Line number
(global-linum-mode 1)
;; Line number format - include line seperator, no leading space
(eval-after-load 'linum
  '(progn
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
          (propertize "\u2502" 'face 'linum))))
     (setq linum-format 'linum-format-func)))

;; Color Theme
(load-theme 'wheatgrass t)

;; Remove scrollbars, menu bars, and toolbars
; when is a special form of "if", with no else clause, it reads:
; (when <condition> <code-to-execute-1> <code-to-execute2> ...)
; (when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
; (when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
; (when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Wind-move
; (global-set-key (kbd "C-c C-j") 'windmove-left)
; (global-set-key (kbd "C-c C-k") 'windmove-down)
; (global-set-key (kbd "C-c C-l") 'windmove-up)
; (global-set-key (kbd "C-c C-;") 'windmove-right)
