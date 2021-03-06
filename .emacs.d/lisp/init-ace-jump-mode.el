;; ace jump mode major function
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)

;; enable a more powerful jump back function from ace jump mode
;;
;;(autoload
;;  'ace-jump-mode-pop-mark
;;  "ace-jump-mode"
;;  "Ace jump back:-)"
;;  t)
;;(eval-after-load "ace-jump-mode"
;;                   '(ace-jump-mode-enable-mark-sync))
;;(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

(provide 'init-ace-jump-mode)
