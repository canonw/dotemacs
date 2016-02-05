;;;; @see https://bitbucket.org/lyro/evil/issue/360/possible-evil-search-symbol-forward
;;;; evil 1.0.8 search word instead of symbol
;;(setq evil-symbol-word-search t)
;;;;;; load undo-tree and ert
;;;;(add-to-list 'load-path "~/.emacs.d/site-lisp/evil/lib")
;;
;;;; @see https://bitbucket.org/lyro/evil/issue/511/let-certain-minor-modes-key-bindings
;;(eval-after-load 'git-timemachine
;;  '(progn
;;     (evil-make-overriding-map git-timemachine-mode-map 'normal)
;;     ;; force update evil keymaps after git-timemachine-mode loaded
;;     (add-hook 'git-timemachine-mode-hook #'evil-normalize-keymaps)))
;;
;;(require 'evil)
;;
;;(autoload 'dictionary-new-search "dictionary" "" t nil)
;;
;;;; @see https://bitbucket.org/lyro/evil/issue/342/evil-default-cursor-setting-should-default
;;;; cursor is alway black because of evil
;;;; here is the workaround
;;(setq evil-default-cursor t)

;; enable evil-mode
(evil-mode 1)

(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))

;; {{@see https://github.com/timcharper/evil-surround
(require 'evil-surround)
(global-evil-surround-mode 1)
;; }}

;; ;; press ";" instead of ":"
;; (define-key evil-normal-state-map (kbd ";") 'evil-ex)

;; (autoload 'find-file-in-project "find-file-in-project" "" t)

;;(require 'evil-mark-replace)
;;
;;;; {{ define my own text objects, works on evil v1.0.9 using older method
;;;; @see http://stackoverflow.com/questions/18102004/emacs-evil-mode-how-to-create-a-new-text-object-to-select-words-with-any-non-sp
;;(defmacro define-and-bind-text-object (key start-regex end-regex)
;;  (let ((inner-name (make-symbol "inner-name"))
;;        (outer-name (make-symbol "outer-name")))
;;    `(progn
;;       (evil-define-text-object ,inner-name (count &optional beg end type)
;;         (evil-select-paren ,start-regex ,end-regex beg end type count nil))
;;       (evil-define-text-object ,outer-name (count &optional beg end type)
;;         (evil-select-paren ,start-regex ,end-regex beg end type count t))
;;       (define-key evil-inner-text-objects-map ,key (quote ,inner-name))
;;       (define-key evil-outer-text-objects-map ,key (quote ,outer-name)))))
;;
;;;; between dollar signs:
;;(define-and-bind-text-object "$" "\\$" "\\$")
;;;; between pipe characters:
;;(define-and-bind-text-object "|" "|" "|")
;;;; trimmed line
;;(define-and-bind-text-object "l" "^ *" " *$")
;;;; angular template
;;(define-and-bind-text-object "r" "\{\{" "\}\}")
;;;; }}
;;
;;;; {{ https://github.com/syl20bnr/evil-escape
;;(require 'evil-escape)
;;(setq-default evil-escape-delay 0.2)
;;(setq evil-escape-excluded-major-modes '(dired-mode))
;;(setq-default evil-escape-key-sequence "kj")
;;(evil-escape-mode 1)
;;;; }}
;;
;;;; Move back the cursor one position when exiting insert mode
;;(setq evil-move-cursor-back t)
;;
;;(defun toggle-org-or-message-mode ()
;;  (interactive)
;;  (if (eq major-mode 'message-mode)
;;    (org-mode)
;;    (if (eq major-mode 'org-mode) (message-mode))
;;    ))

(evil-set-initial-state 'calendar-mode 'emacs)
(evil-set-initial-state 'help-mode 'emacs)
;; (evil-set-initial-state 'org-mode 'emacs)
;;(loop for (mode . state) in
;;      '((minibuffer-inactive-mode . emacs)
;;        (ggtags-global-mode . emacs)
;;        (grep-mode . emacs)
;;        (Info-mode . emacs)
;;        (term-mode . emacs)
;;        (sdcv-mode . emacs)
;;        (anaconda-nav-mode . emacs)
;;        (log-edit-mode . emacs)
;;        (vc-log-edit-mode . emacs)
;;        (magit-log-edit-mode . emacs)
;;        (inf-ruby-mode . emacs)
;;        (direx:direx-mode . emacs)
;;        (yari-mode . emacs)
;;        (erc-mode . emacs)
;;        (w3m-mode . emacs)
;;        (gud-mode . emacs)
;;        (help-mode . emacs)
;;        (eshell-mode . emacs)
;;        (shell-mode . emacs)
;;        ;;(message-mode . emacs)
;;        (fundamental-mode . emacs)
;;        (weibo-timeline-mode . emacs)
;;        (weibo-post-mode . emacs)
;;        (sr-mode . emacs)
;;        (dired-mode . emacs)
;;        (compilation-mode . emacs)
;;        (speedbar-mode . emacs)
;;        (magit-commit-mode . normal)
;;        (magit-diff-mode . normal)
;;        (js2-error-buffer-mode . emacs)
;;        )
;;      do (evil-set-initial-state mode state))
;;
;;(evil-define-key 'motion magit-commit-mode-map
;;  (kbd "TAB") 'magit-toggle-section
;;  (kbd "RET") 'magit-visit-item
;;  (kbd "C-w") 'magit-copy-item-as-kill)
;;
;;(evil-define-key 'motion magit-diff-mode-map
;;  (kbd "TAB") 'magit-toggle-section
;;  (kbd "RET") 'magit-visit-item
;;  (kbd "C-w") 'magit-copy-item-as-kill)

;; (define-key evil-ex-completion-map (kbd "M-p") 'previous-complete-history-element)
;; (define-key evil-ex-completion-map (kbd "M-n") 'next-complete-history-element)

;; (define-key evil-normal-state-map "Y" (kbd "y$"))
;; (define-key evil-normal-state-map "+" 'evil-numbers/inc-at-pt)
;; (define-key evil-normal-state-map "-" 'evil-numbers/dec-at-pt)
;; (define-key evil-normal-state-map "go" 'goto-char)
;; (define-key evil-normal-state-map (kbd "M-y") 'browse-kill-ring)
;; (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
;; (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
;; 
;; (require 'evil-matchit)
;; (global-evil-matchit-mode 1)
;; 
;; ;; press ",xx" to expand region
;; ;; then press "z" to contract, "x" to expand
;; (eval-after-load "evil"
;;   '(setq expand-region-contract-fast-key "z"))
;; 
;; ;; I learn this trick from ReneFroger, need latest expand-region
;; ;; @see https://github.com/redguardtoo/evil-matchit/issues/38
;; (define-key evil-visual-state-map (kbd "v") 'er/expand-region)
;; (define-key evil-insert-state-map (kbd "C-e") 'move-end-of-line)
;; (define-key evil-insert-state-map (kbd "C-k") 'kill-line)
;; (define-key evil-insert-state-map (kbd "TAB") 'my-yas-expand)
;; (define-key evil-insert-state-map (kbd "M-j") 'my-yas-expand)
;; (define-key evil-emacs-state-map (kbd "M-j") 'my-yas-expand)
;; (global-set-key (kbd "C-r") 'undo-tree-redo)

;; Frequently used commands are listed here
(setq evil-leader/leader ";")
(global-evil-leader-mode)
(require 'evil-leader)

;; Remap org-mode meta keys for convenience
;; http://stackoverflow.com/questions/8483182/evil-mode-best-practice
;;(mapcar (lambda (state)
;;    (evil-declare-key state org-mode-map
;;      (kbd "M-l") 'org-metaright
;;      (kbd "M-h") 'org-metaleft
;;      (kbd "M-k") 'org-metaup
;;      (kbd "M-j") 'org-metadown
;;      (kbd "M-L") 'org-shiftmetaright
;;      (kbd "M-H") 'org-shiftmetaleft
;;      (kbd "M-K") 'org-shiftmetaup
;;      (kbd "M-J") 'org-shiftmetadown))
;;  '(normal insert))
;;
;;;; change mode-line color by evil state
;;(lexical-let ((default-color (cons (face-background 'mode-line)
;;                                   (face-foreground 'mode-line))))
;;  (add-hook 'post-command-hook
;;            (lambda ()
;;              (let ((color (cond ((minibufferp) default-color)
;;                                 ((evil-insert-state-p) '("#e80000" . "#ffffff"))
;;                                 ((evil-emacs-state-p)  '("#444488" . "#ffffff"))
;;                                 ((buffer-modified-p)   '("#006fa0" . "#ffffff"))
;;                                 (t default-color))))
;;                (set-face-background 'mode-line (car color))
;;                (set-face-foreground 'mode-line (cdr color))))))
;;
;;(require 'evil-exchange)
;;(evil-exchange-install)
;;
;;(require 'evil-nerd-commenter)
;;(evilnc-default-hotkeys)

(provide 'init-evil)
