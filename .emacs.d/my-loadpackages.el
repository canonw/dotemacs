; ~/.emacs.d/my-loadpackages.el
; loading package
(load "~/.emacs.d/my-packages.el")

;; Org Mode
(require 'org)
;; Make org-mode work with files ending in .org
;;(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(defun gtd ()
  (interactive)
  (find-file "~/org/gtd.org")
)
(setq org-agenda-files (list "~/org/gtd.org"
;                             "~/org/mastery.org"
))
;; Multi-state flow
(setq org-todo-keywords
    '((sequence "TODO(t)" "STARTED(s)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)" "DEFERRED(f)")
      (sequence "PENDING(p)" "|")))
;; Tag list
(setq org-tag-alist '(("@Computer" . ?c) ("@Work" . ?w) ("@Home" . ?h) ("Laptop" . ?l) ("Habit" . ?t)))
;; Shortcut key
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; magit
; (require 'magit)
; (define-key global-map (kbd "C-c m") 'magit-status)
;
;; yasnippet
; (require 'yasnippet)
; (yas-global-mode 1)
; (yas-load-directory "~/.emacs.d/snippets")
; (add-hook 'term-mode-hook (lambda()
;     (setq yas-dont-activate t)))
