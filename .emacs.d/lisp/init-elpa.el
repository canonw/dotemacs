;   
;------------------------------------------------------------------------------
;; Find and load the correct package.el
;;------------------------------------------------------------------------------

;; When switching between Emacs 23 and 24, we always use the bundled package.el in Emacs 24
(let ((package-el-site-lisp-dir (expand-file-name "~/.emacs.d/site-lisp/package")))
  (when (and (file-directory-p package-el-site-lisp-dir)
             (> emacs-major-version 23))
    (message "Removing local package.el from load-path to avoid shadowing bundled version")
    (setq load-path (remove package-el-site-lisp-dir load-path))))

(require 'package)


;;; Standard package repositories

;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

;; We include the org repository for completeness, but don't normally
;; use it.
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))

(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

;;; Also use Melpa for most packages
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))


;;------------------------------------------------------------------------------
;; On-demand installation of packages
;;------------------------------------------------------------------------------

(defun require-package (package &optional min-version no-refresh)
  "Ask elpa to install given PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

  
;;------------------------------------------------------------------------------
;; Fire up package.el and ensure the following packages are installed.
;;------------------------------------------------------------------------------

(package-initialize)

;; Themes
(require-package 'colonoscopy-theme)
(require-package 'color-theme-sanityinc-tomorrow)
(require-package 'color-theme-solarized)
(require-package 'monokai-theme)
(require-package 'zenburn-theme)
(require-package 'zenburn-theme)
;; (require-package 'solarized-theme)  ;; replaced by color-theme-solarized

(require-package 'evil)
(require-package 'evil-escape)
(require-package 'evil-exchange)
(require-package 'evil-leader)
(require-package 'evil-matchit)
(require-package 'evil-nerd-commenter)
(require-package 'evil-numbers)
(require-package 'evil-surround)

(require-package 'dired+)
(require-package 'dired-sort)
(require-package 'dired-details)

(require-package 'ace-window)
(require-package 'avy)

(require-package 'elmacro)
(require-package 'ido-ubiquitous)
(when *emacs24*
  (require-package 'flx-ido))
(require-package 'smex)

(if *emacs24* (require-package 'yasnippet '(0 9 0 1) nil))

(require-package 'auto-complete)

(require-package 'emmet-mode)
(require-package 'markdown-mode)
;; cucumber-mode
(require-package 'feature-mode)

(require-package 'csharp-mode)

(require-package 'groovy-mode)

(require-package 'yaml-mode)

(require-package 'flyspell-lazy)

(require-package 'helm)
(require-package 'helm-swoop)

(require-package 'projectile)

(require-package 'restclient)
(require-package 'json-snatcher)

(provide 'init-elpa)

