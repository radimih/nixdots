read -p "Введите пароль для ключа: " password
echo

export AGE_KEY_PASSPHRASE="$password"
unset password

if ! expect - "@master-key-file@" <<'EOF' 2>/dev/null; then
  set timeout 30
  set key_file [lindex $argv 0]
  set passphrase $env(AGE_KEY_PASSPHRASE)

  spawn age -d -o /dev/null "$key_file"

  expect {
    -re "(?i)passphrase" {
      send "$passphrase\r"
      exp_continue
    }
    timeout {
      puts stderr "Таймаут: не получен запрос пароля за 30 секунд"
      exit 1
    }
    eof
  }
  catch wait result
  exit [lindex $result 3]
EOF
    echo "Ошибка: расшифровка не удалась (код возврата: $?)"
    unset AGE_KEY_PASSPHRASE
    exit 1
fi

unset AGE_KEY_PASSPHRASE

