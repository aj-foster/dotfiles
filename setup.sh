#!/bin/sh

# Helpers
#
continue_or_exit() {
  read -r -p "${1:-Continue?} [y/N]" response
  case "$response" in
    [yY][eE][sS]|[yY]) 
      true
      ;;
    *)
      exit
      ;;
  esac
}

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Homebrew
#
if [ -z $(which brew) ]
then
  echo "${RED}✗ Homebrew${NC}"
  continue_or_exit "Install Homebrew?"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "${GREEN}✓ Homebrew${NC}"
fi

# Oh my ZSH
#
if [ ! -d ~/.oh-my-zsh ]
then
  echo "${RED}✗ Oh-My-ZSH${NC}"
  continue_or_exit "Install Oh-My-ZSH?"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  echo "${GREEN}✓ Oh-My-ZSH${NC}"
fi
