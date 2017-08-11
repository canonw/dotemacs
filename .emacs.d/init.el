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
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system (if *win64* 'utf-16-le 'utf-8))
(prefer-coding-system 'utf-8)

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

;;; Dired
(use-package dired
  :ensure nil
  :config

  (use-package peep-dired
    :commands peep-dired
    :config
    (modeline-set-lighter 'peep-dired " 👁")

    ;; Functions
    (defun turn-off-openwith-mode ()
      (make-local-variable 'openwith-mode)
      (if (not peep-dired)
          (openwith-mode 1)
        (openwith-mode -1)))

    ;; Hooks
    (add-hook 'peep-dired-hook #'turn-off-openwith-mode)

    ;; Key Bindings
    (bind-keys :map peep-dired-mode-map
               ("n" . peep-dired-next-file)
               ("p" . peep-dired-prev-file)
               ("K" . peep-dired-kill-buffers-without-window)
               ("C-n" . dired-next-line)
               ("C-p" . dired-previous-line))

    ;; Variables
    (add-to-list 'peep-dired-ignored-extensions "mp3"))

  ;; Commands
  (defun dired-jump-to-top ()
    (interactive)
    (goto-char (point-min))
    (if dired-hide-details-mode
        (dired-next-line 3)
      (dired-next-line 4)))

  (defun dired-jump-to-bottom ()
    (interactive)
    (goto-char (point-max))
    (dired-next-line -1))

  ;; Commands
  (put 'dired-find-alternate-file 'disabled nil)

  ;; Hooks
  (add-hook 'dired-mode-hook #'dired-hide-details-mode)

  ;; Key Bindings
  (bind-keys :map dired-mode-map
             (")" . dired-hide-details-mode)
             ((vector 'remap 'beginning-of-buffer) . dired-jump-to-top)
             ((vector 'remap 'end-of-buffer) . dired-jump-to-bottom))

  ;; Variables
  (setq dired-dwim-target t)
  (setq dired-isearch-filenames "dwim")
  (setq dired-listing-switches "-alh --time-style=long-iso")
  (setq dired-recursive-copies 'always))

(use-package dired-x
  :ensure nil
  :bind ("C-x C-j" . dired-jump)
  :config
  ;; Hooks
  (add-hook 'dired-mode-hook #'dired-omit-mode)

  ;; Key Bindings
  (bind-key "M-o" #'dired-omit-mode dired-mode-map)

  ;; Variables
  (setq dired-omit-files "^\\...+$"))

(use-package direx
  :bind ("C-x C-d" . direx:jump-to-directory)
  :config

  ;; Key Bindings
  (bind-keys :map direx:direx-mode-map
             ("M-n" . direx:next-sibling-item)
             ("M-p" . direx:previous-sibling-item))

  ;; Variables
  (setq direx:closed-icon "▶ ")
  (setq direx:leaf-icon "  ")
  (setq direx:open-icon "▼ "))

;;; Dired


(require 'init-flycheck)
(require 'init-company)

(require 'init-evil)
(require 'init-org)

(require 'init-helm)


(electric-pair-mode 1)

(use-package ag
  :commands (ag ag-regexp ag-project))

(use-package twilight-bright-theme
  :ensure t
:config (load-theme 'twilight-bright t))

(use-package term
  :disabled
  :bind (("C-c t" . term)
         :map term-mode-map
         ("M-p" . term-send-up)
         ("M-n" . term-send-down)
         :map term-raw-map
         ("M-o" . other-window)
         ("M-p" . term-send-up)
         ("M-n" . term-send-down))
  )

(require 'init-which-key)
(require 'init-expand-region)


(use-package miniedit
  :ensure t
  :commands minibuffer-edit
  :init (miniedit-install))

(use-package winner
  :defer t)

(use-package undo-tree
  :diminish undo-tree-mode
  :config
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t)))

(use-package browse-kill-ring
  :bind (("C-c k" . browse-kill-ring))
  :config
  (setq browse-kill-ring-show-preview nil))

;(use-package ruby-mode
;  :mode "\\.rb\\'"
;  :interpreter "ruby")

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



(use-package whitespace
  :bind (("C-c T w" . whitespace-mode))
  :init
  (dolist (hook '(prog-mode-hook text-mode-hooki
                  conf-mode-hook))
    (add-hook hook #'whitespace-mode))
  :config (setq whitespace-line-column nil)
  :diminish whitespace-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (fullframe))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
