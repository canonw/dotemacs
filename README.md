My Emacs consolidated setup

# Post pull setup

## Linux

At command prompt

~~~
# Goto local repository root
ln -Ffs ${PWD}/.emacs.d $HOME/.emacs.d
ln -fs ${PWD}/.emacs $HOME/.emacs
~~~


## Windows

At command prompt
~~~
@REM Goto repository root
mklink /J %HOME%\.emacs.d .emacs.d
mklink /H %HOME%\.emacs .emacs
