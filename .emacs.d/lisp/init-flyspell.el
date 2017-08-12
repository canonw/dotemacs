;; http://blog.binchen.org/posts/what-s-the-best-spell-check-set-up-in-emacs.html

(use-package flyspell
  :ensure t
  :defer t
  :init
  (progn
    (add-hook 'prog-mode-hook 'flyspell-prog-mode)
    (add-hook 'text-mode-hook 'flyspell-mode)
    )
  :commands
  (flyspell-mode flyspell-prog-mode)
  :config
  (cond
   ;; try hunspell at first. if hunspell does NOT exist, use aspell
   ((executable-find "hunspell")
    (message "using hunspell")
    (setq ispell-program-name "hunspell"
          ispell-local-dictionary "en_US")
    (setq ispell-local-dictionary-alist
          ;; Please note the list `("-d" "en_US")` contains ACTUAL parameters passed to hunspell
          ;; You could use `("-d" "en_US,en_US-med")` to check with multiple dictionaries
          '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8)
            )))
   ((executable-find "aspell")
    (message "using aspell")
    (setq ispell-program-name "aspell") ; Please note ispell-extra-args contains ACTUAL parameters passed to aspell
    ispell-extra-args '("--sug-mode=ultra" "--lang=en_US"))
   )
  )

(provide 'init-flyspell)
