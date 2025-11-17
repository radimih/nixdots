# FIXME: remove
# set -o errexit
# set -o pipefail

GIT_REPO_DOTFILES=git@github.com:radimih/nixdots.git
HOME_DOTFILES_DIR=$HOME/1git/personal
DOTFILES_HOSTS_SUBDIR=parts/hosts

STARTER_PACKAGES="git vim"  # ВНИМАНИЕ! Предполагается, что бинарник у пакета = названию пакета
STARTER_NIX_MODULE=\
'{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ '$STARTER_PACKAGES' ];
  nix.settings.experimental-features = [ "flakes" "nix-command" ];
}'

NIX_CONFIG_FILE=/etc/nix/nix.conf
NIXOS_CONFIG_FILE=/etc/nixos/configuration.nix
NIXOS_HW_CONFIG_FILE=/etc/nixos/hardware-configuration.nix
SSH_KEYFILE_HOST=/etc/ssh/ssh_host_ed25519_key
SSH_KEYFILE_USER=$HOME/.ssh/id_ed25519
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

1. Updates the ${ST_BOLD}NixOS configuration file${ST_REGULAR} (${ST_DIM}${NIXOS_CONFIG_FILE}${ST_REGULAR}):
     - enables experimental features
     - adds the ${ST_DIM}${STARTER_PACKAGES}${ST_REGULAR} programs to the system packages

2. Generates host and user ${ST_BOLD}SSH keys${ST_REGULAR} if they do not exist

3. Receives the ${ST_BOLD}GitHub token${ST_REGULAR} from the user and verifies it

4. Adds the ${ST_BOLD}user's public SSH key${ST_REGULAR} to ${ST_UNDERLINE}GitHub${ST_RESET} if it is not already added

5. Clones dotfiles repo ${ST_UNDERLINE}${GIT_REPO_DOTFILES}${ST_RESET} into directory ${ST_DIM}${HOME_DOTFILES_DIR}${ST_REGULAR}

6. Prepares ${ST_BOLD}host directory${ST_REGULAR} in dotfiles directory ${ST_DIM}${DOTFILES_HOSTS_SUBDIR}${ST_REGULAR}:
     - makes the host directory ${ST_DIM}${DOTFILES_HOSTS_SUBDIR}/<hostname>${ST_REGULAR}
     - copies file ${ST_DIM}${hardware_file}${ST_REGULAR} to host directory ${ST_DIM}${host_dir}${ST_REGULAR}
     - copies host public key${ST_DIM}${SSH_KEYFILE_HOST}.pub${ST_REGULAR} to host directory ${ST_DIM}${host_dir}${ST_REGULAR} under the name ${ST_DIM}${pubkey_name}${ST_REGULAR}

Let's go!
"
FINISH_MSG="
"

main() {

  clear
  echo -e "$START_MSG"

  local hostname
  hostname=$(input_hostname)
  echo

  update_system_config
  generate_ssh_keys "$hostname"
  verify_github_token
  add_key_to_github "$hostname"
  clone_dotfiles_repo
  prepare_host_dir "$hostname"

  echo -e "$FINISH_MSG"
}

input_hostname() {

  local hostname_input=""

  while true; do
    read -r -e -p "Enter new hostname (only Latin letters, numbers and symbols '-', '_'): " -i "$hostname_input" hostname_input
    if [[ -z "$hostname_input" ]]; then continue; fi
    if [[ "$hostname_input" =~ ^[a-zA-Z0-9_-]+$ ]]; then break; fi
  done

  echo "$hostname_input"
}

update_system_config() {

  print_step_msg "Updating NixOS configuration"
  sudo --validate
  echo

  print_line_msg "the following ${ST_DIM}$(dirname "$NIXOS_CONFIG_FILE")/starter.nix${ST_REGULAR} module will be added to the NixOS configuration:"
  echo
  echo "$STARTER_NIX_MODULE"
  pause
  echo
  enable_starter_module

  if is_enabled_experimental_features && \
     is_enabled_system_packages "$STARTER_PACKAGES"; then
    print_line_msg "... ${ST_DIM}${STARTER_PACKAGES}${ST_REGULAR} system packages and ${ST_DIM}flakes nix-command${ST_REGULAR} experimental features already enabled"
    return 0
  else
    print_line_msg "the command ${ST_DIM}sudo nixos-rebuild switch${ST_REGULAR} will be run to make the changes in the NixOS configuration take effect"
    pause
  fi

  sudo nixos-rebuild switch
  pause
}

