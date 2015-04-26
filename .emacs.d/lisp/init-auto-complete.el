;; dirty fix for having AC everywhere
;; http://emacswiki.org/emacs/AutoComplete
(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda ()
                       (if (not (minibufferp (current-buffer)))
                           (auto-complete-mode 1))
                       ))
(real-global-auto-complete-mode t)

(provide 'init-auto-complete)
