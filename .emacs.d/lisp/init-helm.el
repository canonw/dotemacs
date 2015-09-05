(require 'helm-config)

(autoload 'helm-c-yas-complete "helm-c-yasnippet" nil t)
(autoload 'helm-ls-git-ls "helm-ls-git" nil t)
(autoload 'helm-browse-project "helm-ls-git" nil t)

;; {{ Lean helm window
;; @see http://www.reddit.com/r/emacs/comments/2z7nbv/lean_helm_window/
(setq helm-display-header-line nil) ;; t by default
;; keep the full source header line when multiple sources
;; and hidden when there's a single source
(defun helm-toggle-header-line ()
  (if (= (length helm-sources) 1)
      (set-face-attribute 'helm-source-header nil :height 0.1)
    (set-face-attribute 'helm-source-header nil :height 1.0)))
(add-hook 'helm-before-initialize-hook 'helm-toggle-header-line)


(eval-after-load 'helm
  '(progn
     ;; Helm window is too big?
     (helm-autoresize-mode 1)

     ;; @see http://tuhdo.github.io/helm-intro.html
     (setq helm-split-window-in-side-p t ;; opens a small window inside the lower half of current window
           helm-move-to-line-cycle-in-source t ; move to end or beginning of source when reaching top or bottom of source.
           helm-ff-search-library-in-sexp t ; search for library in `require' and `declare-function' sexp.
           helm-scroll-amount 8 ; scroll 8 lines other window using M-<next>/M-<prior>
           helm-ff-file-name-history-use-recentf t)

     (when (executable-find "curl")
       (setq helm-google-suggest-use-curl-p t))

     (setq helm-completing-read-handlers-alist
           '((describe-function . ido)
             (describe-variable . ido)
             (debug-on-entry . helm-completing-read-symbols)
             (find-function . helm-completing-read-symbols)
             (find-tag . helm-completing-read-with-cands-in-buffer)
             (ffap-alternate-file . nil)
             (tmm-menubar . nil)
             (dired-do-copy . nil)
             (dired-do-rename . nil)
             (dired-create-directory . nil)
             (find-file . ido)
             (copy-file-and-rename-buffer . nil)
             (rename-file-and-buffer . nil)
             (w3m-goto-url . nil)
             (ido-find-file . nil)
             (ido-edit-input . nil)
             (mml-attach-file . ido)
             (read-file-name . nil)
             (yas/compile-directory . ido)
             (execute-extended-command . ido)
             (minibuffer-completion-help . nil)
             (minibuffer-complete . nil)
             (c-set-offset . nil)
             (wg-load . ido)
             (rgrep . nil)
             (read-directory-name . ido)
             ))

     ))
;; }}

;;
;; helm swoop
(require 'helm)
(require 'helm-swoop)

;; Save buffer when helm-multi-swoop-edit complete
(setq helm-multi-swoop-edit-save t)

;; If this value is t, split window inside the current window
(setq helm-swoop-split-with-multiple-windows nil)

;; Split direcion. 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-vertically)

;; If nil, you can slightly boost invoke speed in exchange for text color
(setq helm-swoop-speed-or-color nil)

;; ;; Go to the opposite side of line from the end or beginning of line
(setq helm-swoop-move-to-line-cycle t)

;; Optional face for line numbers
;; Face name is `helm-swoop-line-number-face`
(setq helm-swoop-use-line-number-face t)

(provide 'init-helm)
