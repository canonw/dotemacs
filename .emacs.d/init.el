;; -*- coding: utf-8 -*-
;(defvar best-gc-cons-threshold gc-cons-threshold "Best default gc threshold value. Should't be too big.")

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(defvar best-gc-cons-threshold 4000000 "Best default gc threshold value. Should't be too big.")
;; don't GC during startup to save time
(setq gc-cons-threshold most-positive-fixnum)

(setq emacs-load-start-time (current-time))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))

;;----------------------------------------------------------------------------
;; Which functionality to enable (use t or nil for true and false)
;;----------------------------------------------------------------------------
(setq *is-a-mac* (eq system-type 'darwin))
(setq *win64* (eq system-type 'windows-nt) )
(setq *cygwin* (eq system-type 'cygwin) )
(setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)) )
(setq *unix* (or *linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)) )
(setq *emacs24* (and (not (featurep 'xemacs)) (or (>= emacs-major-version 24))) )
(setq *no-memory* (cond
                   (*is-a-mac*
                    (< (string-to-number (nth 1 (split-string (shell-command-to-string "sysctl hw.physmem")))) 4000000000))
                   (*linux* nil)
                   (t nil)))

(setq *emacs24old*  (or (and (= emacs-major-version 24) (= emacs-minor-version 3))
                        (not *emacs24*)))

;; *Message* buffer should be writable in 24.4+
(defadvice switch-to-buffer (after switch-to-buffer-after-hack activate)
  (if (string= "*Messages*" (buffer-name))
      (read-only-mode -1)))

;; ;; create the savefile dir if it doesn't exist
;; (setq savefile-dir (expand-file-name ".savefile" user-emacs-directory))
;; (unless (file-exists-p savefile-dir)
;;   (make-directory savefile-dir))

;; Set UTF-8 as default
(set-language-environment 'utf-8)
;; (setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
;; (set-selection-coding-system (if *win64* 'utf-16-le 'utf-8))
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setenv "LANG" "en_US")                 ; Required by hunspell.
                                        ; https://emacs.stackexchange.com/questions/30008/hunspell-flyspell-and-emacs-on-windows

(if (member "Consolas" (font-family-list))
    (set-face-attribute 'default nil :font "Consolas 12"))

(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'set-scroll-bar-mode)
  (set-scroll-bar-mode nil))
;; (when (fboundp 'menu-bar-mode)
;;  (menu-bar-mode -1))

(fset 'yes-or-no-p 'y-or-n-p)

;; (setq standard-indent 2)
(setq-default indent-tabs-mode nil)

;;  ____              _       _                   
;; | __ )  ___   ___ | |_ ___| |_ _ __ __ _ _ __  
;; |  _ \ / _ \ / _ \| __/ __| __| '__/ _` | '_ \ 
;; | |_) | (_) | (_) | |_\__ \ |_| | | (_| | |_) |
;; |____/ \___/ \___/ \__|___/\__|_|  \__,_| .__/ 
;;                                        |_|    
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
;; Calls (package-initialize)
(require 'init-elpa)      ;; Machinery for installing required packages


;;  _____ _ _        ____       _   _   _             
;; |  ___(_) | ___  / ___|  ___| |_| |_(_)_ __   __ _ 
;; | |_  | | |/ _ \ \___ \ / _ \ __| __| | '_ \ / _` |
;; |  _| | | |  __/  ___) |  __/ |_| |_| | | | | (_| |
;; |_|   |_|_|\___| |____/ \___|\__|\__|_|_| |_|\__, |
;;                                              |___/ 
(if (not (file-exists-p (expand-file-name "~/.backups")))
  (make-directory (expand-file-name "~/.backups")))
(setq backup-by-coping t ; don't clobber symlinks
      backup-directory-alist '(("." . "~/.backups"))
      delete-old-versions t
      version-control t  ;use versioned backups
      kept-new-versions 6
      kept-old-versions 2)
(setq version-control t)
(setq vc-make-backup-files t)

;; History
(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))

(require 'init-recentf)

(require 'init-whitespace-mode)
(require 'init-linum-mode)
(require 'init-flycheck)
(require 'init-flyspell)
(require 'init-company)

(require 'init-evil)
(require 'init-org)

(require 'init-helm)

(require 'init-which-key)
(require 'init-expand-region)
(require 'init-calendar)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward
      uniquify-separator ":")

(use-package miniedit
  :commands minibuffer-edit
  :init (miniedit-install)
  )

(use-package winner
  :defer t)

(use-package undo-tree
  :diminish undo-tree-mode
  :config
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t))
  )

(use-package browse-kill-ring
  :bind (("C-c k" . browse-kill-ring))
  :config
  (setq browse-kill-ring-show-preview nil)
  )

(require 'init-markdown-mode)
(require 'init-recentf)

(use-package ruby-mode
  :mode "\\.rb\\'"
  :interpreter "ruby"
  :functions inf-ruby-keys
  :config
  (defun my-ruby-mode-hook ()
    (require 'inf-ruby)
    (inf-ruby-keys))

  (add-hook 'ruby-mode-hook 'my-ruby-mode-hook))

(use-package texinfo
  :defines texinfo-section-list
  :commands texinfo-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.texi$" . texinfo-mode)))

;; The package is "python" but the mode is "python-mode":
(use-package python
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode))

;; (use-package edit-server
;;   :if window-system
;;   :init
;;   (add-hook 'after-init-hook 'server-start t)
;;   (add-hook 'after-init-hook 'edit-server-start t))
;; ;; Start server only if needed
;; (unless (server-running-p) (server-start))

;; Don't show anything for rainbow-mode.
(use-package rainbow-mode)
;;  :delight)

;; Don't show anything for auto-revert-mode, which doesn't match
;; its package name.
(use-package autorevert
  :delight auto-revert-mode)

;; Remove the mode name for projectile-mode, but show the project name.
(use-package projectile
  :delight '(:eval (concat " " (projectile-project-name))))

;; Completely hide visual-line-mode and change auto-fill-mode to " AF".
(use-package emacs
  :delight
  (auto-fill-function " AF")
  (visual-line-mode))

(use-package color-theme-sanityinc-tomorrow :ensure t :defer t)
;; (use-package color-theme-modern :ensure t :defer t)
;; (add-hook 'markdown-mode-hook
;;   (lambda ()
;;     ;; (set-frame-parameter (window-frame) 'background-mode 'dark)
;;     (enable-theme 'sanityinc-tomorrow-eighties)
;;     )
;;   )
(add-hook 'after-init-hook (lambda () (load-theme 'sanityinc-tomorrow-eighties)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
