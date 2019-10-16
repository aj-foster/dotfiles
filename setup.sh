#!/bin/sh

# Helpers
#
continue_or_exit() {
  read -r -p "${1:-Continue?} [y/N] " response
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

# Git
#
if [ -z $(which git) ]
then
  echo "${RED}✗ Git${NC}"
  continue_or_exit "Install Git?"
  brew install git
else
  echo "${GREEN}✓ Git${NC}"
fi

# Oh my ZSH
#
if [ ! -d ~/.oh-my-zsh ]
then
  echo "${RED}✗ Oh-my-zsh${NC}"
  continue_or_exit "Install Oh-my-zsh?"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  echo "${GREEN}✓ Oh-my-zsh${NC}"
fi

# Oh My ZSH Plugins
#
if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]
then
  echo "${RED}✗ zsh Autosuggestions${NC}"
  continue_or_exit "Install zsh Autosuggestions?"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
  echo "${GREEN}✓ zsh Autosuggestions${NC}"
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]
then
  echo "${RED}✗ zsh Syntax Highlighting${NC}"
  continue_or_exit "Install zsh Syntax Highlighting?"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
  echo "${GREEN}✓ zsh Syntax Highlighting${NC}"
fi

