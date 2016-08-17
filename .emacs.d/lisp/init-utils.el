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

;; http://xahlee.blogspot.com/2010/09/emacs-select-current-line-with-single.html
(defun select-current-line ()
  "Select the current line"
  (interactive)
  (end-of-line) ; move to end of line
  (set-mark (line-beginning-position)))

;; http://stackoverflow.com/questions/9288181/converting-from-camelcase-to-in-emacs
(defun un-camelcase-word-at-point ()
  "un-camelcase the word at point, replacing uppercase chars with
the lowercase version preceded by an underscore.

The first char, if capitalized (eg, PascalCase) is just
downcased, no preceding underscore.
"
  (interactive)
  (save-excursion
    (let ((bounds (bounds-of-thing-at-point 'word)))
      (replace-regexp "\\([A-Z]\\)" "_\\1" nil
                      (1+ (car bounds)) (cdr bounds))
      (downcase-region (car bounds) (cdr bounds)))))


;; http://stackoverflow.com/a/7053298
(defun sh-send-line-or-region (&optional step)
  (interactive ())
  (let ((proc (get-process "shell"))
        pbuf min max command)
    (unless proc
      (let ((currbuff (current-buffer)))
        (shell)
        (switch-to-buffer currbuff)
        (setq proc (get-process "shell"))
        ))
    (setq pbuff (process-buffer proc))
    (if (use-region-p)
        (setq min (region-beginning)
              max (region-end))
      (setq min (point-at-bol)
            max (point-at-eol)))
    (setq command (concat (buffer-substring min max) "\n"))
    (with-current-buffer pbuff
      (goto-char (process-mark proc))
      (insert command)
      (move-marker (process-mark proc) (point))
      ) ;;pop-to-buffer does not work with save-current-buffer -- bug?
    (process-send-string  proc command)
    (display-buffer (process-buffer proc) t)
    (when step 
      (goto-char max)
      (next-line))
    ))

(defun sh-send-line-or-region-and-step ()
  (interactive)
  (sh-send-line-or-region t))
(defun sh-switch-to-process-buffer ()
  (interactive)
  (pop-to-buffer (process-buffer (get-process "shell")) t))

(provide 'init-utils)
