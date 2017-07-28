;; Dislay week number in calendar
;; http://stackoverflow.com/questions/21364948/how-to-align-the-calendar-with-week-number-as-the-intermonth-text

; Make Monday as first column to get week number accurate
(setq calendar-week-start-day 1)

(setq calendar-intermonth-text
      '(propertize
        (format "%2d"
                (car
                 (calendar-iso-from-absolute
                  (calendar-absolute-from-gregorian (list month day year)))))
        'font-lock-face 'font-lock-warning-face))

(setq calendar-intermonth-header
      (propertize "Wk"                  ; or e.g. "KW" in Germany
                  'font-lock-face 'font-lock-keyword-face))

(setq calendar-date-style (quote iso))

(provide 'init-calendar)
