; ~/.emacs

(load "~/.emacs.d/my-loadpackages.el")
(load "~/.emacs.d/my-methods.el")
(add-hook 'after-init-hook '(lambda ()
  (load "~/.emacs.d/my-noexternals.el")
))

;; Change Log
;; 2014-06-24 Revise Org mode
;; 2014-06-24 No splash screen
;; 2014-06-24 Transient mode
;; 2014-06-24 Tryout Viper
;; 2014-07-02 Line Numbers http://www.emacswiki.org/emacs/LineNumbers
;; 2014-07-03 Add package system http://ergoemacs.org/emacs/emacs_package_system.html
;; 2014-07-03 Color Theme http://www.emacswiki.org/emacs/ColorTheme
;;            http://stackoverflow.com/questions/9472254/setting-emacs-24-color-theme-from-emacs
;;            http://emacsredux.com/blog/2013/08/21/color-themes-redux/
;; 2014-11-12 Learn logically organically in Emacs configuration, functions, packages in separate files
;;            http://toumorokoshi.github.io/emacs-from-scratch-part-1-extending-emacs-basics.html
;;            http://toumorokoshi.github.io/emacs-from-scratch-part-2-package-management.html
;;            http://toumorokoshi.github.io/emacs-from-scratch-part-3-extending-emacs-with-elisp.html