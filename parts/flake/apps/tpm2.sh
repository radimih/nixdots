TPM2_COMMAND=\
'sudo systemd-cryptenroll \
  --wipe-slot=tpm2 \
  --tpm2-device=auto \
  --tpm2-pcrs=0+2+7+12 \
  /dev/disk/by-partlabel/root'

CL_GREEN='\033[0;32m'
CL_NO='\033[0m'
CL_YELLOW='\033[1;33m'

main() {
  update_tpm2
}

update_tpm2() {

  print_step_msg "Enroll the password for the encrypted disk into TPM2 memory"
  print_line_msg "The following command will be executed:"
  echo
  echo "${TPM2_COMMAND}"
  pause
  echo
  sudo --validate
  echo
  eval "${TPM2_COMMAND}"
}

pause() {

  echo
  echo -n -e "${CL_YELLOW}press ENTER to continue${CL_NO}"
  read -r
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