enable_starter_module() {

  local starter_file
  starter_file="$(dirname "$NIXOS_CONFIG_FILE")/starter.nix"

  echo "$STARTER_NIX_MODULE" | sudo tee "$starter_file" > /dev/null

  # Проверить, есть ли уже ./starter.nix в конфигурационном файле NixOS
  if grep --silent --no-messages './starter.nix' "$NIXOS_CONFIG_FILE"; then return 0; fi

  # Вставить строку '      ./starter.nix' в imports после ./hardware-configuration.nix
  sudo sed --in-place '/^\s*\.\/hardware-configuration\.nix\s*$/a\ \ \ \ \ \ .\/starter.nix' "$NIXOS_CONFIG_FILE"
}

# ВНИМАНИЕ! Проверяется только на одну экспериментальную функцию: flakes
is_enabled_experimental_features() {

  local regex_flakes='^[[:space:]]*(extra-)?experimental-features[[:space:]]*=[[:space:]]*([a-zA-Z-]+[[:space:]]+)*flakes([[:space:]]+[a-zA-Z-]+)*[[:space:]]*$'

  grep --silent --no-messages -E "$regex_flakes" $NIX_CONFIG_FILE
}

# ВНИМАНИЕ! Работает только для пакетов, у которых бинарник называется
# так же, как cам пакет
is_enabled_system_packages() {

  local packages="$1"
  local file

  for file in $packages; do
    if [[ ! -e "/run/current-system/sw/bin/$file" ]]; then
      return 1
    fi
  done

  return 0
}

generate_ssh_keys() {

  local hostname=$1

  print_step_msg "Generating host and user SSH keys"
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

  if [[ -f $keyfile ]]; then
    $sudo ssh-keygen -f "$keyfile" -c -C "$username@$hostname" -q > /dev/null
    print_line_msg "... SSH key ${ST_DIM}$keyfile${ST_REGULAR} already exists, updated key comment"
  else
    # Сгенерировать ключ без защиты паролем
    $sudo ssh-keygen -t ed25519 -N "" -f "$keyfile" -C "$username@$hostname"
  fi
  echo
}

verify_github_token() {

  print_step_msg "GitHub token verification"

  while true; do
    if [ ! -f "$TOKEN_FILE" ]; then
      read -r -e -p "Enter GitHub token: " token
      echo "$token" > "$TOKEN_FILE"
    fi

    token=$(cat "$TOKEN_FILE")
    hash=$(echo "$token" | sha256sum | awk '{print $1}')
    hash_short=${hash:0:3}...${hash: -3}

    echo -e "─────────────────────────────────────────────────────────────"
    echo -e "GitHub token stored in the ${ST_DIM}$TOKEN_FILE${ST_REGULAR} file:"
    echo -e "  token: $token"
    echo -e "  sha256sum: $hash_short"
    echo -e "─────────────────────────────────────────────────────────────"

    read -r -p "Is this token correct? (y/n): " answer

    if [[ "$answer" =~ ^[Yy]$ ]]; then
      break
    else
      read -r -e -i "$token" -p "Edit the token: " new_token
      echo "$new_token" > "$TOKEN_FILE"
    fi
  done

  GITHUB_TOKEN=$(cat "$TOKEN_FILE")
  export GITHUB_TOKEN

  echo
  check_github_token
  pause
}

check_github_token() {

  set +o errexit
  if ! gh auth status; then
    print_error_msg "the GitHub token may have expired"
    exit 1
  fi
  set -o errexit
}

add_key_to_github() {

  local hostname=$1

  local user_pubkey_file=$SSH_KEYFILE_USER.pub
  local new_key_title="$USER-$hostname"

  local new_key_pub
  local github_keys
  local github_key_title

  print_step_msg "Adding the user's public SSH key to GitHub"

  new_key_pub="$(awk '{ print $2 }' < "$user_pubkey_file")"
  github_keys="$(gh ssh-key list)"

  print_line_msg "add user's public SSH key for ${ST_DIM}authentication${ST_REGULAR} and ${ST_DIM}signing${ST_REGULAR}:"
  print_line_msg "  title: ${ST_BOLD}$new_key_title${ST_REGULAR}"
  print_line_msg "    key: $new_key_pub"
  echo

  print_line_msg "current list of all public keys on the GitHub:"
  echo
  gh ssh-key list  # вывод в консоль отличается от вывода в пайп ($github_keys)
  pause
  echo

  for key_type in authentication signing; do
    # Получить имя ключа на GitHub по его публичной части. GitHub не позволяет
    # хранить один и тот же ключ под разными именами
    github_key_title=$(echo "$github_keys" | awk -v key="$new_key_pub" -v type="$key_type" '$3 == key && $6 == type { print $1; exit }')

    # Если на GitHub нет такого ключа
    if [[ -z "$github_key_title" ]]; then
      # Если на GitHub есть другой ключ с таким именем (фактически происходит замена ключа)
      if echo "$github_keys" | awk '{ print $1 }' | grep -q "$new_key_title"; then
        print_line_msg "... replacing user's public SSH key for ${ST_DIM}$key_type${ST_REGULAR}"
        remove_key_from_github "$new_key_title" "$key_type" "$github_keys"
      fi
    elif [[ "$github_key_title" == "$new_key_title" ]]; then
      print_line_msg "... user public SSH key ${ST_BOLD}$new_key_title${ST_REGULAR} for ${ST_DIM}$key_type${ST_REGULAR} already exists"
      continue
    else
      # Фактически происходит переименование ключа
      print_line_msg "... renaming user's public SSH key for ${ST_DIM}$key_type${ST_REGULAR} from ${ST_BOLD}$github_key_title${ST_REGULAR} to ${ST_BOLD}$new_key_title${ST_REGULAR}"
      remove_key_from_github "$github_key_title" "$key_type" "$github_keys"
    fi
    gh ssh-key add "$user_pubkey_file" --title "$new_key_title" --type "$key_type"
  done

  echo
  print_line_msg "new list of all public keys on the GitHub:"
  echo
  gh ssh-key list
}

