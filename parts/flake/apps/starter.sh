GIT_DOTFILES_URL=github.com/radimih/nixdots
# GIT_SECRETS_URL=github.com/radimih/nixdots-secrets
HOME_DOTFILES_DIR=$HOME/1git/personal

NIXOS_CONFIG_FILE=/etc/nixos/configuration.nix
SSH_KEYFILE_HOST=/etc/ssh/ssh_host_ed25519_key
SSH_KEYFILE_USER=$HOME/.ssh/id_ed25519
TOKEN_FILE=$HOME/github.token

GREEN='\033[0;32m'
RED='\033[0;31m'
# YELLOW='\033[1;33m'
NC='\033[0m'

START_MSG="
This script does the following:

1. Generates host and user\033[1m SSH keys\033[22m if they do not exist

2. Adds the\033[1m public user SSH key\033[22m to \033[4mGitHub\033[0m if it is not already added

3. Clones dotfiles repo \033[4m$GIT_DOTFILES_URL\033[0m into directory \033[2m$HOME_DOTFILES_DIR\033[22m

4. Prepares host folder in parts/hosts

5. Updates the\033[1m NixOS configuration file\033[22m (\033[2m$NIXOS_CONFIG_FILE\033[22m):
     - enables experimental features
     - adds the\033[2m git\033[22m and\033[2m vim\033[22m programs to the system packages

Let's go!
"
FINISH_MSG="
Run the following commands to make the changes in the NixOS configuration take effect:

 \033[1m sudo nixos-rebuild switch\033[22m
"

main() {

  local hostname

  clear
  echo -e "$START_MSG"

  hostname=$(input_hostname)
  echo
  set_github_token

  print_step_msg "validate GitHub token..."
  validate_github_token

  print_step_msg "generate host and user SSH keys..."

  sudo --validate
  echo

  generate_ssh_keys "$hostname"

  echo -e "$FINISH_MSG"
}

input_hostname() {

  local hostname_input=""

  while true
  do
    read -r -e -p "Enter new hostname (only Latin letters, numbers and symbols '-', '_'): " -i "$hostname_input" hostname_input
    if [[ -z "$hostname_input" ]]; then continue; fi
    if [[ "$hostname_input" =~ ^[a-zA-Z0-9_-]+$ ]]; then break; fi
  done

  echo "$hostname_input"
}

set_github_token() {

  while true
  do
    if [ ! -f "$TOKEN_FILE" ]
    then
      read -r -e -p "Enter GitHub token: " token
      echo "$token" > "$TOKEN_FILE"
    fi

    token=$(cat "$TOKEN_FILE")
    hash=$(echo "$token" | sha256sum | awk '{print $1}')
    hash_short=${hash:0:3}...${hash: -3}

    echo -e "──────────────────────────────────────────────────────────────────────────"
    echo -e "GitHub token stored in the\033[2m $TOKEN_FILE\033[22m file:"
    echo -e "  token: $token"
    echo -e "  sha256sum: $hash_short"
    echo -e "──────────────────────────────────────────────────────────────────────────"

    read -r -p "Is this token correct? (y/n): " answer

    if [[ "$answer" =~ ^[Yy]$ ]]
    then
      break
    else
      read -r -e -i "$token" -p "Edit the token: " new_token
      echo "$new_token" > "$TOKEN_FILE"
    fi
  done

  GITHUB_TOKEN=$(cat "$TOKEN_FILE")
  export GITHUB_TOKEN
}

validate_github_token() {

  set +o errexit
  if ! gh auth status;
  then
    print_error_msg "the GitHub token may have expired"
    exit 1
  fi
  set -o errexit
}

generate_ssh_keys() {

  local hostname_new=$1

  generate_ssh_key "$hostname_new" "$SSH_KEYFILE_HOST" sudo
  generate_ssh_key "$hostname_new" "$SSH_KEYFILE_USER"
}

generate_ssh_key() {

  local hostname_new=$1
  local keyfile=$2
  local sudo=${3:-}

  print_step_msg "generate $keyfile..."

  [[ -z "$sudo" ]] && username=$USER || username=host

  if [[ -f $keyfile ]]
  then
    $sudo ssh-keygen -f "$keyfile" -c -C "$username@$hostname_new" -q > /dev/null
    print_step_msg "... SSH key '$keyfile' already exists, updated key comment"
  else
    # Generate key pair without passphrase
    $sudo ssh-keygen -t ed25519 -N "" -f "$keyfile" -C "$username@$hostname_new"
  fi
  echo
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
