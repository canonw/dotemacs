;; ; Set default column view headings: Task Effort Clock_Summary
;; (setq org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM")

;; Remove empty LOGBOOK drawers on clock out
(defun remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at (point))))


(use-package org
  :init
  (add-hook 'org-mode-hook 'visual-line-mode)
  (add-hook 'org-mode-hook 'org-indent-mode)
  (add-hook 'org-mode-hook 'flyspell-mode)
  (add-hook 'org-mode-hook (lambda () (linum-mode 0)))
  (add-hook 'org-clock-out-hook 'remove-empty-drawer-on-clock-out 'append)

  :defer t
  :bind (("\C-c a" . org-agenda)
         ("\C-cb" . org-iswitchb)
         ("\C-cl" . org-store-link)
         ("\C-cc" . org-capture))
  :config
  ;; Custom functions for emacs & org mode
  ;; (load-file "~/.emacs.d/config/bh-org.el")

  ;; Make folding neat
  (setq org-log-into-drawer t
        org-clock-into-drawer t)

  ;; Log TODO state change
  (setq org-log-done t)

  ;; Log schedule change
  ;; (setq org-log-reschedule (quote nil))
  ;; (setq org-log-reschedule (quote note))
  (setq org-log-reschedule (quote time))

  ;; Log deadline change
  ;; (setq org-log-redeadline (quote nil))
  ;; (setq org-log-redeadline (quote note))
  (setq org-log-redeadline (quote time))

  (setq org-use-fast-todo-selection t)
  (setq org-treat-S-cursor-todo-selection-as-state-change nil)

  ;; Targets complete directly with IDO
  (setq org-outline-path-complete-in-steps nil)

  ;; Allow refile to create parent tasks with confirmation
  (setq org-refile-allow-creating-parent-nodes (quote confirm))


  ;; Multi-state flow
  (setq org-todo-keywords
        (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "MEETING"))))
  (setq org-todo-keyword-faces
        (quote (("TODO" :foreground "red" :weight bold)
                ("NEXT" :foreground "blue" :weight bold)
                ("DONE" :foreground "forest green" :weight bold)
                ("WAITING" :foreground "orange" :weight bold)
                ("HOLD" :foreground "magenta" :weight bold)
                ("CANCELLED" :foreground "forest green" :weight bold)
                ("MEETING" :foreground "forest green" :weight bold)
                ("PHONE" :foreground "forest green" :weight bold))))
  
  ;; Agenda
  (setq org-agenda-window-setup 'current-window)
  (setq org-agenda-files (quote ("~/org" 
                                 )))

  ;; Use the current window for indirect buffer display
  (setq org-indirect-buffer-display 'current-window)

  ;; Show agenda in current window, keeping all other windows
  (setq org-agenda-window-setup 'current-window)

  ;; Do not dim blocked tasks
  (setq org-agenda-dim-blocked-tasks nil)

  ;; Compact the block agenda view
  (setq org-agenda-compact-blocks t)

  ;; ALways follow
  (add-hook 'org-agenda-mode-hook 'org-agenda-follow-mode)

  ;; Run/highlight code using babel in org-mode
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (ditaa . t)
     (plantuml . t)
     (sql . t)
     ))
  ;; Syntax hilight in #+begin_src blocks
  (setq org-src-fontify-natively t)

  (add-hook 'org-babel-after-execute-hook (lambda ()
                                            (condition-case nil
                                                (org-display-inline-images)
                                              (error nil)))
            'append)

  ;; http://orgmode.org/worg/org-contrib/babel/languages/ob-doc-ditaa.html
  (setq org-ditaa-jar-path (expand-file-name "~/.emacs.d/vendors/ditaa0_9.jar"))
  
  (setq org-plantuml-jar-path (expand-file-name "~/.emacs.d/vendors/plantuml.jar"))

  )

;; Tag list
(setq org-tag-alist (quote ((:startgroup)
                            ("POTD" . ?d)
                            ("POTW" . ?w)
                            ("POTM" . ?m)
                            ("NYR" . ?y)
                            (:endgroup)
;                             ("WAITING" . ?w)
;                             ("HOLD" . ?h)
;                             ("PERSONAL" . ?P)
;                             ("WORK" . ?W)
;                             ("ORG" . ?O)
;                             ("NORANG" . ?N)
;                             ("crypt" . ?E)
;                             ("NOTE" . ?n)
;                             ("CANCELLED" . ?c)
                            ("FLAGGED" . ??))))


;; Custom agenda command definitions
;; Reference:
;; http://orgmode.org/worg/org-tutorials/org-custom-agenda-commands.html
;; http://orgmode.org/manual/Matching-tags-and-properties.html
;; Change start date
;; http://emacs.stackexchange.com/questions/13075/agenda-span-of-last-7-days
(setq org-agenda-custom-commands
      (quote (("N" "Notes" tags "NOTE"
               ((org-agenda-overriding-header "Notes")
                (org-tags-match-list-sublevels t)))
              ("D" "Daily Action List"
               ((agenda "" ((org-agenda-ndays 1)
                       (org-agenda-sorting-strategy
                        (quote ((agenda time-up priority-down tag-up) )))
                       (org-deadline-warning-days 0)))))
              ("h" "Habits" tags-todo "STYLE=\"habit\""
               ((org-agenda-overriding-header "Habits")
                (org-agenda-sorting-strategy
                 '(todo-state-down effort-up category-keep))))
              ("g" "Planning Agenda"
               (
                (tags-todo "+NYR")
                (tags-todo "BURN-POTW-POTD")
                (tags-todo "+POTD")
                (tags-todo "+POTW-POTD") ;; Unplanned plan of the week
                (tags-todo "+TODO=\"NEXT\"-POTW-POTD-BURN|+TODO=\"WAITING\"") ;; Any NEXT action not part of planned
                (tags-todo "STYLE=\"habit\"")
               )
                nil                      ;; i.e., no local settings
                ("~/next-actions.html") ;; exports block to this file with C-c a e; TODO
               )
               ("w" "Next 7 Days Deadline"
                ((agenda "" ((org-agenda-span 8)))
                 ;; type "l" in the agenda to review logged items 
                 ;; (stuck "") ;; review stuck projects as designated by org-stuck-projects
                 ;; ..other commands here
                 )
                )))
      )

;; Tags trigger state list
(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING") ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))


;;; org-habit
(use-package org-install)
(use-package org-habit)
(add-to-list 'org-modules 'org-habit)
(setq org-habit-preceding-days 7
      org-habit-following-days 1
      org-habit-graph-column 80
      org-habit-show-habits-only-for-today t
      org-habit-show-all-today t)


;;; org-journal-dir
(setq org-journal-dir "~/journal")
(setq org-journal-date-format "%a, %Y-%m-%d")
(setq org-journal-time-format "%H:%M:%S ")


;;; org-crypt
;;;http://orgmode.org/worg/org-tutorials/encrypting-files.html 
(use-package org-crypt)
(require 'org-crypt)
     (org-crypt-use-before-save-magic)
     (setq org-tags-exclude-from-inheritance (quote ("crypt")))

     ;; Set org-crypt-key elsewhere. 
     ;; You may grep the keys by this commad line. gpg --list-keys | grep -B1 'you '
     ;; (setq org-crypt-key "XXXXXXX")
       ;; GPG key to use for encryption
       ;; Either the Key ID or set to nil to use symmetric encryption.
     
     (setq auto-save-default nil)
       ;; Auto-saving does not cooperate with org-crypt.el: so you need
       ;; to turn it off if you plan to use org-crypt.el quite often.
       ;; Otherwise, you'll get an (annoying) message each time you
       ;; start Org.
     
       ;; To turn it off only locally, you can insert this:
       ;;
       ;; # -*- buffer-auto-save-file-name: nil; -*-

(provide 'init-org)
