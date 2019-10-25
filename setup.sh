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

# For later...
#
BREW_LIST=$(brew list)

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

if [ -z $(which hub) ]
then
  echo "${RED}✗ Hub (Git add-on)${NC}"
  continue_or_exit "Install Hub?"
  brew install hub
else
  echo "${GREEN}✓ Hub (Git add-on)${NC}"
fi

if [ ! -L ~/.gitconfig ]
then
  echo "${RED}✗ Git Configuration File${NC}"
  continue_or_exit "Install Git Configuration File?"

  if [ -f ~/.gitconfig ]
  then
    mv -i ~/.gitconfig ~/.gitconfig.pre-setup
  fi

  ln -s ~/.files/git/gitconfig ~/.gitconfig
else
  echo "${GREEN}✓ Git Configuration File${NC}"
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

if [ ! -L ~/.oh-my-zsh/custom/themes/aj.zsh-theme ]
then
  echo "${RED}✗ Oh-my-zsh Theme${NC}"
  continue_or_exit "Install Oh-my-zsh Theme?"

  if [ -f ~/.oh-my-zsh/custom/themes/aj.zsh-theme ]
  then
    mv -i ~/.oh-my-zsh/custom/themes/aj.zsh-theme ~/.oh-my-zsh/custom/themes/aj.zsh-theme.pre-setup
  fi

  ln -s ~/.files/zsh/aj.zsh-theme ~/.oh-my-zsh/custom/themes/aj.zsh-theme
else
  echo "${GREEN}✓ Oh-my-zsh Theme${NC}"
fi

if [ ! -L ~/.zshrc ]
then
  echo "${RED}✗ zsh Configuration File${NC}"
  continue_or_exit "Install zsh Configuration File?"

  if [ -f ~/.zshrc ]
  then
    mv -i ~/.zshrc ~/.zshrc.pre-setup
  fi

  ln -s ~/.files/zsh/zshrc ~/.zshrc
else
  echo "${GREEN}✓ zsh Configuration File${NC}"
fi

if [ ! -f ~/.zshrc_local ]
then
  touch ~/.zshrc_local
fi

if [ ! -L ~/.inputrc ]
then
  echo "${RED}✗ inputrc Configuration File${NC}"
  continue_or_exit "Install inputrc Configuration File?"

  if [ -f ~/.inputrc ]
  then
    mv -i ~/.inputrc ~/.inputrc.pre-setup
  fi

  ln -s ~/.files/bash/inputrc ~/.inputrc
else
  echo "${GREEN}✓ inputrc Configuration File${NC}"
fi

if [ ! -L ~/.bash_profile ]
then
  echo "${RED}✗ bash Configuration File${NC}"
  continue_or_exit "Install bash Configuration File?"

  if [ -f ~/.bash_profile ]
  then
    mv -i ~/.bash_profile ~/.bash_profile.pre-setup
  fi

  ln -s ~/.files/bash/bash_profile ~/.bash_profile
else
  echo "${GREEN}✓ bash Configuration File${NC}"
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

# ASDF Version Manager
#
if [ -z $(which asdf) ]
then
  echo "${RED}✗ ASDF${NC}"
  continue_or_exit "Install ASDF?"
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  cd ~/.asdf
  git checkout "$(git describe --abbrev=0 --tags)"
else
  echo "${GREEN}✓ ASDF${NC}"
fi

if [ ! -L ~/.asdfrc ]
then
  echo "${RED}✗ ASDF Configuration File${NC}"
  continue_or_exit "Install ASDF Configuration File?"

  if [ -f ~/.asdfrc ]
  then
    mv -i ~/.asdfrc ~/.asdfrc.pre-setup
  fi

  ln -s ~/.files/asdf/asdfrc ~/.asdfrc
else
  echo "${GREEN}✓ ASDF Configuration File${NC}"
fi

# Nano Editor
#
if [ -z $(echo "$BREW_LIST" | grep nano) ]
then
  echo "${RED}✗ Nano (upgrade)${NC}"
  continue_or_exit "Install Nano (upgrade)?"
  brew install nano
else
  echo "${GREEN}✓ Nano (upgrade)${NC}"
fi

if [ ! -L ~/.nanorc ]
then
  echo "${RED}✗ Nano Configuration File${NC}"
  continue_or_exit "Install Nano Configuration File?"

  if [ -f ~/.nanorc ]
  then
    mv -i ~/.nanorc ~/.nanorc.pre-setup
  fi

  ln -s ~/.files/nano/nanorc ~/.nanorc
else
  echo "${GREEN}✓ Nano Configuration File${NC}"
fi

if [ ! -d .nano ]
then
  echo "${RED}✗ Nano Syntax Highlighting${NC}"
  continue_or_exit "Install Nano Syntax Highlighting?"
  git clone https://github.com/scopatz/nanorc.git ~/.nano
else
  echo "${GREEN}✓ Nano Syntax Highlighting${NC}"
fi

# tmux
#
if [ -z $(echo "$BREW_LIST" | grep tmux) ]
then
  echo "${RED}✗ tmux (upgrade)${NC}"
  continue_or_exit "Install tmux (upgrade)?"
  brew install tmux
else
  echo "${GREEN}✓ tmux (upgrade)${NC}"
fi

if [ ! -L ~/.tmux.conf ]
then
  echo "${RED}✗ tmux Configuration File${NC}"
  continue_or_exit "Install tmux Configuration File?"

  if [ -f ~/.tmux.conf ]
  then
    mv -i ~/.tmux.conf ~/.tmux.conf.pre-setup
  fi

  ln -s ~/.files/tmux/tmux.conf ~/.tmux.conf
else
  echo "${GREEN}✓ tmux Configuration File${NC}"
fi
