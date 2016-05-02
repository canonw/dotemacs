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

;; https://gist.github.com/ober/5275534
(defun random-color-theme ()
  "Load any random theme from the available ones."
  (interactive)
  (let ((chosen-theme
         (nth
          (random
           (length (mapcar 'symbol-name (custom-available-themes))))
          (custom-available-themes))))
    (message "Theme: %s" chosen-theme)
    (load-theme chosen-theme t nil)))

(defun show-me-the-colors ()  (interactive) (loop do (random-color-theme) (sit-for 3)))
(setq color-theme-is-cumulative 'false)

(provide 'init-utils)
