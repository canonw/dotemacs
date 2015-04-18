;; Insert Date and Time
;; Reference: http://stackoverflow.com/questions/251908/how-can-i-insert-current-date-and-time-into-a-file-using-emacs
;; Reference :http://www.emacswiki.org/emacs/InsertingTodaysDate
(defvar timestamp-format "%Y-%m-%dT%T%z"
  "Format of timestamp to insert with `timestamp' func
See help of `format-time-string' for possible replacements")
(defun timestamp ()
  (interactive)
  (insert (format-time-string timestamp-format (current-time))))

;; Open GTD file quickly
(defun gtd ()
  (interactive)
  (find-file "~/org/gtd.org")
  )

(setq my-command-buffer-hooks (make-hash-table))

;; http://www.tech-thoughts-blog.com/2013/08/make-emacs-load-random-theme-at-startup.html
(defun load-random-theme ()
  "Load any random theme from the available ones."
  (interactive)
  
  ;; disable any previously set theme
  (if (boundp 'theme-of-the-day)
      (progn
	(disable-theme theme-of-the-day)
	(makunbound 'theme-of-the-day)))
  
  (defvar themes-list (custom-available-themes))
  (defvar theme-of-the-day (nth (random (length themes-list))
				themes-list))
  (load-theme (princ theme-of-the-day) t)) 

;; (defun my-command-on-save-buffer (c)
;;     "Run a command <c> every time the buffer is saved "
;;     (interactive "sShell command: ")
;;     (puthash (buffer-file-name) c my-command-buffer-hooks))
;; 
;; (defun my-command-buffer-kill-hook ()
;;   "Remove a key from <command-buffer-hooks> if it exists"
;;   (remhash (buffer-file-name) my-command-buffer-hooks))
;; 
;; (defun my-command-buffer-run-hook ()
;;   "Run a command if it exists in the hook"
;;   (let ((hook (gethash (buffer-file-name) my-command-buffer-hooks)))
;;     (when hook
;;         (shell-command hook))))
;; 
;; ;; add hooks
;; (add-hook 'kill-buffer-hook 'my-command-buffer-kill-hook)
;; (add-hook 'after-save-hook 'my-command-buffer-run-hook)

(provide 'init-utils)
