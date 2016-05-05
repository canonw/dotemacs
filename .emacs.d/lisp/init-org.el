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




;; 
;; ;; Capture templates for: TODO tasks, Notes, appointments,
;; ;; phone calls, meetings, and org-protocol
;; (setq org-capture-templates
;;       (quote (("t" "todo" entry (file "~/org/notes.org")
;;                "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
;;               ("r" "respond" entry (file "~/org/refile.org")
;;                "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
;;               ("n" "note" entry (file "~/org/refile.org")
;;                "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
;;               ("j" "Journal" entry (file+datetree "~/org/diary.org")
;;                "* %?\n%U\n" :clock-in t :clock-resume t)
;;               ("w" "org-protocol" entry (file "~/org/refile.org")
;;                "* TODO Review %c\n%U\n" :immediate-finish t)
;;               ("m" "Meeting" entry (file "~/org/refile.org")
;;                "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
;;               ("p" "Phone call" entry (file "~/git/org/refile.org")
;;                "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
;;               ("h" "Habit" entry (file "~/org/refile.org")
;;                "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"<%Y-%m-%d %a .+1d/3d>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))
;; '(org-refile-targets (quote (("gtd.org" :maxlevel . 1)
;;                               ("someday.org" :level . 2))))
;; 
;; ;;;; Use IDO for both buffer and file completion and ido-everywhere to t
;; ;; (setq org-completion-use-ido t)
;; 
;; ;; Agenda
;; 
;; ;; Custom agenda command definitions
;; ;; Reference:
;; ;; http://orgmode.org/worg/org-tutorials/org-custom-agenda-commands.html
;; ;; http://orgmode.org/manual/Matching-tags-and-properties.html
;; ;; Change start date
;; ;; http://emacs.stackexchange.com/questions/13075/agenda-span-of-last-7-days
;; (setq org-agenda-custom-commands
;;       (quote (("N" "Notes" tags "NOTE"
;;                ((org-agenda-overriding-header "Notes")
;;                 (org-tags-match-list-sublevels t)))
;;               ("D" "Daily Action List"
;;                ((agenda "" ((org-agenda-ndays 1)
;;                        (org-agenda-sorting-strategy
;;                         (quote ((agenda time-up priority-down tag-up) )))
;;                        (org-deadline-warning-days 0)))))
;;               ("h" "Habits" tags-todo "STYLE=\"habit\""
;;                ((org-agenda-overriding-header "Habits")
;;                 (org-agenda-sorting-strategy
;;                  '(todo-state-down effort-up category-keep))))
;;               ("g" "Planning Agenda"
;;                (
;;                 (tags-todo "+NYR")
;;                 (tags-todo "BURN-POTW-POTD")
;;                 (tags-todo "+POTD")
;;                 (tags-todo "+POTW-POTD") ;; Unplanned plan of the week
;;                 (tags-todo "+TODO=\"NEXT\"-POTW-POTD-BURN|+TODO=\"WAITING\"") ;; Any NEXT action not part of planned
;;                 (tags-todo "STYLE=\"habit\"")
;;                )
;;                 nil                      ;; i.e., no local settings
;;                 ("~/next-actions.html") ;; exports block to this file with C-c a e; TODO
;;                )
;;                ("w" "Next 7 Days Deadline"
;;                 ((agenda "" ((org-agenda-span 8)))
;;                  ;; type "l" in the agenda to review logged items 
;;                  ;; (stuck "") ;; review stuck projects as designated by org-stuck-projects
;;                  ;; ..other commands here
;;                  )
;;                 )
;;               (" " "Agenda"
;;                ((agenda "" nil)
;;                 (tags "REFILE"
;;                       ((org-agenda-overriding-header "Tasks to Refile")
;;                        (org-tags-match-list-sublevels nil)))
;;                 (tags-todo "-CANCELLED/!"
;;                            ((org-agenda-overriding-header "Stuck Projects")
;;                             (org-agenda-skip-function 'bh/skip-non-stuck-projects)
;;                             (org-agenda-sorting-strategy
;;                              '(category-keep))))
;;                 (tags-todo "-HOLD-CANCELLED/!"
;;                            ((org-agenda-overriding-header "Projects")
;;                             (org-agenda-skip-function 'bh/skip-non-projects)
;;                             (org-tags-match-list-sublevels 'indented)
;;                             (org-agenda-sorting-strategy
;;                              '(category-keep))))
;;                 (tags-todo "-CANCELLED/!NEXT"
;;                            ((org-agenda-overriding-header (concat "Project Next Tasks"
;;                                                                   (if bh/hide-scheduled-and-waiting-next-tasks
;;                                                                       ""
;;                                                                     " (including WAITING and SCHEDULED tasks)")))
;;                             (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
;;                             (org-tags-match-list-sublevels t)
;;                             (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-sorting-strategy
;;                              '(todo-state-down effort-up category-keep))))
;;                 (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
;;                            ((org-agenda-overriding-header (concat "Project Subtasks"
;;                                                                   (if bh/hide-scheduled-and-waiting-next-tasks
;;                                                                       ""
;;                                                                     " (including WAITING and SCHEDULED tasks)")))
;;                             (org-agenda-skip-function 'bh/skip-non-project-tasks)
;;                             (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-sorting-strategy
;;                              '(category-keep))))
;;                 (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
;;                            ((org-agenda-overriding-header (concat "Standalone Tasks"
;;                                                                   (if bh/hide-scheduled-and-waiting-next-tasks
;;                                                                       ""
;;                                                                     " (including WAITING and SCHEDULED tasks)")))
;;                             (org-agenda-skip-function 'bh/skip-project-tasks)
;;                             (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-sorting-strategy
;;                              '(category-keep))))
;;                 (tags-todo "-CANCELLED+WAITING|HOLD/!"
;;                            ((org-agenda-overriding-header (concat "Waiting and Postponed Tasks"
;;                                                                   (if bh/hide-scheduled-and-waiting-next-tasks
;;                                                                       ""
;;                                                                     " (including WAITING and SCHEDULED tasks)")))
;;                             (org-agenda-skip-function 'bh/skip-non-tasks)
;;                             (org-tags-match-list-sublevels nil)
;;                             (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
;;                             (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)))
;;                 (tags "-REFILE/"
;;                       ((org-agenda-overriding-header "Tasks to Archive")
;;                        (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
;;                        (org-tags-match-list-sublevels nil))))
;;                nil))))
;; 
;; ; Allow setting single tags without the menu
;; (setq org-fast-tag-selection-single-key (quote expert))
;; 
;; ; For tag searches ignore tasks with scheduled and deadline dates
;; (setq org-agenda-tags-todo-honor-ignore-options t)
;; 

;; ;;; ical
;; (setq org-combined-agenda-icalendar-file "~/org.ics")
;; (setq org-icalendar-categories (quote (all-tags category todo-state)))
;; (setq org-icalendar-include-body 1000)
;; (setq org-icalendar-include-sexps nil)
;; (setq org-icalendar-include-todo nil)
;; (setq org-icalendar-store-UID t)
;; (setq org-icalendar-timezone "America/Los_Angeles")
;; (setq org-icalendar-include-body nil)
;; ; (setq org-icalendar-exclude-tags (quote (DONE)))
;; (setq org-icalendar-use-deadline (quote (event-if-not-todo
;; event-if-todo)))
;; (setq org-icalendar-use-scheduled (quote (event-if-not-todo
;; event-if-todo)))
;; 
;; 
;; ;;; org-babel
;; ;; http://orgmode.org/worg/org-contrib/babel/
;; (require 'ob)
;; 
;; 
;; 
;; ;; (add-to-list 'org-src-lang-modes (quote ("dot". graphviz-dot)))
;; ;; (add-to-list 'org-src-lang-modes (quote ("plantuml" . fundamental)))
;; ;;  (add-to-list 'org-babel-tangle-lang-exts '("clojure" . "clj"))
;; 
;; 
;; (setq org-src-fontify-natively t
;;       org-confirm-babel-evaluate nil)
;; 
;; (defun bh/find-project-task ()
;;   "Move point to the parent (project) task if any"
;;   (save-restriction
;;     (widen)
;;     (let ((parent-task (save-excursion (org-back-to-heading 'invisible-ok) (point))))
;;       (while (org-up-heading-safe)
;;         (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
;;           (setq parent-task (point))))
;;       (goto-char parent-task)
;;       parent-task)))
;; 
;; (defun bh/is-project-p ()
;;   "Any task with a todo keyword subtask"
;;   (save-restriction
;;     (widen)
;;     (let ((has-subtask)
;;           (subtree-end (save-excursion (org-end-of-subtree t)))
;;           (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
;;       (save-excursion
;;         (forward-line 1)
;;         (while (and (not has-subtask)
;;                     (< (point) subtree-end)
;;                     (re-search-forward "^\*+ " subtree-end t))
;;           (when (member (org-get-todo-state) org-todo-keywords-1)
;;             (setq has-subtask t))))
;;       (and is-a-task has-subtask))))
;; 
;; (defun bh/is-project-subtree-p ()
;;   "Any task with a todo keyword that is in a project subtree.
;; Callers of this function already widen the buffer view."
;;   (let ((task (save-excursion (org-back-to-heading 'invisible-ok)
;;                               (point))))
;;     (save-excursion
;;       (bh/find-project-task)
;;       (if (equal (point) task)
;;           nil
;;         t))))
;; 
;; (defun bh/is-task-p ()
;;   "Any task with a todo keyword and no subtask"
;;   (save-restriction
;;     (widen)
;;     (let ((has-subtask)
;;           (subtree-end (save-excursion (org-end-of-subtree t)))
;;           (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
;;       (save-excursion
;;         (forward-line 1)
;;         (while (and (not has-subtask)
;;                     (< (point) subtree-end)
;;                     (re-search-forward "^\*+ " subtree-end t))
;;           (when (member (org-get-todo-state) org-todo-keywords-1)
;;             (setq has-subtask t))))
;;       (and is-a-task (not has-subtask)))))
;; 
;; (defun bh/is-subproject-p ()
;;   "Any task which is a subtask of another project"
;;   (let ((is-subproject)
;;         (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
;;     (save-excursion
;;       (while (and (not is-subproject) (org-up-heading-safe))
;;         (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
;;           (setq is-subproject t))))
;;     (and is-a-task is-subproject)))
;; 
;; (defun bh/list-sublevels-for-projects-indented ()
;;   "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
;;   This is normally used by skipping functions where this variable is already local to the agenda."
;;   (if (marker-buffer org-agenda-restrict-begin)
;;       (setq org-tags-match-list-sublevels 'indented)
;;     (setq org-tags-match-list-sublevels nil))
;;   nil)
;; 
;; (defun bh/list-sublevels-for-projects ()
;;   "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
;;   This is normally used by skipping functions where this variable is already local to the agenda."
;;   (if (marker-buffer org-agenda-restrict-begin)
;;       (setq org-tags-match-list-sublevels t)
;;     (setq org-tags-match-list-sublevels nil))
;;   nil)
;; 
;; (defvar bh/hide-scheduled-and-waiting-next-tasks t)
;; 
;; (defun bh/toggle-next-task-display ()
;;   (interactive)
;;   (setq bh/hide-scheduled-and-waiting-next-tasks (not bh/hide-scheduled-and-waiting-next-tasks))
;;   (when  (equal major-mode 'org-agenda-mode)
;;     (org-agenda-redo))
;;   (message "%s WAITING and SCHEDULED NEXT Tasks" (if bh/hide-scheduled-and-waiting-next-tasks "Hide" "Show")))
;; 
;; (defun bh/skip-stuck-projects ()
;;   "Skip trees that are not stuck projects"
;;   (save-restriction
;;     (widen)
;;     (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
;;       (if (bh/is-project-p)
;;           (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
;;                  (has-next ))
;;             (save-excursion
;;               (forward-line 1)
;;               (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
;;                 (unless (member "WAITING" (org-get-tags-at))
;;                   (setq has-next t))))
;;             (if has-next
;;                 nil
;;               next-headline)) ; a stuck project, has subtasks but no next task
;;         nil))))
;; 
;; (defun bh/skip-non-stuck-projects ()
;;   "Skip trees that are not stuck projects"
;;   ;; (bh/list-sublevels-for-projects-indented)
;;   (save-restriction
;;     (widen)
;;     (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
;;       (if (bh/is-project-p)
;;           (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
;;                  (has-next ))
;;             (save-excursion
;;               (forward-line 1)
;;               (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
;;                 (unless (member "WAITING" (org-get-tags-at))
;;                   (setq has-next t))))
;;             (if has-next
;;                 next-headline
;;               nil)) ; a stuck project, has subtasks but no next task
;;         next-headline))))
;; 
;; (defun bh/skip-non-projects ()
;;   "Skip trees that are not projects"
;;   ;; (bh/list-sublevels-for-projects-indented)
;;   (if (save-excursion (bh/skip-non-stuck-projects))
;;       (save-restriction
;;         (widen)
;;         (let ((subtree-end (save-excursion (org-end-of-subtree t))))
;;           (cond
;;            ((bh/is-project-p)
;;             nil)
;;            ((and (bh/is-project-subtree-p) (not (bh/is-task-p)))
;;             nil)
;;            (t
;;             subtree-end))))
;;     (save-excursion (org-end-of-subtree t))))
;; 
;; (defun bh/skip-project-trees-and-habits ()
;;   "Skip trees that are projects"
;;   (save-restriction
;;     (widen)
;;     (let ((subtree-end (save-excursion (org-end-of-subtree t))))
;;       (cond
;;        ((bh/is-project-p)
;;         subtree-end)
;;        ((org-is-habit-p)
;;         subtree-end)
;;        (t
;;         nil)))))
;; 
;; (defun bh/skip-projects-and-habits-and-single-tasks ()
;;   "Skip trees that are projects, tasks that are habits, single non-project tasks"
;;   (save-restriction
;;     (widen)
;;     (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
;;       (cond
;;        ((org-is-habit-p)
;;         next-headline)
;;        ((and bh/hide-scheduled-and-waiting-next-tasks
;;              (member "WAITING" (org-get-tags-at)))
;;         next-headline)
;;        ((bh/is-project-p)
;;         next-headline)
;;        ((and (bh/is-task-p) (not (bh/is-project-subtree-p)))
;;         next-headline)
;;        (t
;;         nil)))))
;; 
;; (defun bh/skip-project-tasks-maybe ()
;;   "Show tasks related to the current restriction.
;; When restricted to a project, skip project and sub project tasks, habits, NEXT tasks, and loose tasks.
;; When not restricted, skip project and sub-project tasks, habits, and project related tasks."
;;   (save-restriction
;;     (widen)
;;     (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
;;            (next-headline (save-excursion (or (outline-next-heading) (point-max))))
;;            (limit-to-project (marker-buffer org-agenda-restrict-begin)))
;;       (cond
;;        ((bh/is-project-p)
;;         next-headline)
;;        ((org-is-habit-p)
;;         subtree-end)
;;        ((and (not limit-to-project)
;;              (bh/is-project-subtree-p))
;;         subtree-end)
;;        ((and limit-to-project
;;              (bh/is-project-subtree-p)
;;              (member (org-get-todo-state) (list "NEXT")))
;;         subtree-end)
;;        (t
;;         nil)))))
;; 
;; (defun bh/skip-project-tasks ()
;;   "Show non-project tasks.
;; Skip project and sub-project tasks, habits, and project related tasks."
;;   (save-restriction
;;     (widen)
;;     (let* ((subtree-end (save-excursion (org-end-of-subtree t))))
;;       (cond
;;        ((bh/is-project-p)
;;         subtree-end)
;;        ((org-is-habit-p)
;;         subtree-end)
;;        ((bh/is-project-subtree-p)
;;         subtree-end)
;;        (t
;;         nil)))))
;; 
;; (defun bh/skip-non-project-tasks ()
;;   "Show project tasks.
;; Skip project and sub-project tasks, habits, and loose non-project tasks."
;;   (save-restriction
;;     (widen)
;;     (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
;;            (next-headline (save-excursion (or (outline-next-heading) (point-max)))))
;;       (cond
;;        ((bh/is-project-p)
;;         next-headline)
;;        ((org-is-habit-p)
;;         subtree-end)
;;        ((and (bh/is-project-subtree-p)
;;              (member (org-get-todo-state) (list "NEXT")))
;;         subtree-end)
;;        ((not (bh/is-project-subtree-p))
;;         subtree-end)
;;        (t
;;         nil)))))
;; 
;; (defun bh/skip-projects-and-habits ()
;;   "Skip trees that are projects and tasks that are habits"
;;   (save-restriction
;;     (widen)
;;     (let ((subtree-end (save-excursion (org-end-of-subtree t))))
;;       (cond
;;        ((bh/is-project-p)
;;         subtree-end)
;;        ((org-is-habit-p)
;;         subtree-end)
;;        (t
;;         nil)))))
;; 
;; (defun bh/skip-non-subprojects ()
;;   "Skip trees that are not projects"
;;   (let ((next-headline (save-excursion (outline-next-heading))))
;;     (if (bh/is-subproject-p)
;;         nil
;;       next-headline)))

(provide 'init-org)