remove_key_from_github() {

  local key_title="$1"
  local key_type="$2"
  local key_list="$3"
  local key_id

  key_id=$(echo "$key_list" | awk -v title="$key_title" -v type="$key_type" '$1 == title && $6 == type { print $5; exit }')

  # К сожалению, signing-ключи нельзя удалять командой gh ssh-key delete, получаем ошибку
  # HTTP 404: Not Found (https://api.github.com/user/keys/ID) - не тот URI. Поэтому удаляем
  # через вызов API
  if [[ "$key_type" == "signing" ]]; then
    # https://docs.github.com/en/rest/users/ssh-signing-keys?apiVersion=2022-11-28#delete-an-ssh-signing-key-for-the-authenticated-user
    gh api \
      --method DELETE \
      -H "Accept: application/vnd.github+json" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      /user/ssh_signing_keys/"$key_id"
  else
    gh ssh-key delete "$key_id" --yes
  fi
}

clone_dotfiles_repo() {

  local repo_dir="$(get_repo_dir)"

  print_step_msg "Cloning NixOS dotfiles repo"
  print_line_msg "cloning dotfiles repo ${ST_UNDERLINE}${GIT_REPO_DOTFILES}${ST_RESET} into directory ${ST_DIM}$repo_dir${ST_REGULAR}"
  echo

  if [[ -d "$repo_dir" ]]; then
    print_line_msg "... the directory ${ST_DIM}$repo_dir${ST_REGULAR} already exists"
  else
    mkdir -p "${HOME_DOTFILES_DIR}"
    git clone --recurse-submodules ${GIT_REPO_DOTFILES} "$repo_dir"
  fi

  pause
}

prepare_host_dir() {

  local hostname="$1"
  local host_dir="$(get_repo_dir)/${DOTFILES_HOSTS_SUBDIR}/${hostname}"
  local hardware_file=/etc/nixos/hardware-configuration.nix
  local pubkey_name=hostkey.pub

  print_step_msg "Preparing the host directory in the dotfiles"

  print_line_msg "making the host directory ${ST_DIM}${host_dir}${ST_REGULAR}"
  if [[ -d "$host_dir" ]]; then
    print_line_msg "... the directory ${ST_DIM}${host_dir}${ST_REGULAR} already exists"
  else
    mkdir -p "$host_dir"
  fi

  print_line_msg "copying file ${ST_DIM}${NIXOS_HW_CONFIG_FILE}${ST_REGULAR} to host directory ${ST_DIM}${host_dir}${ST_REGULAR}"
  cp "${NIXOS_HW_CONFIG_FILE}" "$host_dir"

  print_line_msg "copying host public key${ST_DIM}${SSH_KEYFILE_HOST}.pub${ST_REGULAR} to host directory ${ST_DIM}${host_dir}${ST_REGULAR} under the name ${ST_DIM}${pubkey_name}${ST_REGULAR}"
  cp $SSH_KEYFILE_HOST.pub "${host_dir}/${pubkey_name}"

  pause
}

get_repo_dir() {

  local repo_name
  repo_name="${GIT_REPO_DOTFILES##*:}"
  repo_name="${repo_name%.git}"
  repo_name="${repo_name##*/}"

  echo "${HOME_DOTFILES_DIR}/$repo_name"
}

pause() {

  echo
  echo -n -e "${CL_YELLOW}press ENTER to continue${CL_NO}"
  read -r
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
  local width=90

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
