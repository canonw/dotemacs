(use-package helm
  :ensure t
  :diminish helm-mode
  :init
  (use-package helm-config)
  (setq helm-candidate-number-limit 100)
  ;; From https://gist.github.com/antifuchs/9238468
  (setq helm-idle-delay 0.0
                                        ; update fast sources immediately (doesn't).
        helm-input-idle-delay 0.01
                                        ; this actually updates things relatively quickly.
        helm-yas-display-key-on-candidate t
        helm-quick-update t
        helm-M-x-requires-pattern nil
        helm-ff-skip-boring-files t)
  (helm-mode)
  :config
  (helm-autoresize-mode 1)
  (setq helm-scroll-amount 6)
  (setq helm-ff-file-name-history-use-recentf t)
  (define-key global-map [remap jump-to-register]      'helm-register)
  (define-key global-map [remap list-buffers]          'helm-buffers-list)
  (define-key global-map [remap dabbrev-expand]        'helm-dabbrev)
  :bind (("C-c f" . helm-recentf)
         ("C-c h" . helm-mini)
         ("C-h a" . helm-aproposa)
         ("M-y" . helm-show-kill-ring)
         ("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x c o" . helm-occur)
         ("C-x c s" . helm-swoop)
         ("C-x c y" . helm-yas-complete)
         ("C-x c Y" . helm-yas-create-snippet-on-region)
         ("C-x c b" . my/helm-do-grep-book-notes)
         ("C-x c SPC" . helm-all-mark-rings))
  )
(ido-mode -1) ;; Turn off ido mode in case I enabled it accidentally

;; (use-package helm-config
;;   :config
;;   (use-package helm-gitignore)
;;   (use-package helm-gitlab :disabled t)
;;   (use-package helm-helm-commands)
;;   (use-package helm-flx
;;     :config
;;     (helm-flx-mode 1)))
;; (use-package helm-git-grep)
(use-package helm-themes :ensure t :defer t)
;; (use-package helm-hoogle)
;; (use-package helm-pydoc
;;   :config
;;   (eval-after-load "python"
;;     '(define-key python-mode-map (kbd "C-c C-d") #'helm-pydoc)))
;; (use-package helm-bind-key)
;; (use-package helm-perldoc)
;; (use-package helm-ls-git)
;; (use-package helm-ag)
;; (use-package helm-j-cheatsheet)
;; (use-package helm-make)

(use-package helm-swoop
  :ensure t
  :after helm
  :config
  ;; Save buffer when helm-multi-swoop-edit complete
  (setq helm-multi-swoop-edit-save t)
  ;; If this value is t, split window inside the current window
  (setq helm-swoop-split-with-multiple-windows t)
  ;; Split direction. 'split-window-vertically or 'split-window-horizontally
  (setq helm-swoop-split-direction 'split-window-vertically)
  ;; If nil, you can slightly boost invoke speed in exchange for text color
  (setq helm-swoop-speed-or-color t)
  ;; Go to the opposite side of line from the end or beginning of line
  (setq helm-swoop-move-to-line-cycle t)
  ;; Optional face for line numbers
  ;; ace name is `helm-swoop-line-number-face`
  (setq helm-swoop-use-line-number-face t)
  )

;; (eval-after-load 'helm
;;   '(progn
;;      ;; Helm window is too big?
;;      (helm-autoresize-mode 1)y
;; 
;;      ;; @see http://tuhdo.github.io/helm-intro.html
;;      (setq helm-split-window-in-side-p t ;; opens a small window inside the lower half of current window
;;            helm-move-to-line-cycle-in-source t ; move to end or beginning of source when reaching top or bottom of source.
;;            helm-ff-search-library-in-sexp t ; search for library in `require' and `declare-function' sexp.
;;            helm-scroll-amount 8 ; scroll 8 lines other window using M-<next>/M-<prior>
;;            helm-ff-file-name-history-use-recentf t)
;; 
;;      (when (executable-find "curl")
;;        (setq helm-google-suggest-use-curl-p t))
;; 
;;      (setq helm-completing-read-handlers-alist
;;            '((describe-function . ido)
;;              (describe-variable . ido)
;;              (debug-on-entry . helm-completing-read-symbols)
;;              (find-function . helm-completing-read-symbols)
;;              (find-tag . helm-completing-read-with-cands-in-buffer)
;;              (ffap-alternate-file . nil)
;;              (tmm-menubar . nil)
;;              (dired-do-copy . nil)
;;              (dired-do-rename . nil)
;;              (dired-create-directory . nil)
;;              (find-file . ido)
;;              (copy-file-and-rename-buffer . nil)
;;              (rename-file-and-buffer . nil)
;;              (w3m-goto-url . nil)
;;              (ido-find-file . nil)
;;              (ido-edit-input . nil)
;;              (mml-attach-file . ido)
;;              (read-file-name . nil)
;;              (yas/compile-directory . ido)
;;              (execute-extended-command . ido)
;;              (minibuffer-completion-help . nil)
;;              (minibuffer-complete . nil)
;;              (c-set-offset . nil)
;;              (wg-load . ido)
;;              (rgrep . nil)
;;              (read-directory-name . ido)
;;              ))
;; 
;;      ))
;; ;; }}
;; 

(provide 'init-helm)
