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

At command prompt, run the following commands at repository root directory.
~~~
@REM Goto repository root
mklink /J %HOME%\.emacs.d .emacs.d
mklink /H %HOME%\.emacs .emacs


Download Unix libraries at [ezwinports](http://sourceforge.net/projects/ezwinports/) and place them in emacs bin directory.