My Emacs consolidated setup

# Post pull setup

## Linux

### Adding configuration shortcut

At command prompt

~~~
# Goto local repository root
ln -Ffs ${PWD}/.emacs.d $HOME/.emacs.d
ln -fs ${PWD}/.emacs $HOME/.emacs
~~~


## Windows

### Adding configuration shortcut

At command prompt, run the following commands at repository root directory.

~~~
@REM Goto repository root
mklink /J %HOME%\.emacs.d .emacs.d
mklink /H %HOME%\.emacs .emacs
~~~

### Additional Unix files

Emacs in Windows needs to include additional Unix libraries to work property.  The preferred site is [ezwinports](http://sourceforge.net/projects/ezwinports/files/?source=navbar)

Place them to the same directory as emacs bin.

1.  gnutls.  This is required to resolve this error message -- Could not create connection to marmalade-repo.org:44
    Reference: <http://stackoverflow.com/a/26596768>

2.  jpeg, libpng, and gif.   The library set enables inline picture viewing.
