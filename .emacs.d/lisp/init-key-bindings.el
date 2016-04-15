;; Centralize key binding remap in one place

;; expand-region
;; http://blog.binchen.org/posts/how-to-use-expand-region-efficiently.html
(define-key evil-normal-state-map (kbd "+") 'er/expand-region)
(define-key evil-visual-state-map (kbd "+") 'er/expand-region)
(define-key evil-visual-state-map (kbd "_") 'er/contract-region)

(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-+") 'er/contract-region)

;;
;; avy
(define-key global-map (kbd "C-c SPC") 'avy-goto-char)


;;
;; ace-window
; (global-set-key (kbd "M-p") 'ace-window)
;
; (defvar aw-dispatch-alist
; '((?x aw-delete-window " Ace - Delete Window")
;     (?m aw-swap-window " Ace - Swap Window")
;     (?n aw-flip-window)
;     (?v aw-split-window-vert " Ace - Split Vert Window")
;     (?b aw-split-window-horz " Ace - Split Horz Window")
;     (?i delete-other-windows " Ace - Maximize Window")
;     (?o delete-other-windows))
; "List of actions for `aw-dispatch-default'.")

;;
;; evil-leader
(evil-leader/set-key
  "jC" 'avy-goto-char
  "jci" 'avy-goto-char-in-line
  "j2" 'avy-goto-char-2 ; search two consecutive characters
  "jl" 'avy-goto-line
  "jw" 'avy-goto-word-1
  "js" 'avy-goto-subword-1
  "aw" 'ace-window ; for frame/windows switching
  "rf" 'recentf-open-files
;;  "as" 'ack-same
;;  "ac" 'ack
;;  "aa" 'ack-find-same-file
;;  "af" 'ack-find-file
;;  "bf" 'beginning-of-defun
;;  "bu" 'backward-up-list
;;  "bb" '(lambda () (interactive) (switch-to-buffer nil))
;;  "ef" 'end-of-defun
;;  "db" 'sdcv-search-pointer ; in buffer
;;  "dt" 'sdcv-search-input+ ;; in tip
;;  "dd" '(lambda ()
;;          (interactive)
;;          (dictionary-new-search (cons (if (region-active-p)
;;                                           (buffer-substring-no-properties (region-beginning) (region-end))
;;                                         (thing-at-point 'symbol)) dictionary-default-dictionary)))
;;  "mf" 'mark-defun
;;  "em" 'erase-message-buffer
;;  "eb" 'eval-buffer
;;  "sd" 'sudo-edit
;;  "sr" 'evil-surround-region
;;  "sc" 'shell-command
;;  "spt" 'sr-speedbar-toggle
;;  "spr" 'sr-speedbar-refresh-toggle
;;  "ee" 'eval-expression
;;  "cx" 'copy-to-x-clipboard
;;  "cy" 'strip-convert-lines-into-one-big-string
;;  "cff" 'current-font-face
;;  "fl" 'cp-filename-line-number-of-current-buffer
;;  "fn" 'cp-filename-of-current-buffer
;;  "fp" 'cp-fullpath-of-current-buffer
;;  "dj" 'dired-jump ;; open the dired from current file
;;  "ff" 'toggle-full-window ;; I use WIN+F in i3
;;  "ip" 'find-file-in-project
;;  "tm" 'get-term
;;  "tff" 'toggle-frame-fullscreen
;;  "tfm" 'toggle-frame-maximized
;;  "px" 'paste-from-x-clipboard
;;  ;; "ci" 'evilnc-comment-or-uncomment-lines
;;  ;; "cl" 'evilnc-comment-or-uncomment-to-the-line
;;  ;; "cc" 'evilnc-copy-and-comment-lines
;;  ;; "cp" 'evilnc-comment-or-uncomment-paragraphs
;;  "epy" 'emmet-expand-yas
;;  "epl" 'emmet-expand-line
;;  "rd" 'evil-mark-replace-in-defun
;;  "rb" 'evil-mark-replace-in-buffer
;;  "tt" 'evil-mark-tag-selected-region ;; recommended
;;  "rt" 'evil-mark-replace-in-tagged-region ;; recommended
;;  "yy" 'cb-switch-between-controller-and-view
;;  "tua" 'artbollocks-mode
;;  "yu" 'cb-get-url-from-controller
;;  "ht" 'helm-etags-select ;; better than find-tag (C-])
;;  "hm" 'helm-bookmarks
;;  "hb" 'helm-back-to-last-point
;;  "hh" 'browse-kill-ring
;;  "cg" 'helm-ls-git-ls
;;  "ud" '(lambda ()(interactive)
;;          (gud-gdb (concat "gdb --fullname \"" (cppcm-get-exe-path-current-buffer) "\"")))
;;  "uk" 'gud-kill-yes
;;  "ur" 'gud-remove
;;  "ub" 'gud-break
;;  "uu" 'gud-run
;;  "up" 'gud-print
;;  "ue" 'gud-cls
;;  "un" 'gud-next
;;  "us" 'gud-step
;;  "ui" 'gud-stepi
;;  "uc" 'gud-cont
;;  "uf" 'gud-finish
;;  "W" 'save-some-buffers
;;  "K" 'kill-buffer-and-window ;; "k" is preserved to replace "C-g"
;;  "it" 'issue-tracker-increment-issue-id-under-cursor
;;  "lh" 'highlight-symbol-at-point
;;  "ln" 'highlight-symbol-next
;;  "lp" 'highlight-symbol-prev
;;  "lq" 'highlight-symbol-query-replace
;;  "bm" 'pomodoro-start ;; beat myself
;;  "im" 'helm-imenu
;;  "ii" 'ido-imenu
;;  "ij" 'rimenu-jump
;;  "." 'evil-ex
;;  ;; @see https://github.com/pidu/git-timemachine
;;  ;; p: previous; n: next; w:hash; W:complete hash; g:nth version; q:quit
;;  "gm" 'git-timemachine-toggle
;;  "gn" 'git-timemachine-show-next-revision
;;  "gp" 'git-timemachine-show-previous-revision
;;  "gw" 'git-timemachine-kill-abbreviated-revision
;;  "gW" 'git-timemachine-kill-revision
;;  "gg" 'git-timemachine-show-nth-revision
;;  "gq" 'git-timemachine-quit
;;  ;; toggle overview,  @see http://emacs.wordpress.com/2007/01/16/quick-and-dirty-code-folding/
;;  "ov" '(lambda () (interactive) (set-selective-display (if selective-display nil 1)))
;;  "or" 'open-readme-in-git-root-directory
;;  "mq" '(lambda () (interactive) (man (concat "-k " (thing-at-point 'symbol))))
;;  "mgh" '(lambda () (interactive) (magit-show-commit "HEAD"))
;;  "sg" 'w3m-google-by-filetype
;;  "sq" 'w3m-stackoverflow-search
;;  "sj" 'w3m-search-js-api-mdn
;;  "sh" 'w3mext-hacker-search ; code search in all engines with firefox
;;  "gss" 'git-gutter:set-start-revision
;;  "gsh" '(lambda () (interactive) (git-gutter:set-start-revision "HEAD^")
;;           (message "git-gutter:set-start-revision HEAD^"))
;;  "gsr" '(lambda () (interactive) (git-gutter:set-start-revision nil)
;;           (message "git-gutter reset")) ;; reset
;;  "hr" 'helm-recentf
;;  "rr" 'steve-ido-choose-from-recentf ;; more quick than helm
;;  "di" 'evilmi-delete-items
;;  "si" 'evilmi-select-items
;;  "jb" 'js-beautify
;;  "jpp" 'jsons-print-path
;;  "se" 'string-edit-at-point
;;  "xe" 'eval-last-sexp
;;  "x0" 'delete-window
;;  "x1" 'delete-other-windows
;;  "x2" '(lambda () (interactive) (if *emacs23* (split-window-vertically) (split-window-right)))
;;  "x3" '(lambda () (interactive) (if *emacs23* (split-window-horizontally) (split-window-below)))
;;  "xr" 'rotate-windows
;;  "xt" 'toggle-window-split
;;  "xu" 'winner-undo
;;  "to" 'toggle-web-js-offset
;;  "cam" 'org-tags-view ;; "C-c a m" search items in org-file-apps by tag
;;  "cf" 'helm-for-files ;; "C-c f"
;;  "sl" 'sort-lines
;;  "ulr" 'uniquify-all-lines-region
;;  "ulb" 'uniquify-all-lines-buffer
;;  "ls" 'package-list-packages
;;  "lo" 'moz-console-log-var
;;  "lj" 'moz-load-js-file-and-send-it
;;  "lk" 'latest-kill-to-clipboard
;;  "mr" 'moz-console-clear
;;  "rnr" 'rinari-web-server-restart
;;  "rnc" 'rinari-find-controller
;;  "rnv" 'rinari-find-view
;;  "rna" 'rinari-find-application
;;  "rnk" 'rinari-rake
;;  "rnm" 'rinari-find-model
;;  "rnl" 'rinari-find-log
;;  "rno" 'rinari-console
;;  "rnt" 'rinari-find-test
;;  "ws" 'w3mext-hacker-search
;;  "ss" 'swiper ; http://oremacs.com/2015/03/25/swiper-0.2.0/ for guide
;;  "st" '(lambda () (interactive)
;;          (swiper (if (region-active-p)
;;                    (buffer-substring-no-properties (region-beginning) (region-end))
;;                    (thing-at-point 'symbol))))
;;  "hst" 'hs-toggle-fold
;;  "hsa" 'hs-toggle-fold-all
;;  "hsh" 'hs-hide-block
;;  "hss" 'hs-show-block
;;  "hd" 'describe-function
;;  "hf" 'find-function
;;  "hk" 'describe-key
;;  "hv" 'describe-variable
;;  "gt" 'ggtags-find-tag-dwim
;;  "gr" 'ggtags-find-reference
;;  "fb" 'flyspell-buffer
;;  "fe" 'flyspell-goto-next-error
;;  "fa" 'flyspell-auto-correct-word
;;  "pe" 'flymake-goto-prev-error
;;  "ne" 'flymake-goto-next-error
;;  "fw" 'ispell-word
;;  "bc" '(lambda () (interactive) (wxhelp-browse-class-or-api (thing-at-point 'symbol)))
;;  "ma" 'mc/mark-all-like-this-in-defun
;;  "mw" 'mc/mark-all-words-like-this-in-defun
;;  "ms" 'mc/mark-all-symbols-like-this-in-defun
;;  ;; recommended in html
;;  "md" 'mc/mark-all-like-this-dwim
;;  "oc" 'occur
;;  "om" 'toggle-org-or-message-mode
;;  "ops" 'my-org2blog-post-subtree
;;  "ut" 'undo-tree-visualize
;;  "al" 'align-regexp
;;  "ww" 'save-buffer
;;  "bk" 'buf-move-up
;;  "bj" 'buf-move-down
;;  "bh" 'buf-move-left
;;  "bl" 'buf-move-right
;;  "so" 'sos
;;  "0" 'select-window-0
;;  "1" 'select-window-1
;;  "2" 'select-window-2
;;  "3" 'select-window-3
;;  "4" 'select-window-4
;;  "5" 'select-window-5
;;  "6" 'select-window-6
;;  "7" 'select-window-7
;;  "8" 'select-window-8
;;  "9" 'select-window-9
;;  "xm" 'smex
;;  "mx" 'helm-M-x
;;  "xx" 'er/expand-region
;;  "xf" 'ido-find-file
;;  "xb" 'ido-switch-buffer
;;  "xc" 'save-buffers-kill-terminal
;;  "xo" 'helm-find-files
;;  "ri" '(lambda () (interactive) (require 'helm) (yari-helm))
;;  "vv" 'scroll-other-window
;;  "vu" '(lambda () (interactive) (scroll-other-window '-))
;;  "vr" 'vr/replace
;;  "vq" 'vr/query-replace
;;  "vm" 'vr/mc-mark
;;  "js" 'w3mext-search-js-api-mdn
;;  "jde" 'js2-display-error-list
;;  "jte" 'js2-mode-toggle-element
;;  "jtf" 'js2-mode-toggle-hide-functions
;;  "xh" 'mark-whole-buffer
;;  "xk" 'ido-kill-buffer
;;  "xs" 'save-buffer
;;  "xz" 'suspend-frame
;;  "xvv" 'vc-next-action
;;  "xva" 'git-add-current-file
;;  "xvp" 'git-push-remote-origin
;;  "xvu" 'git-add-option-update
;;  "xvg" 'vc-annotate
;;  "xv=" 'git-gutter:popup-hunk
;;  "ps" 'my-goto-previous-section
;;  "ns" 'my-goto-next-section
;;  "pp" 'my-goto-previous-hunk
;;  "nn" 'my-goto-next-hunk
;;  "xvs" 'git-gutter:stage-hunk
;;  "xvr" 'git-gutter:revert-hunk
;;  "xvl" 'vc-print-log
;;  "xvb" 'git-messenger:popup-message
;;  "xnn" 'narrow-or-widen-dwim
;;  "xnw" 'widen
;;  "xnd" 'narrow-to-defun
;;  "xnr" 'narrow-to-region
;;  "ycr" (lambda ()
;;          (interactive)
;;          (unless (featurep 'yasnippet) (require 'yasnippet))
;;          (yas-compile-directory (file-truename "~/.emacs.d/snippets"))
;;          (yas-reload-all))
;;  "zc" 'wg-create-workgroup
;;  "zk" 'wg-kill-workgroup
;;  "zv" '(lambda (wg)
;;          (interactive (list (progn (wg-find-session-file wg-default-session-file)
;;                                    (wg-read-workgroup-name))))
;;          (wg-switch-to-workgroup wg))
;;  "zj" '(lambda (index)
;;          (interactive (list (progn (wg-find-session-file wg-default-session-file)
;;                                    (wg-read-workgroup-index))))
;;          (wg-switch-to-workgroup-at-index index))
;;  "zs" '(lambda () (interactive)  (wg-save-session t))
;;  "zb" 'wg-switch-to-buffer
;;  "zwr" 'wg-redo-wconfig-change
;;  "zws" 'wg-save-wconfig
;;  "wf" 'popup-which-function
)


