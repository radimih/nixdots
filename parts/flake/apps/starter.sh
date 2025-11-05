set +o errexit

DOTFILES_URL=git@github.com/radimih/nixdots.git

NIXOS_CONFIG_FILE=/etc/nixos/configuration.nix
TOKEN_FILE="$HOME/github.token"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

START_MSG="
This script does the following:

1. Updates the\033[1m NixOS configuration file\033[22m (\033[2m$NIXOS_CONFIG_FILE\033[22m):
     - enables experimental features
     - adds the\033[2m git\033[22m and\033[2m vim\033[22m programs to the system packages

2. Generates\033[1m user's ssh key\033[22m if it does do not exist

3. Adds the\033[1m public key\033[22m of this ssh key to \033[4mGitHub\033[0m if it is not already added

4. Clones dotfiles repo \033[4m$DOTFILES_URL\033[0m to home directory

5. Prepares host folder in parts/hosts

Let's go!
"
FINISH_MSG="
Run the following commands to make the changes in the NixOS configuration take effect:

 \033[1m sudo nixos-rebuild switch\033[22m
"

main()
{
  local hostname

  clear
  echo -e "$START_MSG"

  hostname=$(input_hostname)
  set_github_token
  validate_github_token

  echo -e "$FINISH_MSG"
}

input_hostname()
{
    local hostname_input=""

    while true
    do
      read -e -p "Enter new hostname (only Latin letters, numbers and symbols '-', '_'): " -i "$hostname_input" hostname_input
      if [[ -z "$hostname_input" ]]; then continue; fi
      if [[ "$hostname_input" =~ ^[a-zA-Z0-9_-]+$ ]]; then break; fi
    done

    echo "$hostname_input"
}

set_github_token()
{
  while true
  do
    if [ ! -f $TOKEN_FILE ]
    then
      read -e -p "Enter GitHub token: " token
      echo "$token" > $TOKEN_FILE
    fi

    token=$(cat $TOKEN_FILE)
    hash=$(echo "$token" | sha256sum | awk '{print $1}')
    hash_short=${hash:0:3}...${hash: -3}

    echo -e "──────────────────────────────────────────────────────────────────────────"
    echo -e "GitHub token stored in the\033[2m $TOKEN_FILE\033[22m file:"
    echo -e "  token: $token"
    echo -e "  sha256sum: $hash_short"
    echo -e "──────────────────────────────────────────────────────────────────────────"

    read -p "Is this token correct? (y/n): " answer

    if [[ "$answer" =~ ^[Yy]$ ]]
    then
      break
    else
      read -e -i "$token" -p "Edit the token: " new_token
      echo "$new_token" > $TOKEN_FILE
    fi
  done

  export GITHUB_TOKEN=$(cat $TOKEN_FILE)
}

validate_github_token()
{
  print_step_msg "validate GitHub token..."
  gh auth status
  if [[ $? -ne 0 ]]
  then
    print_error_msg "the GitHub token may have expired"
    exit 1
  fi
}

print_error_msg()
{
  echo
  echo -e "${RED}starter: $1${NC}"
  echo
}

print_step_msg()
{
  echo
  echo -e "${GREEN}starter: $1${NC}"
  echo
}

main
