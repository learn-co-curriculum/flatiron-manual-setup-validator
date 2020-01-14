# # Xcode's command line tools are required for Homebrew
# xcode-select --install

# # Installs Homebrew
# ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# # Installs Git
# brew install git

# # If an ssh rsa key does not exist, creates one
# if [ ! -s ~/.ssh/id_rsa.pub ]
# then
#   ssh-keygen
# fi

# # Install common support libraries
# brew install gmp
# brew install gnupg

# # Installs Zsh and sets Zsh as the default shell
# brew install zsh
# chsh -s /bin/zsh

# # Installs RVM
# curl -sSL https://get.rvm.io | bash
# source ~/.zprofile

# # Installs Ruby 2.6.1 and sets it as default
# rvm install 2.6.1
# rvm --default use 2.6.1 

# # Installs Learn and Bundler
# gem update --system
# gem install learn-co
# gem install bundler

# # Installs SQLite
# brew install sqlite

# # We don't need these yet, but might as well install them
# gem install nokogiri
# gem install rails


# # Installs Node Version Manager
# curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
# echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zprofile
# echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"' >> ~/.zprofile
# source ~/.zprofile

# # Installs newest version of Node
# nvm install node
# nvm use node
# nvm alias default node

# # Backs up dot files
# mv ~/.irbrc{,.bak}
# mv ~/.gitignore{,.bak}
# mv ~/.zprofile{,.bak} 
# mv ~/.gitconfig{,.bak}

# # Adds additional functionality to IRB
# curl "https://raw.githubusercontent.com/flatiron-school/dotfiles/master/irbrc" -o "$HOME/.irbrc" 

# # Adds .gitignore content
# curl "https://raw.githubusercontent.com/flatiron-school/dotfiles/master/ubuntu-gitignore" -o "$HOME/.gitignore" 
# git config --global core.excludesfile $HOME/.gitignore

# # Adds .zprofile content
# curl "https://raw.githubusercontent.com/flatiron-school/dotfiles/master/.zprofile" -o "$HOME/.zprofile"

# # Sets default .gitconfig
# curl "https://raw.githubusercontent.com/flatiron-school/dotfiles/master/gitconfig" -o "$HOME/.gitconfig"

# # Fixes potential RVM PATH issues after dotfiles are modified
# rvm get stable --auto-dotfiles

checks_pass=true
if ! brew list | grep -q 'gmp'; then
  echo ""
  echo "WARNING: gmp was not installed properly! Try running 'brew install gmp' to resolve this"
  checks_pass=false
else
  echo ""
  echo -e "\xE2\x9C\x94 gmp installed with HomeBrew"
fi

if ! brew list | grep -q 'gnupg'; then 
  echo ""
  echo "WARNING: gnupg was not installed properly! Try running 'brew install gnupg' to resolve this"
  checks_pass=false
else
  echo ""
  echo -e "\xE2\x9C\x94 gnupg installed with HomeBrew"
fi

if ! gem list | grep -q 'learn-co '; then
  echo ""
  echo "WARNING: learn-co gem was not installed properly! This may be due to an incomplete installation of gnupg or gmp."
  echo "Try running 'brew install gmp && brew install gnupg' then 'gem install learn-co' to resolve this"
  checks_pass=false
else
  echo ""
  echo -e "\xE2\x9C\x94 learn-co gem installed"
fi

if ! rvm list | grep -q '=* ruby-2.6.1'; then
  echo ""
  echo "WARNING: Ruby 2.6.1 is not the default Ruby version"
  echo "Try running 'rvm --default use 2.6.1' to resolve this"
  echo ""
else 
  echo ""
  echo -e "\xE2\x9C\x94 Ruby 2.6.1 is set as default in RVM"
fi

if $checks_pass; then
  echo ""
  echo "#########################"
  echo "# INSTALLATION COMPLETE #"
  echo "#########################"
  echo ""
  echo "Next Steps:"
  echo ""
  echo "1. To configure Git with your personal GitHub account, you must add your username and email"
  echo ""
  echo "   - Type 'git config --global user.name <YOUR USERNAME>' to set your GitHub username"
  echo "   - Type 'git config --global user.email <YOUR EMAIL>' to set your GitHub email"
  echo ""
  echo "2. To add your SSH key to GitHub, copy the following key (including the 'ssh-rsa' at the beginning)"
  echo ""
  cat ~/.ssh/id_rsa.pub
  echo ""
  echo "   Go to your account settings at https://github.com/ and add this as a new SSH key"
  echo ""
  echo "3. To configure the Learn gem with your personal account"
  echo ""
  echo "   - Go to learn.co/<your-github-username>. At the bottom of the page is an OAuth token"
  echo "   - Copy this token"
  echo "   - Run 'learn whoami' in the terminal to start the setup process"
  echo "   - Paste your token into the terminal when prompted"
  echo ""
  echo "4. Get a Text Editor and set it as the default editor in ~/.learn-config"
  echo ""
  echo "5. Install Chrome and Slack"
  echo ""
  echo "Run the following to verify successful installation:"
  echo ""
  echo "curl -so- https://raw.githubusercontent.com/learn-co-curriculum/flatiron-manual-setup-validator/master/manual-setup-check.sh | bash 2> /dev/null"
  echo ""
  echo "See https://github.com/learn-co-curriculum/environment-mac-os-catalina-setup for more information"
else
  echo ""
  echo "================================="
  echo "================================="
  echo "WARNING: Installation incomplete!"
  echo "================================="
  echo "================================="
  echo ""
  echo "> Follow the manual installation steps here to ensure everything is configured correctly: https://github.com/learn-co-curriculum/environment-mac-os-catalina-setup/blob/master/README.md#step-by-step-instructions-for-manual-installation"
  echo ""
  echo "> Use the validator script to see what has and hasn't installed correctly: https://github.com/learn-co-curriculum/environment-mac-os-catalina-setup/blob/master/README.md#verify-installations"
  echo ""
fi
