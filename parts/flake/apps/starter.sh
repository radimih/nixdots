DOTFILES_URL=git@github.com/radimih/nixdots.git

NIXOS_CONFIG_FILE=/etc/nixos/configuration.nix
TOKEN_FILE="$HOME/github.token"

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
---------
"
FINISH_MSG="
Run the following commands to make the changes in the NixOS configuration take effect:

 \033[1m sudo nixos-rebuild switch\033[22m
"

main() {

  local hostname_new

  clear
  echo -e "$START_MSG"

  input_github_token
  validate_github_token
}

input_github_token() {

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

    echo -e "--------------------------------------------------------------------------"
    echo -e "GitHub token stored in the\033[2m $TOKEN_FILE\033[22m file:"
    echo -e "  token: $token"
    echo -e "  sha256sum: $hash_short"
    echo -e "--------------------------------------------------------------------------"

    read -p "Is this token correct? (y/n): " answer

    if [[ "$answer" =~ ^[Yy]$ ]]
    then
      break
    else
      read -e -i "$token" -p "Edit the token: " new_token
      echo "$new_token" > $TOKEN_FILE
    fi
  done

  GITHUB_TOKEN=$(cat $TOKEN_FILE)
}

validate_github_token() {
  echo
}

main
