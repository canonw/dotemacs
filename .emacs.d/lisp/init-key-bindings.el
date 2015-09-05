;; Centralize key binding remap in one place

;;
;; ace-jump-mode
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
 
;;If you use evil
; (eval-after-load "evil" '(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode))

;;
;; evil-leader
(evil-leader/set-key
  "ae" 'evil-ace-jump-word-mode ; ,ae for Ace Jump (word)
  "al" 'evil-ace-jump-line-mode ; ,al for Ace Jump (line)
  "ac" 'evil-ace-jump-char-mode ; ,ac for Ace Jump (char)
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
(global-set-key (kbd "C-c f") 'helm-for-files)
;; (global-set-key (kbd "C-c y") 'helm-c-yas-complete)
(global-set-key (kbd "C-x C-o") 'ffap)


;;
;; helm-swoop
;; Change the keybinds to whatever you like :)
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
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


(provide 'init-key-bindings)
