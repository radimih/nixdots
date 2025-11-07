GIT_DOTFILES_URL=github.com/radimih/nixdots
# GIT_SECRETS_URL=github.com/radimih/nixdots-secrets
HOME_DOTFILES_DIR=$HOME/1git/personal

NIXOS_CONFIG_FILE=/etc/nixos/configuration.nix
SSH_KEYFILE_HOST=/etc/ssh/ssh_host_ed25519_key
SSH_KEYFILE_USER=$HOME/.ssh/id_ed25519
# SSH_KEYFILE_HOST=./key-host
# SSH_KEYFILE_USER=./key-user
TOKEN_FILE=$HOME/github.token

CL_GREEN='\033[0;32m'
CL_RED='\033[0;31m'
CL_YELLOW='\033[1;33m'
CL_NO='\033[0m'
ST_BOLD='\033[1m'
ST_DIM='\033[2m'
ST_REGULAR='\033[22m'
ST_RESET='\033[0m'
ST_UNDERLINE='\033[4m'

START_MSG="
This script does the following:

1. Generates host and user ${ST_BOLD}SSH keys${ST_REGULAR} if they do not exist

2. Adds the ${ST_BOLD}user's public SSH key${ST_REGULAR} to ${ST_UNDERLINE}GitHub${ST_RESET} if it is not already added

3. Clones dotfiles repo ${ST_UNDERLINE}$GIT_DOTFILES_URL${ST_RESET} into directory ${ST_DIM}$HOME_DOTFILES_DIR${ST_REGULAR}

4. Prepares host folder in parts/hosts

5. Updates the ${ST_BOLD}NixOS configuration file${ST_REGULAR} (${ST_DIM}$NIXOS_CONFIG_FILE${ST_REGULAR}):
     - enables experimental features
     - adds the ${ST_DIM}git${ST_REGULAR} and ${ST_DIM}vim${ST_REGULAR} programs to the system packages

Let's go!
"
FINISH_MSG="
Run the following commands to make the changes in the NixOS configuration take effect:

  ${ST_BOLD}sudo nixos-rebuild switch${ST_REGULAR}
"

main() {

  clear
  echo -e "$START_MSG"

  local hostname=$(input_hostname)
  echo

  set_github_token
  validate_github_token
  generate_ssh_keys "$hostname"
  add_key_to_github "$hostname"

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
    echo -e "GitHub token stored in the ${ST_DIM}$TOKEN_FILE${ST_REGULAR} file:"
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

  print_step_msg "Validate GitHub token"

  set +o errexit
  if ! gh auth status;
  then
    print_error_msg "the GitHub token may have expired"
    exit 1
  fi
  set -o errexit

  pause
}

generate_ssh_keys() {

  local hostname=$1

  print_step_msg "Generate host and user SSH keys"
  sudo --validate
  echo

  generate_ssh_key "$hostname" "$SSH_KEYFILE_HOST" sudo
  generate_ssh_key "$hostname" "$SSH_KEYFILE_USER"

  print_line_msg "host's public key: $(cat "$SSH_KEYFILE_HOST.pub")"
  print_line_msg "user's public key: $(cat "$SSH_KEYFILE_USER.pub")"
  pause
}

generate_ssh_key() {

  local hostname=$1
  local keyfile=$2
  local sudo=${3:-}

  print_line_msg "generate ${ST_DIM}$keyfile${ST_REGULAR}..."

  [[ -z "$sudo" ]] && username=$USER || username=host

  if [[ -f $keyfile ]]
  then
    $sudo ssh-keygen -f "$keyfile" -c -C "$username@$hostname" -q > /dev/null
    print_line_msg "... SSH key ${ST_DIM}$keyfile${ST_REGULAR} already exists, updated key comment"
  else
    # Сгенерировать ключ без защиты паролем
    $sudo ssh-keygen -t ed25519 -N "" -f "$keyfile" -C "$username@$hostname"
  fi
  echo
}

