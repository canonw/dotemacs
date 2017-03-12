;;; -*- coding: utf-8 -*-
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
;;  (add-to-list 'golden-ratio-exclude-buffer-names "*Calendar*")
  (add-to-list 'golden-ratio-exclude-modes "calendar-mode")
  (add-to-list 'golden-ratio-exclude-modes "ediff-mode")
  (add-to-list 'golden-ratio-exclude-modes "eshell-mode")
  (add-to-list 'golden-ratio-exclude-modes "dired-mode")
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
  :demand t
  :mode ("/\\.emacs\\.d/snippets/" . snippet-mode)
  :diminish yas-minor-mode
  :defer 15
  :config
  (yas-global-mode 1)
  ;; (add-hook 'term-mode-hook (lambda() (setq yas-dont-activate t)))
  )

;; Use for case convertion
(use-package string-inflection :ensure t
  :init
  (global-unset-key (kbd "C-q"))
  (global-set-key (kbd "C-q C-u") 'string-inflection-cycle)
  )

(use-package company
  :ensure t
  :defer t
  :init (global-company-mode)
  :config
  (progn
    ;; Use Company for completion
    (bind-key [remap completion-at-point] #'company-complete company-mode-map)

    (setq company-tooltip-align-annotations t
          ;; Easy navigation to candidates with M-<n>
          company-show-numbers t)
    (setq company-dabbrev-downcase nil))
  :diminish company-mode
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

(require 'init-alias)

(use-package yankpad
  :ensure t
  :defer 10
  :init
  (setq yankpad-file "~/org/yankpad.org")
  :config
  ;; (bind-key "<f7>" 'yankpad-map)
  ;; (bind-key "<f12>" 'yankpad-expand)
  ;; If you want to complete snippets using company-mode
  ;; (add-to-list 'company-backends #'company-yankpad)
  )

(use-package text
  :init
  (add-hook 'text-mode-hook (lambda () (linum-mode 1)))
)

;; Local machine specific setup
(if (file-exists-p "~/init-local-setting.el") (load-file "~/init-local-setting.el"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("c4465c56ee0cac519dd6ab6249c7fd5bb2c7f7f78ba2875d28a50d3c20a59473" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "1e3b2c9e7e84bb886739604eae91a9afbdfb2e269936ec5dd4a9d3b7a943af7f" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default))))
