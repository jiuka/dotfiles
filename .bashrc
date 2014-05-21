#    _               _              
#   | |__   __ _ ___| |__  _ __ ___ 
#   | '_ \ / _` / __| '_ \| '__/ __|
#  _| |_) | (_| \__ \ | | | | | (__ 
# (_)_.__/ \__,_|___/_| |_|_|  \___|
#

if [[ $- != *i* ]] ; then
  # Shell is non-interactive.  Be done now!
  return
fi

# Bash won't get SIGWINCH if another process is in the foreground.
shopt -s checkwinsize

# Enable history appending instead of overwriting.
shopt -s histappend

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*|interix)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
    ;;
  screen)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
    ;;
esac

if [ -e "/usr/share/git-core/contrib/completion/git-prompt.sh" ]; then
  . /usr/share/git-core/contrib/completion/git-prompt.sh
fi

if [[ ${EUID} == 0 ]] ; then
  PS1='\[\033[00;31m\]\h[\[\e[01;31m\]$?\[\e[00;31m\]]\[\033[01;34m\] \W \[\033[0;33m\]$(__git_ps1 "<%s> ")\[\033[01;34m\]\$\[\033[00m\] '
else
  PS1='\[\033[00;32m\]\h[\[\e[01;31m\]$?\[\e[00;32m\]]\[\033[01;34m\] \w \[\033[0;33m\]$(__git_ps1 "<%s> ")\[\033[01;34m\]\$\[\033[00m\] '
fi

# Enable Keychain if ssh-agent is missing
if [ -z "$SSH_AGENT_PID" -a -e /usr/bin/keychain ]; then
  eval $(/usr/bin/keychain --eval --quiet)
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export EDITOR=vim

function sshrm {
  ssh-keygen -R $1
  host $1 | sed 's/ .* / /g' | xargs -n 1 ssh-keygen -R
}

alias dotgit="git --git-dir=$HOME/git/github/dotfiles.git"