add_key_to_github() {

  local hostname=$1

  local user_pubkey_file=$SSH_KEYFILE_USER.pub

  local new_key_title="$USER-$hostname"
  local new_key_pub="$(cat $user_pubkey_file | awk '{ print $2 }')"
  local github_keys="$(gh ssh-key list)"

  print_step_msg "Add the user's public SSH key to GitHub"

  print_line_msg "add user's public SSH key for ${ST_DIM}authentication${ST_REGULAR} and ${ST_DIM}signing${ST_REGULAR}:"
  print_line_msg "  title: ${ST_BOLD}$new_key_title${ST_REGULAR}"
  print_line_msg "    key: $new_key_pub"
  echo

  print_line_msg "current list of all public keys on the GitHub:"
  echo
  gh ssh-key list  # вывод в консоль отличается от вывода в пайп ($github_keys)
  pause

  for key_type in authentication signing
  do
    # Получить имя ключа на GitHub по его публичной части. GitHub не позволяет
    # хранить один и тот же ключ под разными именами
    local github_key_title=$(echo "$github_keys" | awk -v key="$new_key_pub" -v type="$key_type" '$3 == key && $6 == type { print $1; exit }')

    # Если на GitHub нет такого ключа
    if [[ -z "$github_key_title" ]]
    then
      # Если на GitHub есть другой ключ с таким именем (фактически происходит замена ключа)
      if echo "$github_keys" | awk '{ print $1 }' | grep -q "$new_key_title";
      then
        print_line_msg "... replacing user's public SSH key for ${ST_DIM}$key_type${ST_REGULAR}"
        remove_key_from_github "$new_key_title" "$key_type" "$github_keys"
      fi
    elif [[ "$github_key_title" == "$new_key_title" ]]
    then
      print_line_msg "... user public SSH key ${ST_BOLD}$new_key_title${ST_REGULAR} for ${ST_DIM}$key_type${ST_REGULAR} already exists"
      continue
    else
      # Фактически происходит переименование ключа
      print_line_msg "... renaming user's public SSH key for ${ST_DIM}$key_type${ST_REGULAR} from ${ST_BOLD}$github_key_title${ST_REGULAR} to ${ST_BOLD}$new_key_title${ST_REGULAR}"
      remove_key_from_github "$github_key_title" "$key_type" "$github_keys"
    fi
    gh ssh-key add $user_pubkey_file --title "$new_key_title" --type "$key_type"
  done

  echo
  print_line_msg "new list of all public keys on the GitHub:"
  echo
  gh ssh-key list  # вывод в консоль отличается от вывода в пайп ($github_keys)
}

remove_key_from_github() {

  local key_title="$1"
  local key_type="$2"
  local key_list="$3"

  local key_id=$(echo "$key_list" | awk -v title="$key_title" -v type="$key_type" '$1 == title && $6 == type { print $5; exit }')

  # К сожалению, signing-ключи нельзя удалять командой gh ssh-key delete, получаем ошибку
  # HTTP 404: Not Found (https://api.github.com/user/keys/ID) - не тот URI
  if [[ "$key_type" == "signing" ]]
  then
    # https://docs.github.com/en/rest/users/ssh-signing-keys?apiVersion=2022-11-28#delete-an-ssh-signing-key-for-the-authenticated-user
    gh api \
      --method DELETE \
      -H "Accept: application/vnd.github+json" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      /user/ssh_signing_keys/$key_id
  else
    gh ssh-key delete "$key_id" --yes
  fi
}

pause() {

  echo
  echo -n -e "${CL_YELLOW}press ENTER to continue$1${CL_NO}"
  read
}

print_error_msg() {

  echo
  echo -e "${CL_RED}$1${CL_NO}"
  echo
}

print_line_msg() {

  echo -e "${CL_GREEN}$1${CL_NO}"
}

print_step_msg() {

  local msg="┤ $1 │"
  local width=80

  local len=${#msg}
  local pad=$((width - len))

  local filler="─"
  while (( ${#filler} < pad )); do
      filler+="$filler"
  done
  filler="${filler:0:$pad}"

  printf "\\n${CL_GREEN}%s%s${CL_NO}\\n\\n" "$filler" "$msg"
}

main
