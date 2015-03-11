;; ~/.emacs.d/my-packages.el
(require 'cl)

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives
	       '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives
	       '("marmalade" . "http://marmalade-repo.org/packages/") t)
  (package-initialize)
  )

(defvar required-packages
  '(
    evil
    evil-surround
    evil-numbers
    markdown-mode
    magit
    auto-complete
    yasnippet
    js2-mode
    ;; ac-js2
    ;; smex
    ;; csharp-mode
    ;; themes
    monokai-theme
    solarized-theme
    zenburn-theme
    colonoscopy-theme
    ) "a list of packages to ensure are installed at launch.")

;; Method to check if all packages are installed
(defun packages-installed-p ()
  (loop for p in required-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

;; If not all packages are installed, check one by one and in the missing ones.
(unless (packages-installed-p)
  ;; Check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; Install the missing packages
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))
