My Emacs consolidated setup

# Post pull setup

## Windows

At command prompt, run the following commands at repository root directory.
~~~
@REM Goto repository root
mklink /J %HOME%\.emacs.d .emacs.d
mklink /H %HOME%\.emacs .emacs