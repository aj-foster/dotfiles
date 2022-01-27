#!/bin/sh

# Helpers
#
continue_or_exit() {
  read -r -p "${1:-Continue?} [Y/n] " response
  case "$response" in
    [nN][oO]|[nN]) 
      exit
      ;;
    *)
      true
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
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  export PATH=/opt/homebrew/bin:$PATH
  brew tap homebrew/bundle
  brew bundle --file=~/.files/brew/common.brewfile
else
  echo "${GREEN}✓ Homebrew${NC}"
fi

# Git Config
#
if [ ! -L ~/.gitconfig ]
then
  echo "${RED}✗ Git Configuration File${NC}"
  continue_or_exit "Install Git Configuration File?"

  if [ -f ~/.gitconfig ]
  then
    mv -i ~/.gitconfig ~/.gitconfig.pre-setup
  fi

  ln -s ~/.files/git/gitconfig ~/.gitconfig
  mkdir -p ~/.ssh
  ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
else
  echo "${GREEN}✓ Git Configuration File${NC}"
fi

# Git Completions
#
if [ ! -d ~/.zsh ]
then
  mkdir ~/.zsh
fi

if [ ! -f ~/.zsh/_git ]
then
  echo "${RED}✗ Oh-my-zsh${NC}"
  continue_or_exit "Install Git Completions?"
  curl -o ~/.zsh/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
  curl -o ~/.zsh/_git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
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

ASDF_PLUGINS=$(asdf plugin-list)

if [ -z $(echo "$ASDF_PLUGINS" | grep erlang) ]
then
  echo "${RED}✗ ASDF Erlang Plugin${NC}"
  continue_or_exit "Install ASDF Erlang Plugin?"
  asdf plugin-add erlang
else
  echo "${GREEN}✓ ASDF Erlang Plugin${NC}"
fi

if [ -z $(echo "$ASDF_PLUGINS" | grep elixir) ]
then
  echo "${RED}✗ ASDF Elixir Plugin${NC}"
  continue_or_exit "Install ASDF Elixir Plugin?"
  asdf plugin-add elixir
else
  echo "${GREEN}✓ ASDF Elixir Plugin${NC}"
fi

if [ -z $(echo "$ASDF_PLUGINS" | grep nodejs) ]
then
  echo "${RED}✗ ASDF Node.js Plugin${NC}"
  continue_or_exit "Install ASDF Node.js Plugin?"
  asdf plugin-add nodejs
else
  echo "${GREEN}✓ ASDF Node.js Plugin${NC}"
fi

# Nano Editor
#
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

if [ ! -d ~/.nano ]
then
  echo "${RED}✗ Nano Syntax Highlighting${NC}"
  continue_or_exit "Install Nano Syntax Highlighting?"
  git clone https://github.com/scopatz/nanorc.git ~/.nano
else
  echo "${GREEN}✓ Nano Syntax Highlighting${NC}"
fi

# SSH Config
#
if [ ! -L ~/.ssh/config ]
then
  echo "${RED}✗ SSH Configuration File${NC}"
  continue_or_exit "Install SSH Configuration File?"

  if [ -f ~/.ssh/config ]
  then
    mv -i ~/.ssh/config ~/.ssh/config.pre-setup
  fi

  mkdir -p ~/.ssh
  ln -s ~/.files/ssh/config ~/.ssh/config
else
  echo "${GREEN}✓ SSH Configuration File${NC}"
fi

# tmux
#
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
