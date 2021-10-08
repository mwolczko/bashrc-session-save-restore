More complete session restore for bash on macOS

On macOS, Terminal has hooks that can be used to save and restore sessions.  The code inside
/etc/bashrc_Apple_Terminal will save and restore history.  This extends that functionality to save and restore:
- the directory stack and current directory
- shell variables
- aliases
- shell options
- the status of shell builtins
- shell functions

as well as history.

Usage: append the contents of "bashrc" to your .bashrc file (or prepend or insert anywhere where it won't cause a problem), or source it
in your .bashrc using
. bashrc


