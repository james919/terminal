#! /bin/bash

ECHO "Install Powerline fonts."
#git clone https://github.com/powerline/fonts.git && cd fonts && ./install.sh
git clone https://github.com/powerline/fonts.git
osascript -e 'tell app "Terminal"
   do script "cd fonts; ./install.sh"
end tell'

ECHO "Install Homebrew package manager."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

ECHO "Install zsh shell."
brew install zsh zsh-completions

ECHO "Change Shell to zsh."
sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)

ECHO "Install Oh-My-Zsh, an open source community-driven framework for managing your ZSH configuration."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

ECHO "....."
ECHO "Edit ~/.zshrc"
ECHO "Look for the following lines and replace their values:"
ECHO "     ZSH_THEME=\"agnoster\""
ECHO "     plugins=("
ECHO "       git zsh-syntax-highlighting"
ECHO "     )"
ECHO "In the \"EDITOR\" section, make nano the default editor:"
ECHO "     export EDITOR='nano'"
ECHO "In the \"# Aliases\" section, add an alias to Sublime Text:"
ECHO "     alias sublime=\"open -a 'Sublime Text'\""
ECHO "....."

osascript -e 'tell app "Terminal"
   do script "nano ~/.zshrc"
end tell'
