;; ~/.emacs.d/my-loadpackages.el
(load "~/.emacs.d/my-packages.el")
					; loading package
;;;;
;;;;
;;; Org Mode
(require 'org)
(setq org-agenda-files (list "~/org/gtd.org"
                             "~/org/someday.org"
))
;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             (flyspell-mode)))
;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             (writegood-mode)))

;; Capture notes
(setq org-default-notes-file (concat org-directory "~/org/notes.org"))
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
             "* TODO %?\n  %U\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
             "* %?\nEntered on %U\n  %i\n  %a")))
'(org-refile-targets (quote (("newgtd.org" :maxlevel . 1) 
                              ("someday.org" :level . 2))))
;; Multi-state flow
;;(setq org-todo-keywords
;;    '((sequence "TODO(t)" "STARTED(s)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)" "DEFERRED(f)")
;;      (sequence "PENDING(p)" "|")))
(setq org-todo-keyword-faces
   (quote (("TODO" :foreground "medium blue" :weight bold)
		   ("APPT" :foreground "medium blue" :weight bold)
		   ("NOTE" :foreground "dark violet" :weight bold)
		   ("STARTED" :foreground "dark orange" :weight bold)
		   ("WAITING" :foreground "red" :weight bold)
		   ("DELEGATED" :foreground "red" :weight bold))))
;; Agenda
(setq org-agenda-custom-commands 
      '(
      ;; ("c" "Desk Work" tags-todo "computer" ;; (1) (2) (3) (4)
      ;;   ((org-agenda-files '("~/org/widgets.org" "~/org/clients.org")) ;; (5)
      ;;    (org-agenda-sorting-strategy '(priority-up effort-down))) ;; (5) cont.
      ;;   ("~/computer.html")) ;; (6)
        ;; ...other commands here
        ("D" "Daily Action List"
          (
           (agenda "" ((org-agenda-ndays 1)
                       (org-agenda-sorting-strategy
                        (quote ((agenda time-up priority-down tag-up) )))
                       (org-deadline-warning-days 0)
                       ))))
        ))
;;(setq org-tag-alist '(("@Computer" . ?c) ("@Work" . ?w) ("@Home" . ?h) ("Laptop" . ?l) ("Habit" . ?t)))
					; Tag list
(setq org-log-done t)
;; Shortcut key
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

;;; org-habit
(require 'org-install)
(require 'org-habit)
(add-to-list 'org-modules 'org-habit)
(setq org-habit-preceding-days 7
      org-habit-following-days 1
      org-habit-graph-column 80
      org-habit-show-habits-only-for-today t
      org-habit-show-all-today t)

;;; org-babel
;; http://orgmode.org/worg/org-contrib/babel/
(require 'ob)

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (ditaa . t)
   (plantuml . t)
   ))

;;  (sh . t)
;;   (dot . t)
;;   (ruby . t)
;;   (js . t)
;;   (C . t)

;; (add-to-list 'org-src-lang-modes (quote ("dot". graphviz-dot)))
;; (add-to-list 'org-src-lang-modes (quote ("plantuml" . fundamental)))
;;  (add-to-list 'org-babel-tangle-lang-exts '("clojure" . "clj"))

;; (defvar org-babel-default-header-args:clojure
;;   '((:results . "silent") (:tangle . "yes")))

;; (defun org-babel-execute:clojure (body params)
;;   (lisp-eval-string body)
;;   "Done!")

;; (provide 'ob-clojure)

(setq org-src-fontify-natively t
      org-confirm-babel-evaluate nil)

(add-hook 'org-babel-after-execute-hook (lambda ()
                                          (condition-case nil
                                              (org-display-inline-images)
                                            (error nil)))
          'append)

;; http://orgmode.org/worg/org-contrib/babel/languages/ob-doc-ditaa.html
(setq org-ditaa-jar-path (expand-file-name "~/.emacs.d/vendors/ditaa0_9.jar"))

(setq org-plantuml-jar-path (expand-file-name "~/.emacs.d/vendors/plantuml.jar"))

;;;;
;;;;
;;; evil-mode
(require 'evil)
(evil-mode t)

;;;;
;;;;
;;; magit
;; (require 'magit)
;; (define-key global-map (kbd "C-c m") 'magit-status)
;;

;;;;
;;;;
;; yasnippet
(require 'yasnippet)
(yas-global-mode 1)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"
			 ;; ... extra path here
			 ))
(add-hook 'term-mode-hook (lambda() (setq yas-dont-activate t)))

;;;;
;;;;
;; Recentf
;; http://www.emacswiki.org/emacs/RecentFiles
(require 'recentf)
(recentf-mode t)
					; Enable menu
(setq recentf-max-menu-items 25)
					; Maximum number of items
(global-set-key "\C-c\ \C-r" 'recentf-open-files)

;;;;
;;;;
;; Smex
;; (require 'smex)
;; (smex-initialize)

;;;;
;;;;
;; Ido
(ido-mode 1)
					; Enable auto suggestion 
(setq ido-enable-flex-matching t
      ido-everywhere t
					; Enable flex match in buffer and files
      ido-separator "\n"
					; Display choices vertically 
)
