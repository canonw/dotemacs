(use-package yasnippet
  :init
  (progn
    (add-hook 'after-save-hook
              (lambda ()
                (when (eql major-mode 'snippet-mode)
                  (yas-reload-all))))
    (setq yas-snippet-dirs '("~/.emacs.d/snippets"
                             ;; ... extra path here
                             ))
    (setq yas-verbosity 3)
    (setq yas-indent-line 'fixed)
    (yas-global-mode 1)
    (setq yas-new-snippet-default "# -*- mode: snippet; require-final-newline: nil -*-
# name: $1
# key: ${2:${1:$(yas--key-from-desc yas-text)}}
# group: $3
# binding: direct-keybinding
# --
$0`(yas-escape-text yas-selected-text)`")
    )
  :mode (("/\\.emacs\\.d/snippets/" . snippet-mode)
         ("\\.yasnippet" . snippet-mode))
  :diminish yas-minor-mode
  :defer 15
  :config
  (progn
    (yas-global-mode 1)

    ;; Add yasnippet support for all company backends
    ;; https://github.com/syl20bnr/spacemacs/pull/179
    (defvar company-mode/enable-yas t
      "Enable yasnippet for all backends.")
    (defun company-mode/backend-with-yas (backend)
      (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
          backend
        (append (if (consp backend) backend (list backend))
                '(:with company-yasnippet))))
    (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

    ))

(use-package yankpad
  :disabled (not (file-exists-p "~/org/yankpad.org"))
  :init
  (setq yankpad-file "~/org/yankpad.org")
  ;; :config
  ;; (bind-key "<f7>" 'yankpad-map)
  ;; (bind-key "<f12>" 'yankpad-expand)

  ;; Commented out for now.  Bug
  ;; ;; If you want to complete snippets using company-mode
  ;; (add-to-list 'company-backends #'company-yankpad)
  )

(provide 'init-yasnippet)
