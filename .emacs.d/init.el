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
(require 'init-regex)
;; TODO
;; (require 'init-flyspell)

(use-package auto-complete
  :diminish auto-complete-mode
  :config
  (progn
;;    (ac-config-default)
   (setq ac-use-fuzzy t
         ac-disable-inline t
         ac-use-menu-map t
         ac-auto-show-menu t
         ac-auto-start t
         ac-ignore-case t
         ac-candidate-menu-min 0)
    (add-to-list 'ac-modes 'org-mode)
    (add-to-list 'ac-modes 'web-mode)
    (add-to-list 'ac-modes 'lisp-mode)
    ))

(use-package golden-ratio
  :ensure t
  :diminish golden-ratio-mode
  :init
  (golden-ratio-mode 1)
  (setq golden-ratio-auto-scale t)
  (defun pl/helm-alive-p ()
    (if (boundp 'helm-alive-p)
        (symbol-value 'helm-alive-p)))

(add-to-list 'golden-ratio-inhibit-functions 'pl/helm-alive-p)
  )

(use-package flyspell
  :ensure t
  :defer t
;;  :init
;;  (progn
;;    (add-hook 'prog-mode-hook 'flyspell-prog-mode)
;;    (add-hook 'text-mode-hook 'flyspell-mode)
;;    )
  :commands
  (flyspell-mode flyspell-prog-mode)
  :config
  (setq ispell-program-name (executable-find "aspell")
        ispell-extra-args '("--sug-mode=ultra"))
  )

(use-package winner
  :init (winner-mode))

(use-package ido
  :init (progn (ido-mode 1)
               (ido-everywhere 1))
  :config
  (progn
    (setq ido-case-fold t)
    (setq ido-everywhere t)
    (setq ido-enable-prefix nil)
    (setq ido-enable-flex-matching t)
    (setq ido-create-new-buffer 'always)
    (setq ido-max-prospects 10)
    (setq ido-use-faces nil)
    (setq ido-file-extensions-order '(".rb" ".el" ".coffee" ".js"))
    (add-to-list 'ido-ignore-files "\\.DS_Store")
    ))

(use-package ido-ubiquitous
  :init
  ;; Fix ido-ubiquitous for newer packages
  (defmacro ido-ubiquitous-use-new-completing-read (cmd package)
    `(eval-after-load ,package
       '(defadvice ,cmd (around ido-ubiquitous-new activate)
          (let ((ido-ubiquitous-enable-compatibility nil))
            ad-do-it)))))

(use-package smex
  :defer t
  :config
  (progn
    (smex-initialize)))

(require 'init-hydra)
(require 'init-helm)
(require 'init-evil)

(use-package monokai-theme :ensure t)
;; (use-package colonoscopy-theme)
;; (use-package color-theme-solarized :ensure t)
;; (use-package solarized-theme)  ;; replaced by color-theme-solarized
(use-package color-theme-sanityinc-tomorrow :ensure t)
(use-package zenburn-theme :ensure t)

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
;; (require 'init-emmet-mode)
;; 
;; (require 'init-ido)
(when *emacs24*
  (require 'init-org))
;; (require 'init-smex)
;; (require 'init-projectile)
;; 
(require 'init-markdown)

(require 'init-settings)

               
;; Local machine specific setup
(if (file-exists-p "~/init-local-setting.el") (load-file "~/init-local-setting.el"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
