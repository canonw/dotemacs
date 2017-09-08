(use-package hydra
  :bind (("C-c w" . hydra-window/body))
  :config
  (hydra-add-font-lock)

  (require 'windmove)

  (defun hydra-move-splitter-left (arg)
    "Move window splitter left."
    (interactive "p")
    (if (let ((windmove-wrap-around))
          (windmove-find-other-window 'right))
        (shrink-window-horizontally arg)
      (enlarge-window-horizontally arg)))

  (defun hydra-move-splitter-right (arg)
    "Move window splitter right."
    (interactive "p")
    (if (let ((windmove-wrap-around))
          (windmove-find-other-window 'right))
        (enlarge-window-horizontally arg)
      (shrink-window-horizontally arg)))

  (defun hydra-move-splitter-up (arg)
    "Move window splitter up."
    (interactive "p")
    (if (let ((windmove-wrap-around))
          (windmove-find-other-window 'up))
        (enlarge-window arg)
      (shrink-window arg)))

  (defun hydra-move-splitter-down (arg)
    "Move window splitter down."
    (interactive "p")
    (if (let ((windmove-wrap-around))
          (windmove-find-other-window 'up))
        (shrink-window arg)
      (enlarge-window arg)))

  (defhydra hydra-window (:color amaranth)
    "
Move Point^^^^   Move Splitter   ^Ace^                       ^Split^
--------------------------------------------------------------------------------
_w_, _<up>_      Shift + Move    _C-a_: ace-window           _2_: split-window-below
_a_, _<left>_                    _C-s_: ace-window-swap      _3_: split-window-right
_s_, _<down>_                    _C-d_: ace-window-delete    ^ ^
_d_, _<right>_                   ^   ^                       ^ ^
You can use arrow-keys or WASD.
"
    ("2" split-window-below nil)
    ("3" split-window-right nil)
    ("a" windmove-left nil)
    ("s" windmove-down nil)
    ("w" windmove-up nil)
    ("d" windmove-right nil)
    ("A" hydra-move-splitter-left nil)
    ("S" hydra-move-splitter-down nil)
    ("W" hydra-move-splitter-up nil)
    ("D" hydra-move-splitter-right nil)
    ("<left>" windmove-left nil)
    ("<down>" windmove-down nil)
    ("<up>" windmove-up nil)
    ("<right>" windmove-right nil)
    ("<S-left>" hydra-move-splitter-left nil)
    ("<S-down>" hydra-move-splitter-down nil)
    ("<S-up>" hydra-move-splitter-up nil)
    ("<S-right>" hydra-move-splitter-right nil)
    ("C-a" ace-window nil)
    ("u" hydra--universal-argument nil)
    ("C-s" (lambda () (interactive) (ace-window 4)) nil)
    ("C-d" (lambda () (interactive) (ace-window 16)) nil)
    ("q" nil "quit"))

  )

(provide 'init-hydra)
