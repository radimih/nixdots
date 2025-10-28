DOTFILES_URL=git@github.com/radimih/nixdots.git
NIXOS_CONFIG_FILE=/etc/nixos/configuration.nix

START_MSG="
This script does the following:

1. Updates the\033[1m NixOS configuration file\033[22m (\033[2m$NIXOS_CONFIG_FILE\033[22m):
     - enables experimental features
     - adds the\033[2m git\033[22m and\033[2m vim\033[22m programs to the system packages

2. Generates\033[1m user's ssh key\033[22m if it does do not exist

3. Adds the\033[1m user's public ssh key\033[22m to \033[4mGitHub\033[0m if it hasn't been added yet

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
    local github_repo

    clear
    echo -e "$START_MSG"
}

main
