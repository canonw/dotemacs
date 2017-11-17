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
(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp"))

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
;; Make sure Windows are paste without octal sequences.
(set-selection-coding-system (if *win64* 'utf-16-le 'utf-8))
(prefer-coding-system 'utf-8)

(setenv "LANG" "en_US")                 ; Required by hunspell.
                                        ; https://emacs.stackexchange.com/questions/30008/hunspell-flyspell-and-emacs-on-windows

;; (if (not *win64* )
;;     ;; Add bash shell path reference to avoid '/bin/bash: ???: command not found' issue
;;     ;; Reference: https://stackoverflow.com/questions/4393628/emacs-shell-command-not-found
;;     (setq shell-command-switch "-ic"))

;; (if (member "Consolas" (font-family-list))
;;     (set-face-attribute 'default nil :font "Consolas 12"))
(require 'init-fonts)

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

(use-package savehist
  :config
  (savehist-mode 1)
  ;; (setq savehist-file "~/.emacs.d/savehist")
  (setq history-length t)
  (setq history-delete-duplicates t)
  (setq savehist-save-minibuffer-history 1)
  (setq savehist-additional-variables
        '(kill-ring search-ring regexp-search-ring comint-input-ring))
  )

(if (not *emacs24*)
 (use-package saveplace
   :init (save-place-mode)))

(require 'init-recentf)

(require 'init-whitespace-mode)
(require 'init-linum-mode)

(use-package crux
  :demand t
  :bind
  (("C-c n" . crux-cleanup-buffer-or-region)
   ("C-c k" . crux-kill-other-buffers)
   ([remap kill-whole-line] . crux-kill-whole-line))
  :config
  (crux-with-region-or-buffer indent-region)
  (crux-with-region-or-buffer untabify)
  (crux-with-region-or-line kill-region))

(require 'init-flycheck)
(require 'init-flyspell)
(require 'init-dired)
(require 'init-company)
(require 'init-yasnippet)

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

(use-package git-link
  :bind
  (
   ("C-c g l" . git-link)
   ("C-c g c" . git-link-commit)
   ("C-c g h" . git-link-homepage)
   )
  )

(require 'init-magit)

(use-package winner
  :defer t)

(use-package ace-window)

(use-package undo-tree
  :diminish undo-tree-mode
  :config
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t))
  )

(use-package browse-kill-ring           ; Replace by helm-show-kill-ring
  :disabled t
  :bind (("C-c k" . browse-kill-ring))
  :config
  (setq browse-kill-ring-show-preview nil))

(use-package avy
  :bind (("C-S-s" . avy-goto-char-timer))
  )

(use-package quickrun)

(require 'init-markdown-mode)
(require 'init-recentf)
(require 'init-hydra)

(require 'init-csharp-mode)

(use-package groovy-mode)

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

(require 'init-java-mode)

(use-package yaml-mode
  :defer t
  :mode ("\\.ya?ml\\'" . yaml-mode)
  )

(require 'init-json-mode)

(defun browse-file-directory ()
  "Open the current file's directory however the OS would."
  (interactive)
  (if default-directory
      (browse-url-of-file (expand-file-name default-directory))
    (error "No `default-directory' to open")))

;; Insert Date and Time
;; Reference: http://stackoverflow.com/questions/251908/how-can-i-insert-current-date-and-time-into-a-file-using-emacs
;; Reference :http://www.emacswiki.org/emacs/InsertingTodaysDate
(defvar timestamp-format "%Y-%m-%dT%T%z"
  "Format of timestamp to insert with `timestamp' func
See help of `format-time-string' for possible replacements")
(defun timestamp ()
  (interactive)
  (insert (format-time-string timestamp-format (current-time))))

;; (use-package edit-server
;;   :if window-system
;;   :init
;;   (add-hook 'after-init-hook 'server-start t)
;;   (add-hook 'after-init-hook 'edit-server-start t))
;; ;; Start server only if needed
;; (unless (server-running-p) (server-start))
(use-package server
  :config
  (unless (server-running-p)
    (server-start)))

(use-package rainbow-mode
  :diminish rainbow-mode
  :config
  (rainbow-mode)
  (add-hook 'prog-mode-hook 'rainbow-mode)
  )

(require 'init-parens)

;; Don't show anything for auto-revert-mode, which doesn't match
;; its package name.
(use-package autorevert
  :delight auto-revert-mode)

(use-package projectile
  :delight '(:eval (concat " [" (projectile-project-name) "]")) ; Show project name wihtout mode name.
  :config
  (setq projectile-indexing-method 'native)
  ;; (setq projectile-enable-caching t)
  ;; (setq projectile-file-exists-local-cache-expire (* 5 60))
  (add-hook 'prog-mode-hook 'projectile-mode)
  )

(use-package perspeen
  :disabled t                           ; Dependency on powerline
  :config
  (setq perspeen-keymap-prefix (kbd "C-c C-'")))

(use-package persp-mode
  :init
  (setq persp-keymap-prefix (kbd "C-c C-p"))

  (use-package persp-mode-projectile-bridge
    :disabled t                         ; Test laster
    :after projectile
    :config
    (with-eval-after-load "persp-mode-projectile-bridge-autoloads"
      (add-hook 'persp-mode-projectile-bridge-mode-hook
                #'(lambda ()
                    (if persp-mode-projectile-bridge-mode
                        (persp-mode-projectile-bridge-find-perspectives-for-all-buffers)
                      (persp-mode-projectile-bridge-kill-perspectives))))
      (add-hook 'after-init-hook
                #'(lambda ()
                    (persp-mode-projectile-bridge-mode 1))
                t)))
  )
 
(use-package perspective
  :disabled t
  :config
  (persp-mode)) 

(use-package persp-projectile
  :disabled t
  :after perspective
  :config
  (define-key projectile-mode-map (kbd "s-s") 'projectile-persp-switch-project))

(use-package workgroups2
  :disabled t
  :init
  (setq wg-prefix-key (kbd "C-c z"))
  ;; (setq wg-session-file "~/.emacs.d/.emacs_workgroups")
  :config
  (workgroups-mode 1))

(use-package try :ensure t :defer t)

;; Completely hide visual-line-mode and change auto-fill-mode to " AF".
(use-package emacs
  :delight
  (auto-fill-function " AF")
  (visual-line-mode))

(defmacro def (name &rest body)
  (declare (indent 1) (debug t))
  `(defun ,name (&optional _arg)
     ,(if (stringp (car body)) (car body))
     (interactive "p")
     ,@(if (stringp (car body)) (cdr `,body) body)))

(use-package s
  :bind ("M-c" . transform-symbol-at-point)
  :config
  (def transform-symbol-at-point
    (let* ((choices '((?c . s-lower-camel-case)
                      (?C . s-upper-camel-case)
                      (?_ . s-snake-case)
                      (?- . s-dashed-words)
                      (?d . s-downcase)
                      (?u . s-upcase)))
           (chars (mapcar #'car choices))
           (prompt (concat "Transform symbol at point [" chars "]: "))
           (ch (read-char-choice prompt chars))
           (fn (assoc-default ch choices))
           (symbol (thing-at-point 'symbol t))
           (bounds (bounds-of-thing-at-point 'symbol)))
      (when fn
        (delete-region (car bounds) (cdr bounds))
        (insert (funcall fn symbol))))))

;; Local machine specific setup
(if (file-exists-p "~/init-local-setting.el") (load-file "~/init-local-setting.el"))

(require 'init-theme)

(when (eq *win64* t)
    (add-to-list 'exec-path "C:/ProgramData/chocolatey/bin")
    (setenv "PATH" (mapconcat #'identity exec-path path-separator))
    ) 

