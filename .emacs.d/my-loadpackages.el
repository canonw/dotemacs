;; ~/.emacs.d/my-loadpackages.el
;; loading package
(load "~/.emacs.d/my-packages.el")


;;;;
;;;;
;;; Dired Mode

;; Move deleted files to OS trash
(setq delete-by-moving-to-trash t)


;;;;
;;;;
;;; Smart tab mode

;; Specify smart tab mode to load automatically
(smart-tabs-insinuate 'c 'javascript)

(smart-tabs-advice js2-indent-line js2-basic-offset)


;;;;
;;;;
;;; Org Mode
(require 'org)
(setq org-agenda-files (list "~/org"
))

;; Make folding neat
(setq org-log-into-drawer t
      org-clock-into-drawer t)

;; Log TODO state change
(setq org-log-done t)

(add-hook 'org-mode-hook
           (lambda ()
           ;; Disable linum due to slowness
           (global-linum-mode 0)
            (linum-mode 0)
;;         ;;(flyspell-mode)
           ))
;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             (writegood-mode)))

;; Capture notes
;; (setq org-default-notes-file (concat org-directory "~/org/notes.org"))
;; (setq org-capture-templates
;;      '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
;;             "* TODO %?\n  %U\n  %i\n  %a")
;;        ("j" "Journal" entry (file+datetree "~/org/note/journal.org")
;;             "* %?\nEntered on %U\n  %i\n  %a")))

;; Capture templates for: TODO tasks, Notes, appointments,
;; phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/org/notes.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "respond" entry (file "~/org/refile.org")
               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("n" "note" entry (file "~/org/refile.org")
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("j" "Journal" entry (file+datetree "~/org/diary.org")
               "* %?\n%U\n" :clock-in t :clock-resume t)
              ("w" "org-protocol" entry (file "~/org/refile.org")
               "* TODO Review %c\n%U\n" :immediate-finish t)
              ("m" "Meeting" entry (file "~/org/refile.org")
               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ("p" "Phone call" entry (file "~/git/org/refile.org")
               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
              ("h" "Habit" entry (file "~/org/refile.org")
               "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"<%Y-%m-%d %a .+1d/3d>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))
'(org-refile-targets (quote (("gtd.org" :maxlevel . 1)
                              ("someday.org" :level . 2))))

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

(setq org-use-fast-todo-selection t)
(setq org-treat-S-cursor-todo-selection-as-state-change nil)

;; Agenda
;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)

;; Compact the block agenda view
(setq org-agenda-compact-blocks t)

;; Custom agenda command definitions
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

;; (setq org-agenda-custom-commands
;;       (quote (("N" "Notes" tags "NOTE"
;;                ((org-agenda-overriding-header "Notes")
;;                 (org-tags-match-list-sublevels t)))
;;               ("h" "Habits" tags-todo "STYLE=\"habit\""
;;                ((org-agenda-overriding-header "Habits")
;;                 (org-agenda-sorting-strategy
;;                  '(todo-state-down effort-up category-keep))))
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
;; Tag list
(setq org-tag-alist (quote ((:startgroup)
                            ("@errand" . ?e)
                            ("@office" . ?o)
                            ("@home" . ?H)
                            ("@farm" . ?f)
                            (:endgroup)
                            ("WAITING" . ?w)
                            ("HOLD" . ?h)
                            ("PERSONAL" . ?P)
                            ("WORK" . ?W)
                            ("FARM" . ?F)
                            ("ORG" . ?O)
                            ("NORANG" . ?N)
                            ("crypt" . ?E)
                            ("NOTE" . ?n)
                            ("CANCELLED" . ?c)
                            ("FLAGGED" . ??))))

; Allow setting single tags without the menu
(setq org-fast-tag-selection-single-key (quote expert))

; For tag searches ignore tasks with scheduled and deadline dates
(setq org-agenda-tags-todo-honor-ignore-options t)

;; Tags trigger state list
(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING") ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

;; Shortcut key
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cb" 'org-iswitchb)

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
;; Recentf
;; http://www.emacswiki.org/emacs/RecentFiles
(require 'recentf)
;; Enable menu
(recentf-mode t)
;; Maximum number of items
(setq recentf-max-menu-items 25)

(global-set-key "\C-cr" 'recentf-open-files)

;;;;
;;;;
;; Smex
;; (require 'smex)
;; (smex-initialize)

;;;;
;;;;
;; Ido
;; Enable auto suggestion
(ido-mode 1)
;; Enable flexible matching
(setq ido-enable-flex-matching t
      ;; Enable flex match in buffer and files
      ido-everywhere t
      ;; Display choices vertically 
      ido-separator "\n"
      )

;;;;
;;;;
;; whitespace-mode
;; (setq whitespace-style
;;      (quote (spaces tabs newline space-mark tab-mark newline-mark)))
(setq whitespace-display-mappings
      '(
        (space-mark 32 [183] [46]) ; 32 SPACE, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
        (newline-mark 10 [182 10]) ; 10 LINE FEED
        (tab-mark 9 [9655 9] [92 9]) ; 9 TAB, 9655 WHITE RIGHT-POINTING TRIANGLE 「▷」
        ))

;;;;
;;;;
;; evil-mode
(require 'evil-leader)
(global-evil-leader-mode)

(evil-leader/set-key
  "f" 'ido-find-file
  "b" 'switch-to-buffer
  "k" 'kill-buffer)

;; Set leader char
(evil-leader/set-leader ";")

(require 'evil)
(evil-mode t)

(require 'evil-surround)
(global-evil-surround-mode 1)

(require 'evil-numbers)
(define-key evil-normal-state-map (kbd "C-c +") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-c -") 'evil-numbers/dec-at-pt)

(require 'evil-exchange)
(evil-exchange-install)

;;;;
;;;;
;; ace-jump-mode
(require 'ace-jump-mode)

;; (define-key global-map (kbd "C-c SPC") 'ace-jump-word-mode)
;; (define-key global-map (kbd "C-u C-c SPC") 'ace-jump-word-mode)

(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;; Assign ace jump key in evil mode
(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)

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
;; auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")


;;;;
;;;;
;; js2-mode

;; Define js2-mode
(add-to-list 'auto-mode-alist (cons (rx ".js" eos) 'js2-mode))

;; (add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)

(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))


;;;;
;;;;
;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))

;; Associate engine
(setq web-mode-engines-alist '(("php" . "\\.phtml\\'")
			       ("blade" . "\\.blade\\."))
)


;;;;
;;;;
;;; magit
;; (require 'magit)
;; (define-key global-map (kbd "C-c m") 'magit-status)
;;

;; Use ido to read branches
(setq magit-completing-read-function 'magit-ido-completing-read)

(global-set-key (kbd "C-c g") 'magit-status)
