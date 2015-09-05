;; Centralize all libraries in one place

;;
;; ace-jump-mode
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
 
;;If you use evil
; (eval-after-load "evil" '(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode))

(provide 'init-key-bindings)
