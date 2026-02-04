# Substitutions from rekey.nix
MASTER_KEY_FILE=@master-key-file@
REKEY_COMMAND="@rekey-command@"

CL_GREEN='\033[0;32m'
CL_NO='\033[0m'
CL_RED='\033[0;31m'

main() {
  # set AGE_KEY_PASSPHRASE environment variable
  input_password
  # run agenix-rekey with password substitution
  rekey
}

input_password() {

  local password=""

  print_step_msg "Enter master password"

  while true; do
    read -r -p "Enter passphrase for master key: " password

    if expect <<EOF > /dev/null; then
      set timeout 30
      spawn age -d -o /dev/null "$MASTER_KEY_FILE"
      expect {
        -re "Enter passphrase:" {
          send "$password\r"
          exp_continue
        }
        timeout {
          exit 1
        }
        eof
      }
      catch wait result
      exit [lindex \$result 3]
EOF
      break
    else
      print_error_msg "Incorrect passphrase, please try again"
    fi
  done
  AGE_KEY_PASSPHRASE="$password"
}

rekey() {

  print_step_msg "Run agenix-rekey"

  expect <<EOF
    set timeout 300
    spawn $REKEY_COMMAND
    expect {
      -re "Type passphrase.*:" {
        send "$AGE_KEY_PASSPHRASE\r"
        exp_continue
      }
      timeout {
        exit 1
      }
      eof
    }
    catch wait result
    exit [lindex \$result 3]
EOF
}

print_error_msg() {

  echo
  echo -e "${CL_RED}$1${CL_NO}"
  echo
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
