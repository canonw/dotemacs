;; Set default column view headings: Task Effort Clock_Summary
;; (setq org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM")
;; Remove empty LOGBOOK drawers on clock out
(defun remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at (point)))
  )
;; org-babel
(use-package ob-csharp :disabled (*win64*))
(use-package ob-http)
(use-package ob-kotlin :disabled (*win64*))
(use-package ob-mongo)

(use-package org
  :ensure org-plus-contrib
  :pin org                              ; Fetch org package
  :bind (("C-c a" . org-agenda)
         ("\C-cb" . org-iswitchb)
         ("\C-cl" . org-store-link)
         ("\C-cc" . org-capture))
  :init
  (add-hook 'org-mode-hook (lambda ()
                             (visual-line-mode)
                             (org-indent-mode)
                             (flyspell-mode)
                             (linum-mode -1) ; Kill this mode to maintain speed
                             (whitespace-mode -1)
                             (org-bullets-mode 1)))
  (add-hook 'org-clock-out-hook 'remove-empty-drawer-on-clock-out 'append)
  :config
  ;; Don't override my key binding setting
  ;; (define-key org-mode-map (kbd "<M-S-up>") nil)
  ;; (define-key org-mode-map (kbd "<M-S-down>") nil)
  ;; (define-key org-mode-map (kbd "<M-up>") nil)
  ;; (define-key org-mode-map (kbd "<M-down>") nil)
  ;; (define-key org-mode-map (kbd "<M-S-left>") nil)
  ;; (define-key org-mode-map (kbd "<M-S-right>") nil)
  ;; (define-key org-mode-map (kbd "<M-left>") nil)
  ;; (define-key org-mode-map (kbd "<S-left>") nil)
  ;; (define-key org-mode-map (kbd "<S-right>") nil)
  ;; (define-key org-mode-map (kbd "<S-up>") nil)
  ;; (define-key org-mode-map (kbd "<S-down>") nil)
  ;; (define-key org-mode-map (kbd "<M-right>") nil)
  ;; (define-key org-mode-map (kbd "C-<tab>") nil)
  ;; (define-key org-mode-map (kbd "C-S-<tab>") nil)
  ;; (define-key org-mode-map (kbd "<C-up>") nil)
  ;; (define-key org-mode-map (kbd "<C-down>") nil)
  (setq org-capture-templates
        '(
          ("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
           "* TODO %^{Description}\n%i%U\n%?%a")
          ("k" "Tickler" entry (file+headline "~/org/gtd.org" "Tickler")
           "* SOMEDAY %^{Description}\n:PROPERTIES:\n:CATEGORY:  %^{Category}\n:END:\n%i%U\n%?%a")
          ("f" "Fin" entry (file+headline  "~/org/gtd.org" "Tasks")
           "%[~/org/capture-template/fin.txt]")
          ("g" "Goal" entry (file+headline  "~/org/goals.org" "Tasks")
           "%[~/org/capture-template/goal.txt]")
          ("p" "POTD" entry (file+headline  "~/org/gtd.org" "POTD habit lead routine")
           "%[~/org/capture-template/potd.txt]")
          ("j" "Journal" entry (file+olp+datetree "~/org/journal.org")
           "* %U %? %i\n %a")
          ("w" "Weekly" entry (file+headline  "~/org/myweek.org" "Weekly Review" )
           "%[~/org/capture-template/weeklyreview.org]")
          ))
  
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
        (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DOING(D)" "REVIEW(r)" "DONE(d)")
                (sequence "WAIT(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")
                )))
  (setq org-todo-keyword-faces
        (quote (("TODO" :foreground "red" :weight bold)
                ("NEXT" :foreground "blue" :weight bold)
                ("DOING" :foreground "forest green" :weight bold)
                ("REVIEW" :foreground "forest green" :weight bold)
                ("DONE" :foreground "forest green" :weight bold)
                ("WAIT" :foreground "orange" :weight bold)
                ("HOLD" :foreground "magenta" :weight bold)
                ("CANCELLED" :foreground "forest green" :weight bold)
                )))
  
  
  ;; Agenda
  (setq org-agenda-window-setup 'current-window)
  (setq org-agenda-files (quote ("~/org")))
  ;; Use the current window for indirect buffer display
  (setq org-indirect-buffer-display 'current-window)
  ;; Show agenda in current window, keeping all other windows
  (setq org-agenda-window-setup 'current-window)
  ;; Do not dim blocked tasks
  (setq org-agenda-dim-blocked-tasks nil)
  ;; Compact the block agenda view
  (setq org-agenda-compact-blocks t)
  ;; Always follow
  (add-hook 'org-agenda-mode-hook 'org-agenda-follow-mode)
  ;; Run/highlight code using babel in org-mode
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((awk . t)
     (calc . t)
     (csharp . t)
     (ditaa . t)
     (dot . t)
     (groovy . t)
     (http . t)
     (java . t)
     (js . t)
     ;; (kotlin . t)
     (mongo . t)
     (perl . t)
     (plantuml . t)
     (python . t)
     (ruby . t)
     ;; (scala . t)
     (sed . t)
     ;; (sh . t)
     (sql . t)))
  ;; Syntax hilight in #+begin_src blocks
  (setq org-src-fontify-natively t)
  
  (defun my-org-confirm-babel-evaluate (lang body)
    (not (or (string= lang "awk")
             (string= lang "ditaa")
             (string= lang "dot")
             (string= lang "http")
             (string= lang "plantuml")
             (string= lang "sed")
             (string= lang "sql"))))
  (setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)
  (add-hook 'org-babel-after-execute-hook (lambda ()
                                            (condition-case nil
                                                (org-display-inline-images)
                                              (error nil)))
            'append)
  ;; http://orgmode.org/worg/org-contrib/babel/languages/ob-doc-ditaa.html
  (setq org-ditaa-jar-path (expand-file-name "~/.emacs.d/vendors/ditaa0_9.jar"))
  
  (setq org-plantuml-jar-path (expand-file-name "~/.emacs.d/vendors/plantuml.jar"))
  ;; Tag list
  (setq org-tag-alist (quote ((:startgroup)
                              ("POTD" . ?d)
                              ("POTW" . ?w)
                              ("POTM" . ?m)
                              ("NYR" . ?y)
                              (:endgroup)
                              ;; ("WAITING" . ?w)
                              ;; ("HOLD" . ?h)
                              ;; ("PERSONAL" . ?P)
                              ;; ("WORK" . ?W)
                              ;; ("ORG" . ?O)
                              ;; ("NORANG" . ?N)
                              ;; ("crypt" . ?E)
                              ;; ("NOTE" . ?n)
                              ;; ("CANCELLED" . ?c)
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
                ("p" "Next 7 Days Deadline"
                 (
                  (tags-todo "PROJECT")
                  )
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
  )
;; org-habit
(require 'org-habit)
(setq org-habit-preceding-days 7
      org-habit-following-days 1
      org-habit-graph-column 80
      org-habit-show-habits-only-for-today t
      org-habit-show-all-today t)
;; org-journal-dir
(use-package org-journal
  :config
  (setq org-journal-dir "~/journal")
  (setq org-journal-date-format "%a, %Y-%m-%d")
  (setq org-journal-time-format "%H:%M:%S ")
)
(use-package org-bullets
  :commands (org-bullets-mode)
  )
;; org-crypt
;; http://orgmode.org/worg/org-tutorials/encrypting-files.html
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
(use-package kanban)
(defun my/org-read-datetree-date (d)
  "Parse a time string D and return a date to pass to the datetree functions."
  (let ((dtmp (nthcdr 3 (parse-time-string d))))
    (list (cadr dtmp) (car dtmp) (caddr dtmp))))
(defun my/org-refile-to-archive-datetree ()
  "Refile an entry to a datetree under an archive."
  (interactive)
  (require 'org-datetree)
  (let ((datetree-date (my/org-read-datetree-date (org-read-date t nil))))
    (org-refile nil nil (list nil (buffer-file-name) nil
                              (save-excursion
                                (org-datetree-find-date-create datetree-date)))))
  (setq this-command 'my/org-refile-to-journal))

(require 'org-id)
(setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)
(defun eos/org-custom-id-get (&optional pom create prefix)
  "Get the CUSTOM_ID property of the entry at point-or-marker POM.
   If POM is nil, refer to the entry at point. If the entry does
   not have an CUSTOM_ID, the function returns nil. However, when
   CREATE is non nil, create a CUSTOM_ID if none is present
   already. PREFIX will be passed through to `org-id-new'. In any
   case, the CUSTOM_ID of the entry is returned."
  (interactive)
  (org-with-point-at pom
    (let ((id (org-entry-get nil "CUSTOM_ID")))
      (cond
       ((and id (stringp id) (string-match "\\S-" id))
        id)
       (create
        (setq id (org-id-new (concat prefix "cid")))
        (org-entry-put pom "CUSTOM_ID" id)
        (org-id-add-location id (buffer-file-name (buffer-base-buffer)))
        id)))))

(defun eos/org-add-ids-to-headlines-in-file ()
  "Add CUSTOM_ID properties to all headlines in the current
   file which do not already have one. Only adds ids if the
   `auto-id' option is set to `t' in the file somewhere. ie,
   #+OPTIONS: auto-id:t"
  (interactive)
  (save-excursion
    (widen)
    (goto-char (point-min))
    (when (re-search-forward "^#\\+OPTIONS:.*auto-id:t" (point-max) t)
      (org-map-entries (lambda () (eos/org-custom-id-get (point) 'create))))))

(add-hook 'org-capture-prepare-finalize-hook
         (lambda () (eos/org-custom-id-get (point) 'create)))

;; ;; automatically add ids to saved org-mode headlines
;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             (add-hook 'before-save-hook
;;                       (lambda ()
;;                         (when (and (eq major-mode 'org-mode)
;;                                    (eq buffer-read-only nil))
;;                           (eos/org-add-ids-to-headlines-in-file))))))

(provide 'init-org)