;; Remap org-mode meta keys for convenience
(evil-declare-key 'normal org-mode-map
    "gh" 'outline-up-heading
    "gl" 'outline-next-visible-heading
    "H" 'org-beginning-of-line ; smarter behaviour on headlines etc.
    "L" 'org-end-of-line ; smarter behaviour on headlines etc.
    "$" 'org-end-of-line ; smarter behaviour on headlines etc.
    "^" 'org-beginning-of-line ; ditto
    "-" 'org-ctrl-c-minus ; change bullet style
    "<" 'org-metaleft ; out-dent
    ">" 'org-metaright ; indent
    (kbd "TAB") 'org-cycle)

;; Remap org-mode meta keys for convenience
(evil-declare-key 'normal org-mode-map
    "gh" 'outline-up-heading
    "gl" 'outline-next-visible-heading
    "H" 'org-beginning-of-line ; smarter behaviour on headlines etc.
    "L" 'org-end-of-line ; smarter behaviour on headlines etc.
    "$" 'org-end-of-line ; smarter behaviour on headlines etc.
    "^" 'org-beginning-of-line ; ditto
    "-" 'org-ctrl-c-minus ; change bullet style
    "<" 'org-metaleft ; out-dent
    ">" 'org-metaright ; indent
    (kbd "TAB") 'org-cycle)


;;
;; flyspell

;; you can also use "M-x ispell-word" or hotkey "M-$". It pop up a multiple choice
;; @see http://frequal.com/Perspectives/EmacsTip03-FlyspellAutoCorrectWord.html
(global-set-key (kbd "C-c s") 'flyspell-auto-correct-word)

;;
;; helm
;; (global-set-key (kbd "C-c y") 'helm-c-yas-complete)
(global-set-key (kbd "C-x C-o") 'ffap)

(global-set-key (kbd "M-x")                          'undefined)
(global-set-key (kbd "M-x")                          'helm-M-x)
(global-set-key (kbd "M-y")                          'helm-show-kill-ring)
(global-set-key (kbd "C-c f")                        'helm-recentf)
;;(global-set-key (kbd "C-x b")                        'helm-buffers-list)
(global-set-key (kbd "C-x b")                        'helm-mini)
(global-set-key (kbd "C-x C-f")                      'helm-find-files)
;;(global-set-key (kbd "C-c <SPC>")                    'helm-all-mark-rings)
(global-set-key (kbd "C-x r b")                      'helm-filtered-bookmarks)
(global-set-key (kbd "C-h r")                        'helm-info-emacs)
(global-set-key (kbd "C-:")                          'helm-eval-expression-with-eldoc)
(global-set-key (kbd "C-,")                          'helm-calcul-expression)
(global-set-key (kbd "C-h i")                        'helm-info-at-point)
(global-set-key (kbd "C-x C-d")                      'helm-browse-project)
;; (global-set-key (kbd "<f1>")                         'helm-resume)
(global-set-key (kbd "C-h C-f")                      'helm-apropos)
(global-set-key (kbd "C-h a")                        'helm-apropos)
;;(global-set-key (kbd "<f5> s")                       'helm-find)
;; (global-set-key (kbd "<f2>")                         'helm-execute-kmacro)
(global-set-key (kbd "C-c i")                        'helm-imenu-in-all-buffers)
;; (global-set-key (kbd "<f11> o")                      'helm-org-agenda-files-headings)
(global-set-key (kbd "C-s")                          'helm-occur)
(define-key global-map [remap jump-to-register]      'helm-register)
(define-key global-map [remap list-buffers]          'helm-buffers-list)
(define-key global-map [remap dabbrev-expand]        'helm-dabbrev)
;; (define-key global-map [remap find-tag]              'helm-etags-select)
;; (define-key global-map [remap xref-find-definitions] 'helm-etags-select)
;; (define-key global-map (kbd "M-g a")                 'helm-do-grep-ag)
;; (define-key global-map (kbd "M-g g")                 'helm-grep-do-git-grep)
;; (define-key global-map (kbd "M-g i")                 'helm-gid)

;;
;; helm-swoop
;; Change the keybinds to whatever you like :)
(global-set-key (kbd "M-s") 'helm-swoop)
(global-set-key (kbd "M-r") 'helm-swoop-back-to-last-point)
;; (global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
;; (global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

;; ;; When doing isearch, hand the word over to helm-swoop
;; (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
;; ;; From helm-swoop to helm-multi-swoop-all
;; (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
;; ;; When doing evil-search, hand the word over to helm-swoop
;; (define-key evil-motion-state-map (kbd "M-i") 'helm-swoop-from-evil-search)

;; ;; Move up and down like isearch
;; (define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
;; (define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
;; (define-key helm-multi-swoop-map (kbd "C-r") 'helm-previous-line)
;; (define-key helm-multi-swoop-map (kbd "C-s") 'helm-next-line)

(add-hook 'eshell-mode-hook
          #'(lambda ()
              (define-key eshell-mode-map (kbd "C-c C-l")  'helm-eshell-history)))


;;
;; ido

(global-set-key "\C-ci" 'ido-goto-symbol)


;;
;; org

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cb" 'org-iswitchb)


;;
;; recenf

;; (global-set-key "\C-cr" 'recentf-open-files)


;;
;; hi-lock-mode
;; Use default key binding
;; http://www.delorie.com/gnu/docs/emacs/emacs_81.html
;;   (define-key map "\M-shl" 'highlight-lines-matching-regexp)
;;   (define-key map "\M-shp" 'highlight-phrase)
;;   (define-key map "\M-shr" 'highlight-regexp)
;;   (define-key map "\M-sh." 'highlight-symbol-at-point)
;;
;;   (define-key map "\M-shu" 'unhighlight-regexp)
;;
;;   (define-key map "\M-shw" 'hi-lock-write-interactive-patterns)
;;
;;   (define-key map "\M-shf" 'hi-lock-find-patterns)


;;  _    _      _           
;; | |  | |    | |          
;; | |__| | ___| |_ __ ___  
;; |  __  |/ _ \ | '_ ` _ \ 
;; | |  | |  __/ | | | | | |
;; |_|  |_|\___|_|_| |_| |_|
;;                          
;; Helm
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z


;;  _    _           _           
;; | |  | |         | |          
;; | |__| |_   _  __| |_ __ __ _ 
;; |  __  | | | |/ _` | '__/ _` |
;; | |  | | |_| | (_| | | | (_| |
;; |_|  |_|\__, |\__,_|_|  \__,_|
;;          __/ |                
;;         |___/                 
;;
;; Hydra
(defhydra kw/hydra-toggle (:color blue :exit t)
  ("a" abbrev-mode "abbrev")
  ("f" auto-fill-mode "fill")
  ("d" toggle-debug-on-error "debug")
  ("t" toggle-truncate-lines "truncate")
  ("w" whitespace-mode "whitespace")
  ("q" nil "quit"))
(global-set-key (kbd "C-; t") 'kw/hydra-toggle/body)

(defhydra kw/hydra-zoom (global-map "C-; z")
  "zoom"
  ("+" text-scale-increase "in")
  ("-" text-scale-decrease "out")
  ("r" (text-scale-set 0) "reset" :bind nil)
  ("0" (text-scale-set 0) :bind nil :exit t)
  ("1" (text-scale-set 0) nil :bind nil :exit t))

;; TODO: Disable linum.  Halt in org mode.  A better way is to lookup a flag map to enable
;; (defhydra kw/hydra-line-action (goto-map "" :pre (linum-mode 1) :post (linum-mode -1))
(defhydra kw/hydra-line-action (:color blue :exit f)
  "line action"
  ("G" avy-goto-line "avy go")
  ("g" goto-line "go")
  ("c" avy-copy-line "copy from")
  ("M" avy-move-line "move from")
  ("t" transpose-lines "transpose")
  ("m" set-mark-command "mark" :bind nil)
  ("q" nil "quit"))
(global-set-key (kbd "C-; l") 'kw/hydra-line-action/body)

;; (defhydra hydra-launcher (:color blue)
;;    "Launch"
;;    ("h" man "man")
;;    ("r" (browse-url "http://www.reddit.com/r/emacs/") "reddit")
;;    ("w" (browse-url "http://www.emacswiki.org/") "emacswiki")
;;    ("s" shell "shell")
;;    ("q" nil "cancel"))
;; (global-set-key (kbd "C-c r") 'hydra-launcher/body)


;; ;; Source: [[http://oremacs.com/2016/04/04/hydra-doc-syntax/][Extended syntax for hydra docstrings · (or emacs]]
;; (defun org-agenda-cts ()
;;   (let ((args (get-text-property
;;                (min (1- (point-max)) (point))
;;                'org-last-args)))
;;     (nth 2 args)))
;; 
;; (defhydra hydra-org-agenda-view (:hint nil)
;;   "
;; _d_: ?d? day        _g_: time grid=?g? _a_: arch-trees
;; _w_: ?w? week       _[_: inactive      _A_: arch-files
;; _t_: ?t? fortnight  _f_: follow=?f?    _r_: report=?r?
;; _m_: ?m? month      _e_: entry =?e?    _D_: diary=?D?
;; _y_: ?y? year       _q_: quit          _L__l__c_: ?l?"
;;   ("SPC" org-agenda-reset-view)
;;   ("d" org-agenda-day-view
;;        (if (eq 'day (org-agenda-cts))
;;            "[x]" "[ ]"))
;;   ("w" org-agenda-week-view
;;        (if (eq 'week (org-agenda-cts))
;;            "[x]" "[ ]"))
;;   ("t" org-agenda-fortnight-view
;;        (if (eq 'fortnight (org-agenda-cts))
;;            "[x]" "[ ]"))
;;   ("m" org-agenda-month-view
;;        (if (eq 'month (org-agenda-cts)) "[x]" "[ ]"))
;;   ("y" org-agenda-year-view
;;        (if (eq 'year (org-agenda-cts)) "[x]" "[ ]"))
;;   ("l" org-agenda-log-mode
;;        (format "% -3S" org-agenda-show-log))
;;   ("L" (org-agenda-log-mode '(4)))
;;   ("c" (org-agenda-log-mode 'clockcheck))
;;   ("f" org-agenda-follow-mode
;;        (format "% -3S" org-agenda-follow-mode))
;;   ("a" org-agenda-archives-mode)
;;   ("A" (org-agenda-archives-mode 'files))
;;   ("r" org-agenda-clockreport-mode
;;        (format "% -3S" org-agenda-clockreport-mode))
;;   ("e" org-agenda-entry-text-mode
;;        (format "% -3S" org-agenda-entry-text-mode))
;;   ("g" org-agenda-toggle-time-grid
;;        (format "% -3S" org-agenda-use-time-grid))
;;   ("D" org-agenda-toggle-diary
;;        (format "% -3S" org-agenda-include-diary))
;;   ("!" org-agenda-toggle-deadlines)
;;   ("["
;;    (let ((org-agenda-include-inactive-timestamps t))
;;      (org-agenda-check-type t 'timeline 'agenda)
;;      (org-agenda-redo)))
;;   ("q" (message "Abort") :exit t))
;; 
;; (define-key org-agenda-mode-map
;;     "v" 'hydra-org-agenda-view/body)

;; (global-set-key
;;  (kbd "C-c v")
;;  (defhydra hydra-vi
;;      (:pre
;;       (set-cursor-color "#40e0d0")
;;       :post
;;       (set-cursor-color "#ffffff")
;;       :color amaranth)
;;    "vi"
;;    ("l" forward-char)
;;    ("h" backward-char)
;;    ("j" next-line)
;;    ("k" previous-line)
;;    ("q" nil "quit")))

;; http://oremacs.com/2015/02/19/hydra-colors-reloaded/
;; (defhydra hydra-toggle (:color pink)
;;   "
;; _a_ abbrev-mode:       %`abbrev-mode
;; _d_ debug-on-error:    %`debug-on-error
;; _f_ auto-fill-mode:    %`auto-fill-function
;; _g_ golden-ratio-mode: %`golden-ratio-mode
;; _t_ truncate-lines:    %`truncate-lines
;; _w_ whitespace-mode:   %`whitespace-mode
;; 
;; "
;;   ("a" abbrev-mode nil)
;;   ("d" toggle-debug-on-error nil)
;;   ("f" auto-fill-mode nil)
;;   ("g" golden-ratio-mode nil)
;;   ("t" toggle-truncate-lines nil)
;;   ("w" whitespace-mode nil)
;;   ("q" nil "cancel"))
;; 
;; (global-set-key (kbd "C-c C-v") 'hydra-toggle/body)

;; (defhydra hydra-toggle (:color blue :idle 1.5)
;;   "
;; _a_ abbrev-mode:       %`abbrev-mode
;; _d_ debug-on-error:    %`debug-on-error
;; _f_ auto-fill-mode:    %`auto-fill-function
;; _t_ truncate-lines:    %`truncate-lines
;; _w_ whitespace-mode:   %`whitespace-mode
;; 
;; "
;;   ("a" abbrev-mode nil)
;;   ("d" toggle-debug-on-error nil)
;;   ("f" auto-fill-mode nil)
;;   ("t" toggle-truncate-lines nil)
;;   ("w" whitespace-mode nil)
;;   ("q" nil "quit"))
;; (global-set-key (kbd "C-c t") 'hydra-toggle/body)


;; (defhydra hydra-yank-pop ()
;;   "yank"
;;   ("C-y" yank nil)
;;   ("M-y" yank-pop nil)
;;   ("y" (yank-pop 1) "next")
;;   ("Y" (yank-pop -1) "prev")
;;   ("l" helm-show-kill-ring "list" :color blue))   ; or browse-kill-ring
;; (global-set-key (kbd "M-y") #'hydra-yank-pop/yank-pop)
;; (global-set-key (kbd "C-y") #'hydra-yank-pop/yank)


;; (global-set-key
;;  (kbd "C-c C-n")
;;  (defhydra hydra-move
;;    (:body-pre (next-line))
;;    "move"
;;    ("n" next-line)
;;    ("p" previous-line)
;;    ("f" forward-char)
;;    ("b" backward-char)
;;    ("a" beginning-of-line)
;;    ("e" move-end-of-line)
;;    ("v" scroll-up-command)
;;    ;; Converting M-v to V here by analogy.
;;    ("V" scroll-down-command)
;;    ("l" recenter-top-bottom)))

;; (defhydra hydra-page (ctl-x-map "" :pre (widen))
;;   "page"
;;   ("]" forward-page "next")
;;   ("[" backward-page "prev")
;;   ("n" narrow-to-page "narrow" :bind nil :exit t))

;; (defhydra hydra-outline (:color pink :hint nil)
;;   "
;; ^Hide^             ^Show^           ^Move
;; ^^^^^^------------------------------------------------------
;; _q_: sublevels     _a_: all         _u_: up
;; _t_: body          _e_: entry       _n_: next visible
;; _o_: other         _i_: children    _p_: previous visible
;; _c_: entry         _k_: branches    _f_: forward same level
;; _l_: leaves        _s_: subtree     _b_: backward same level
;; _d_: subtree
;; 
;; "
;;   ;; Hide
;;   ("q" hide-sublevels)    ; Hide everything but the top-level headings
;;   ("t" hide-body)         ; Hide everything but headings (all body lines)
;;   ("o" hide-other)        ; Hide other branches
;;   ("c" hide-entry)        ; Hide this entry's body
;;   ("l" hide-leaves)       ; Hide body lines in this entry and sub-entries
;;   ("d" hide-subtree)      ; Hide everything in this entry and sub-entries
;;   ;; Show
;;   ("a" show-all)          ; Show (expand) everything
;;   ("e" show-entry)        ; Show this heading's body
;;   ("i" show-children)     ; Show this heading's immediate child sub-headings
;;   ("k" show-branches)     ; Show all sub-headings under this heading
;;   ("s" show-subtree)      ; Show (expand) everything in this heading & below
;;   ;; Move
;;   ("u" outline-up-heading)                ; Up
;;   ("n" outline-next-visible-heading)      ; Next
;;   ("p" outline-previous-visible-heading)  ; Previous
;;   ("f" outline-forward-same-level)        ; Forward - same level
;;   ("b" outline-backward-same-level)       ; Backward - same level
;;   ("z" nil "leave"))
;; 
;; (global-set-key (kbd "C-c #") 'hydra-outline/body) ; by example

;; https://github.com/abo-abo/hydra/wiki/Emacs

(provide 'init-key-bindings)
