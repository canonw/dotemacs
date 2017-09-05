;;; Reference: https://gist.githubusercontent.com/Superbil/7113937/raw/b2a6500bbca3e1a47ee4c79870b16563f7172e76/fix-font-org-mode.el
;;; base on https://gist.github.com/coldnew/7398835
(defvar emacs-english-font nil
  "The font name of English.")

(defvar emacs-cjk-font nil
  "The font name for CJK.")

(defvar emacs-font-size-pair nil
  "Default font size pair for (english . chinese)")

(defvar emacs-font-size-pair-list nil
  "This list is used to store matching (englis . chinese) font-size.")

(defun font-exist-p (fontname)
  "test if this font is exist or not."
  (if (or (not fontname) (string= fontname ""))
      nil
    (if (not (x-list-fonts fontname))
        nil t)))

(defun set-font (english chinese size-pair)
  "Setup emacs English and Chinese font on x window-system."
  (if (font-exist-p english)
      (set-frame-font (format "%s:pixelsize=%d" english (car size-pair)) t))

  (if (font-exist-p chinese)
      (dolist (charset '(kana han symbol cjk-misc bopomofo))
        (set-fontset-font (frame-parameter nil 'font) charset
                          (font-spec :family chinese :size (cdr size-pair))))))

(defun emacs-step-font-size (step)
  "Increase/Decrease emacs's font size."
  (let ((scale-steps emacs-font-size-pair-list))
    (if (< step 0) (setq scale-steps (reverse scale-steps)))
    (setq emacs-font-size-pair
          (or (cadr (member emacs-font-size-pair scale-steps))
              emacs-font-size-pair))
    (when emacs-font-size-pair
      (message "emacs font size set to %.1f" (car emacs-font-size-pair))
      (set-font emacs-english-font emacs-cjk-font emacs-font-size-pair))))

(defun increase-emacs-font-size ()
  "Decrease emacs's font-size acording emacs-font-size-pair-list."
  (interactive) (emacs-step-font-size 1))

(defun decrease-emacs-font-size ()
  "Increase emacs's font-size acording emacs-font-size-pair-list."
  (interactive) (emacs-step-font-size -1))

(setq emacs-english-font "Source Code Pro")

(setq list-faces-sample-text
      (concat
       "ABCDEFTHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz\n"
       "11223344556677889900       壹貳參肆伍陸柒捌玖零"))

;; setup change size font, base on emacs-font-size-pair-list
(global-set-key (kbd "C-M-=") 'increase-emacs-font-size)
(global-set-key (kbd "C-M--") 'decrease-emacs-font-size)

(when *win64*

  ;; setup default english font and cjk font
  ;;(setq emacs-english-font "Source Code Pro")
  (if (member "Consolas" (font-family-list))
      (setq emacs-english-font "Consolas"))
  (setq emacs-english-font (cond
                            ((member "Source Code Pro" (font-family-list)) "Source Code Pro")
                            ((member "Consolas" (font-family-list)) "Consolas")
                            ))

  (setq emacs-cjk-font "MingLiu")
  (setq emacs-font-size-pair '(17 . 20))
  (setq emacs-font-size-pair-list '(( 5 .  6) (10 . 12)
                                    (13 . 16) (15 . 18) (17 . 20)
                                    (19 . 22) (20 . 24) (21 . 26)
                                    (24 . 28) (26 . 32) (28 . 34)
                                    (30 . 36) (34 . 40) (36 . 44)))

  ;; Setup font size based on emacs-font-size-pair
  (set-font emacs-english-font emacs-cjk-font emacs-font-size-pair)
)

(provide 'init-fonts)
