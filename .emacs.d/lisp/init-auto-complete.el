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

(provide 'init-auto-complete)
