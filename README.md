My Emacs consolidated setup

# Post pull setup

## Windows

At command prompt
~~~
@REM Goto repository root
mklink /J %HOME%\.emacs.d .emacs.d
mklink /H %HOME%\.emacs .emacs