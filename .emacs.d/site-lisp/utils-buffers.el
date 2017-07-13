;; -*- coding: utf-8 -*-
;; Buffer related functions
;; Reference: https://github.com/DennyZhang/Denny-s-emacs-configuration/blob/master/buffer-setting.el


(defun next-user-buffer ()
  "Switch to the next user buffer.
User buffers are those whose name does not start with *."
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i 50))
      (setq i (1+ i)) (next-buffer) )))

(defun previous-user-buffer ()
  "Switch to the previous user buffer.
User buffers are those whose name does not start with *."
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i 50))
      (setq i (1+ i)) (previous-buffer) )))

(defun next-emacs-buffer ()
  "Switch to the next emacs buffer.
Emacs buffers are those whose name starts with *."
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (not (string-match "^*" (buffer-name))) (< i 50))
      (setq i (1+ i)) (next-buffer) )))

(defun previous-emacs-buffer ()
  "Switch to the previous emacs buffer.
Emacs buffers are those whose name starts with *."
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (not (string-match "^*" (buffer-name))) (< i 50))
      (setq i (1+ i)) (previous-buffer) )))

(global-set-key (kbd "C-x C-S-k") 'kill-other-buffers)
(defun kill-other-buffers (&optional arg)
  (interactive "P")
  (let ((curbuf (buffer-name))
        (buflist (mapcar (function buffer-name) (buffer-list))))
    (dolist (buf buflist)
      (unless (string= curbuf buf) (kill-buffer buf))
      ))
  )

(provide 'utils-buffers)
