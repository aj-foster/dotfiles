# AJ's Custom Theme
#

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=" ❯ "
ZSH_THEME_GIT_PROMPT_SEPARATOR=" "
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[blue]%}"

PROMPT='AJ ❯ %{$fg[magenta]%}%1~%{$reset_color%} ❯ $(git_super_status)'
RPROMPT=''
