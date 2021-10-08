# On macOS, Terminal has hooks that can be used to save and restore sessions.  The code inside
# /etc/bashrc_Apple_Terminal will save and restore history.  This extends that functionality to save and restore:
# - the directory stack and current directory
# - shell variables
# - aliases
# - shell options
# - the status of shell builtins
# - shell functions
# as well as history.

reverse_dirs () {
  local REPLY
  if read
  then { reverse_dirs "$1"x
         echo \"$REPLY\"
	 if [ -n "$1" ]
	 then echo -n 'pushd '
	 fi; }
  else echo -n 'cd '
  fi
}

shell_session_save_user_state() { 
  {
  dirs -l -p | reverse_dirs "" # need -l for ~, spaces

  { declare -ap
    declare -ip
    declare -tp
    declare -xp 
  } | egrep -v '^declare -[a-zA-Z]+ ('`declare -rp | sed -E 's/^declare -[a-zA-Z]+ ([[:alnum:]_]+)=.*$/\1/'|tr '\012' '|'`'XXXXXBLAH)=' 

  alias -p
  shopt -p

  set -o|awk '$2=="on" { printf "set -o %s\n", $1} $2=="off" { printf "set +o %s\n", $1}'

  enable -p
  enable -np

  declare -fp
  } >> "$SHELL_SESSION_FILE";

  # clear shared history
  HISTFILE=~/.bash_history
  HISTFILESIZE=0
}

SHELL_SESSION_HISTORY=1
