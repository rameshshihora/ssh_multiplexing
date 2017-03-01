# .bashrc

# Source global definitions
#if [ -f /etc/bashrc ]; then
#	. /etc/bashrc
#fi

# User specific aliases and functions
#Git Prompt
git_prompt ()
{
  c_reset='\[\e[0m\]'
  c_git_clean='\[\e[36;1m\]'
  c_git_dirty='\[\e[31;1m\]'
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return 0
  fi

  git_branch=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')

  if git diff --quiet 2>/dev/null >&2; then
    git_color="$c_git_clean"
  else
    git_color="$c_git_dirty"
  fi

  echo "$git_color[$git_branch]${c_reset}"
}

alias e='exit'
alias gadd='git add'
alias gamd='git commit --amend'
alias gbase='git rebase master'
alias gbcn='git branch'
alias gcom='git commit -m'
alias gchk='git checkout'
alias gdif='git diff'
alias gdif1="git log --pretty=oneline | head -n 1 | cut -d' ' -f1 | xargs git show"
alias gdif2="git log --pretty=oneline | head -n 1 | awk {'print $1'} | git show | grep diff"
alias gfork='git checkout -b'
alias glog='git log --pretty=oneline'
alias glogs='git log --pretty=oneline | head'
alias gnuke='git branch -D'
alias gpll='git pull'
alias gstat='git status'
alias kc='eval `keychain --eval --agents "ssh" /etc/chef-server/keys/rootkey`'
alias kct='eval `keychain --eval --agents "ssh" /var/chef/tastetester/tastetester`'
alias kclear='keychain --clear'
alias kstop='keychain -k mine'
alias rel='. ~/.bash_profile'
alias v='vim'
alias gitb="git for-each-ref --sort=-committerdate refs/heads/ --format='%(HEAD) %(color:red)%(refname:short)%(color:reset) - %(contents:subject) (%(color:green)%(committerdate:relative)%(color:reset))'"
#Color Prompt
PROMPT_COMMAND='PS1="\[\e[36;1m\]\u@\[\e[32;1m\]\h\[\e[34;1m\][\W]$(git_prompt) \[\e[31;1m\]<\#>\[\e[0m\] "'
export EDITOR="vim"

alias kc="eval `keychain --eval --agents "ssh" /var/chef/tastetester/tastetester`"

#if [ ! -S ~/.ssh/ssh_auth_sock ]; then
#  eval `ssh-agent`
#  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
#fi
#export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
#ssh-add -l | grep "The agent has no identities" && ssh-add <yourkeyfile>

HISTFILESIZE=130000
HISTSIZE=130000
HISTCONTROL=ignoreboth
HISTIGNORE='bg:fg:history;exit'
HISTTIMEFORMAT='%F %T '
PROMPT_COMMAND="$PROMPT_COMMAND; history -a; history -n"
shopt -s histappend
shopt -s cmdhist
history(){
  syncHistory
  builtin history "$@"
}

syncHistory(){
  builtin history -a
  HISTFILESIZE=$HISTFILESIZE
  builtin history -c
  builtin history -r
}

promptCommand(){
  if [ "$TERM" = xterm ]
  then case "$DISPLAY" in
       :*)  printf "\033]0;%s\007"                     "$PWD" ;;
       *)   printf "\033]0;%s -- %s\007" "$HOST_UPPER" "$PWD" ;;
       esac
  fi
  syncHistory
}

HOST_UPPER=`echo $HOSTNAME | tr '[a-z]' '[A-Z]'`
PROMPT_COMMAND=promptCommand
#Color Prompt
PROMPT_COMMAND='PS1="\[\e[36;1m\]\u@\[\e[32;1m\]\h\[\e[34;1m\][\W]$(git_prompt) \[\e[31;1m\]<\#>\[\e[0m\] "'

PROMPT_COMMAND="$PROMPT_COMMAND; history -a; history -n"

if [ -d $HOME/chef ]
then
	cd ~$HOME/chef
fi
