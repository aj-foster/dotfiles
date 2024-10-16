# AJ's Custom Theme
#

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=" ❯ "
ZSH_THEME_GIT_PROMPT_SEPARATOR=" "
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[blue]%}"

aj_pwd() {
  local dir=$(pwd)

  if [[ $dir == $HOME ]]
  then
    echo "~"
    return
  fi

  if [[ $dir == "/workspace" ]]
  then 
    echo "."
    return
  fi

  echo $(basename $dir)
}

PROMPT='AJ ❯ %{$fg[magenta]%}$(aj_pwd)%{$reset_color%} ❯ $(git_super_status)'
RPROMPT=''
