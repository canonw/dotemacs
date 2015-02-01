;; ~/.emacs.d/my-noexternals.el

(set-language-environment "UTF-8")
					; Set UTF-8 as default 
(setq inhibit-splash-screen 1)
					; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-scratch-message 1) 
					; Disable scratch message 
;; (scroll-bar-mode -1)
					; Disable scroll bar
(tool-bar-mode -1)
					; Disable tool bar
;; (menu-bar-mode -1)
					; Disable menu bar
(transient-mark-mode 1)
					; Enable transient mark mode
(setq use-dialog-box nil
					; Disable dialog box
      visible-bell 1)
					; Mute noise
(setq make-backup-files nil)
					; Disable backup file
(defalias 'yes-or-no-p 'y-or-n-p)
					; Shorten yes and no
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
					; Temporary file
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;;; Font
;; (when window-system
;;   (setq frame-title-format '(buffer-file-name "%f" ("%b")))
;;   (set-face-attribute 'default nil
;;                       :family "Inconsolata"
;;                       :height 140
;;                       :weight 'normal
;;                       :width 'normal)
;; 
;;   (when (functionp 'set-fontset-font)
;;     (set-fontset-font "fontset-default"
;;                       'unicode
;;                       (font-spec :family "DejaVu Sans Mono"
;;                                  :width 'normal
;;                                  :size 12.4
;;                                  :weight 'normal))))

;; (setq-default indicate-empty-lines t)
;; (when (not indicate-empty-lines)
;;   (toggle-indicate-empty-lines))

;;; Line number
(global-linum-mode 1)
					; Line number format - include line seperator, no leading space
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

;;; Color Theme
;;(if window-system
;;    (load-theme 'solarized-dark t)
;;  (load-theme 'wombat t))

(load-random-theme)
;;(run-with-timer 1 (* 60 60) 'load-random-theme)
					; Load different theme periodically

;; Remove scrollbars, menu bars, and toolbars
;; when is a special form of "if", with no else clause, it reads:
;; (when <condition> <code-to-execute-1> <code-to-execute2> ...)
;; (when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
;; (when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
;; (when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Wind-move
;; (global-set-key (kbd "C-c C-j") 'windmove-left)
;; (global-set-key (kbd "C-c C-k") 'windmove-down)
;; (global-set-key (kbd "C-c C-l") 'windmove-up)
;; (global-set-key (kbd "C-c C-;") 'windmove-right)

;; Tab width mode
;; (setq tab-width 2
;;      indent-tabs-mode nil)

(show-paren-mode t)
					; Show parenthesis 

;; Make file in Unix mode
(defun no-junk-please-were-unixish ()
  (let ((coding-str (symbol-name buffer-file-coding-system)))
    (when (string-match "-\\(?:dos\\|mac\\)$" coding-str)
      (setq coding-str
	    (concat (substring coding-str 0 (match-beginning 0)) "-unix"))
      (message "CODING: %s" coding-str)
      (set-buffer-file-coding-system (intern coding-str)))))
(add-hook 'find-file-hooks 'no-junk-please-were-unixish)

;;; Custom mode setup
(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    ;; Enable ruler mode
	    (ruler-mode)
	    ;; Enable whitespace mode 
	    (whitespace-mode)
	    ))
