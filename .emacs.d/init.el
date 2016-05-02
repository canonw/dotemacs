;;;; -*- coding: utf-8 -*-
;;(setq emacs-load-start-time (current-time))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))

;;----------------------------------------------------------------------------
;; Which functionality to enable (use t or nil for true and false)
;;----------------------------------------------------------------------------
(setq *macbook-pro-support-enabled* t)
(setq *is-a-mac* (eq system-type 'darwin))
(setq *is-carbon-emacs* (and *is-a-mac* (eq window-system 'mac)))
(setq *is-cocoa-emacs* (and *is-a-mac* (eq window-system 'ns)))
(setq *win32* (eq system-type 'windows-nt) )
(setq *cygwin* (eq system-type 'cygwin) )
(setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)) )
(setq *unix* (or *linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)) )
(setq *linux-x* (and window-system *linux*) )
(setq *xemacs* (featurep 'xemacs) )
(setq *emacs23* (and (not *xemacs*) (or (>= emacs-major-version 23))) )
(setq *emacs24* (and (not *xemacs*) (or (>= emacs-major-version 24))) )
(setq *no-memory* (cond
                   (*is-a-mac*
                    (< (string-to-number (nth 1 (split-string (shell-command-to-string "sysctl hw.physmem")))) 4000000000))
                   (*linux* nil)
                   (t nil)))

;;----------------------------------------------------------------------------
;; Less GC, more memory
;;----------------------------------------------------------------------------
;; By default Emacs will initiate GC every 0.76 MB allocated
;; (gc-cons-threshold == 800000).
;; we increase this to 512MB
;; @see http://www.gnu.org/software/emacs/manual/html_node/elisp/Garbage-Collection.html
(setq-default gc-cons-threshold (* 1024 1024 512)
              gc-cons-percentage 0.5)

(require 'init-elpa)

(use-package expand-region
  :ensure t
  :defer t)

(use-package ace-window
  :ensure t
  :defer t)
(use-package avy
  :ensure t
  :defer t)
;
(require 'init-utils)

(require 'init-calendar)
(require 'init-linum-mode)
(require 'init-modeline)
(require 'init-dired)
(require 'init-whitespace-mode)
;; TODO
;; (require 'init-flyspell)

(use-package recentf
  :config (recentf-mode 1)
  )

(require 'init-hydra)
(require 'init-helm)
(require 'init-evil)

(use-package monokai-theme
  :ensure t
;;  :config (load-theme 't)
  )
;; (use-package colonoscopy-theme)
(use-package color-theme-sanityinc-tomorrow
;; (use-package color-theme-solarized
  :ensure t
  )
(use-package zenburn-theme
  :ensure t
  )
;; (use-package solarized-theme)  ;; replaced by color-theme-solarized

;; (require 'init-yasnippet)
(use-package yasnippet
  :init
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"
                           ;; ... extra path here
                           ))
  :config
  (yas-global-mode 1)
  (add-hook 'term-mode-hook (lambda() (setq yas-dont-activate t)))
  )

;; ;; (require 'init-ace-jump-mode) ;; Replace by avy

;; (require 'init-auto-complete)
;; 
;; (require 'init-sql)
;; 
;; (require 'init-markdown)
;; (require 'init-emmet-mode)
;; 
;; (require 'init-ido)
;; (when *emacs24*
;;   (require 'init-org))
;; (require 'init-smex)
;; (require 'init-projectile)
;; 

(require 'init-settings)



;;   ;; Sets your shell to use cygwin's bash, if Emacs finds it's running
;;   ;; under Windows and c:\cygwin exists. Assumes that C:\cygwin\bin is
;;   ;; not already in your Windows Path (it generally should not be).
;;   ;;
;;   (let* ((cygwin-root "c:/cygwin64")
;;          (cygwin-bin (concat cygwin-root "/bin")))
;;     (when (and (eq 'windows-nt system-type)
;;   	     (file-readable-p cygwin-root))
;;     
;;       (setq exec-path (cons cygwin-bin exec-path))
;;       (setenv "PATH" (concat cygwin-bin ";" (getenv "PATH")))
;;     
;;       ;; By default use the Windows HOME.
;;       ;; Otherwise, uncomment below to set a HOME
;;       ;;      (setenv "HOME" (concat cygwin-root "/home/eric"))
;;     
;;       ;; NT-emacs assumes a Windows shell. Change to bash.
;;       (setq shell-file-name "bash")
;;       (setenv "SHELL" shell-file-name) 
;;       (setq explicit-shell-file-name shell-file-name) 
;;     
;;       ;; This removes unsightly ^M characters that would otherwise
;;       ;; appear in the output of java applications.
;;       (add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)))
;; (require 'init-key-bindings)
;; (put 'narrow-to-region 'disabled nil)
;; 
;; (require 'swiper-helm)
;; 
;; ;; Local machine specific setup
;; (if (file-exists-p "~/init-local-setting.el") (load-file "~/init-local-setting.el"))
;; 
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(custom-safe-themes
;;    (quote
;;     ("1e3b2c9e7e84bb886739604eae91a9afbdfb2e269936ec5dd4a9d3b7a943af7f" "196cc00960232cfc7e74f4e95a94a5977cb16fd28ba7282195338f68c84058ec" "05c3bc4eb1219953a4f182e10de1f7466d28987f48d647c01f1f0037ff35ab9a" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" default))))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )
