#!/bin/sh


# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
NC='\033[0m' # No Color
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'


# https://stackoverflow.com/questions/6212219/passing-parameters-to-a-bash-function
# https://stackoverflow.com/questions/5615717/how-to-store-a-command-in-a-variable-in-linux
# https://stackoverflow.com/questions/17336915/return-value-in-a-bash-function
# $1 => Command to run
evaluate_test () {
  # https://stackoverflow.com/questions/11193466/echo-without-newline-in-a-shell-script
  eval $1 && printf "${GREEN}pass${NC}\n" || printf "${RED}fail${NC}\n"
}

evaluate () {
  eval $1
}

# $1 => Test Name
# $2 => Command to run
print_table_results () {
  local result=$(evaluate_test "$2")
  # https://stackoverflow.com/questions/6345429/how-do-i-print-some-text-in-bash-and-pad-it-with-spaces-to-a-certain-width
  printf "%-30s => [ %-6s ]\n" "$1" "$result"
}

# $1 => Test Name
# $2 => Command to run
print_data_row () {
  local result=$(evaluate "$2")
  # https://stackoverflow.com/questions/6345429/how-do-i-print-some-text-in-bash-and-pad-it-with-spaces-to-a-certain-width
  printf "%-12s => [ %-6s ]\n" "$1" "$result"
}

delimiter () {
  printf "${BLUE}******************************************${NC}\n"
}

validation_header () {
  printf "\n${CYAN}************ VALIDATING SETUP ************${NC}\n\n"
}

configuration_header () {
  printf "\n${CYAN}************* CONFIGURATION **************${NC}\n\n"
}


## Validation
validation_header
delimiter

## 1. Text Editor: VS Code or Atom
print_table_results "Installed VSCode" "command -v code >/dev/null 2>&1 && code -v | grep -q '1.'"
delimiter

## 2. Google Chrome
# https://unix.stackexchange.com/questions/63387/single-command-to-check-if-file-exists-and-print-custom-message-to-stdout
print_table_results "Installed Google Chrome" "[ -f /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome ] && /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --version | grep -q 'Google Chrome'"
delimiter

## 3. Install Xcode Command Line Tools
# https://apple.stackexchange.com/questions/219507/best-way-to-check-in-bash-if-command-line-tools-are-installed
# https://stackoverflow.com/questions/15371925/how-to-check-if-command-line-tools-is-installed
# https://stackoverflow.com/questions/21272479/how-can-i-find-out-if-i-have-xcode-commandline-tools-installed
print_table_results "Xcode Command Line Tools" 'type xcode-select >&- && xpath=$( xcode-select --print-path ) && test -d "${xpath}" && test -x "${xpath}"'
delimiter

## 4. Homebrew
# https://stackoverflow.com/questions/21577968/how-to-tell-if-homebrew-is-installed-on-mac-os-x
# https://stackoverflow.com/questions/592620/how-to-check-if-a-program-exists-from-a-bash-script
print_table_results "Homebrew" "command -v brew >/dev/null 2>&1"
delimiter

## 5. Node Version Manager (nvm)
# https://unix.stackexchange.com/questions/184508/nvm-command-not-available-in-bash-script
# https://stackoverflow.com/questions/39190575/bash-script-for-changing-nvm-node-version
. ~/.nvm/nvm.sh
print_table_results "Installed NVM" "command -v nvm >/dev/null 2>&1 && nvm --version | grep -q '[0-9]*\.[0-9]*\.[0-9]*'"
print_table_results "Installed Node" "command -v node | grep -q '/Users/.*/.nvm/versions/node/v.*/bin/node'"
print_table_results "Default Node (>=18)" '
  command -v nvm >/dev/null 2>&1 &&
  v="$(nvm version default 2>/dev/null)" &&
  [[ "$v" =~ ^v([0-9]+)\. ]] &&
  (( ${BASH_REMATCH[1]} >= 18 ))
'
delimiter

## 6. Python
print_table_results "Installed Python" "command -v python >/dev/null 2>&1 && which python | grep -q '/Users/.*/\.pyenv/shims/python'"
print_table_results "Default Python (3.8.13)" "command -v python >/dev/null 2>&1 && python -VV | grep -Fq 'Python 3.8.13 (default'"
delimiter

## 7. git
# https://stackoverflow.com/questions/12254076/how-do-i-show-my-global-git-config
print_table_results "Installed git" "command -v git >/dev/null 2>&1 && git version | grep -q 'git version'"
delimiter

configuration_header 
delimiter

## 8. github
print_table_results "Github user config" "command -v git >/dev/null 2>&1 && git config --list | grep -q 'user.name='"
print_table_results "Github email config" "command -v git >/dev/null 2>&1 && git config --list | grep -q 'user.email='"
echo "GitHub User Configuration:"
print_data_row "Name" "command -v git >/dev/null 2>&1 && git config user.name"
print_data_row "Email" "command -v git >/dev/null 2>&1 && git config user.email"
delimiter


