(use-package hydra
  :ensure t
  :init
  (defhydra kw/hydra-zoom ()
    "zoom"
    ("+" text-scale-increase "in")
    ("-" text-scale-decrease "out")
    ("r" (text-scale-set 0) "reset" :bind nil)
    ("0" (text-scale-set 0) :bind nil :exit t)
    ("1" (text-scale-set 0) nil :bind nil :exit t))

  (defhydra kw/hydra-toggle (:color blue :exit f)
    ("a" abbrev-mode "abbrev")
    ("f" auto-fill-mode "fill")
    ("d" toggle-debug-on-error "debug")
    ("g" golden-ratio-mode nil)
    ("l" linum-mode "linum")
    ("t" toggle-truncate-lines "truncate")
    ("w" whitespace-mode "whitespace")
    ("q" nil "quit"))
  (use-package hydra-examples)
  
  (defhydra kw/hydra-window (:color red :hint nil)
  "
 Split: _v_ert _x_:horz
Delete: _o_nly  _da_ce  _dw_indow  _db_uffer  _df_rame
  Move: _s_wap
Frames: _f_rame new  _df_ delete
  Misc: _m_ark _a_ce  _u_ndo  _r_edo"
  ("h" windmove-left)
  ("j" windmove-down)
  ("k" windmove-up)
  ("l" windmove-right)
  ("H" hydra-move-splitter-left)
  ("J" hydra-move-splitter-down)
  ("K" hydra-move-splitter-up)
  ("L" hydra-move-splitter-right)
  ("|" (lambda ()
         (interactive)
         (split-window-right)
         (windmove-right)))
  ("_" (lambda ()
         (interactive)
         (split-window-below)
         (windmove-down)))
  ("v" split-window-right)
  ("x" split-window-below)
  ;("t" transpose-frame "'")
  ;; winner-mode must be enabled
  ("u" winner-undo)
  ("r" winner-redo) ;;Fixme, not working?
  ("o" delete-other-windows :exit t)
  ("a" ace-window :exit t)
  ("f" new-frame :exit t)
  ("s" ace-swap-window)
  ("da" ace-delete-window)
  ("dw" delete-window)
  ("db" kill-this-buffer)
  ("df" delete-frame :exit t)
  ("q" nil)
  ("i" ace-maximize-window "ace-one" :color blue)
  ;("b" ido-switch-buffer "buf")
  ("m" headlong-bookmark-jump))

  (defhydra kw/hydra-line(:color blue :exit f)
    "line action"
    ("g" avy-goto-line "avy go")
    ;;  ("g" goto-line "go")
    ("c" avy-copy-line "copy from")
    ("l" select-current-line "Line")
    ("M" avy-move-line "move from")
    ("t" transpose-lines "transpose")
    ("m" set-mark-command "mark" :bind nil)
    ("q" nil "quit"))

  (defhydra hydra-common (:color blue)
    ("<ESC>" nil "quit"))

  (defhydra kw/hydra-spell (:color blue :hint nil :idle 0.4)
    "
                                                                       ╭───────┐
    Flyspell               Ispell                      Gtranslate      │ Spell │
╭──────────────────────────────────────────────────────────────────────┴───────╯
  [_k_] correct word       [_w_] check word            [_g_] en ⇆ es
  [_n_] next error         [_t_] toggle dictionary     [_G_] any lang
  [_f_] toggle flyspell    [_d_] change dictionary
  [_p_] toggle prog mode
--------------------------------------------------------------------------------
      "
    ("w" ispell-word)
    ("d" ispell-change-dictionary)
    ("t" dkh-switch-dictionary)
    ("g" google-translate-smooth-translate)
    ("G" google-translate-query-translate)
    ("f" flyspell-mode)
    ("p" flyspell-prog-mode)
    ("k" flyspell-auto-correct-word)
    ("n" flyspell-goto-next-error))

  (defhydra kw/hydra-mark (:exit t
                                 :columns 3
                                 ;; :idle 1.0
                                 :pre (er/expand-region 1))
    "Mark"
    ("." er/expand-region "Expand region" :exit nil)
;;    ("," er/contract-region "Contract region" :exit nil)
    ("w" er/mark-word "Word" :exit nil)
    ("s" er/mark-sentence "Sentence")
    ("p" er/mark-paragraph "Paragraph")

    ("d" mark-defun)

    ("u" er/mark-url "Url")
    ("m" er/mark-email "Email")   
    ("e" mark-sexp "S-Expression")

    ("b" mark-whole-buffer "Whole buffer")

    ("q" er/mark-inside-quotes "Inside quotes")
    ("Q" er/mark-outside-quotes "Outside quotes")
    ("p" er/mark-inside-pairs "Inside pairs")
    ("P" er/mark-outside-pairs "Outside pairs")
    )

  (bind-keys ("C-; s" . kw/hydra-spell/body)
             ("C-; m" . kw/hydra-mark/body)
             ("C-; w" . kw/hydra-window/body)
             ("C-; ;" . kw/hydra-toggle/body)
             ("C-; z" . kw/hydra-zoom/body)
             )
  (global-set-key (kbd "C-; l") 'kw/hydra-line/body)

  :config
  (setq hydra-is-helpful t)
  (setq hydra-lv t)

;;  (add-hook 'text-mode-hook (lambda ()
;;                              (require 'text-mode-expansions)
;;                              (auto-fill-mode -1)))
  )

(provide 'init-hydra)
